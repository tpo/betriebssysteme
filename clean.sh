#!/bin/sh
#
# Docu:
# - https://en.wikipedia.org/wiki/XPath
# - http://xmlstar.sourceforge.net/doc/xmlstarlet.txt

help() {
   echo 'usage: clean.sh Script.odp'
   echo '       clean.sh --help'
   echo
   echo "  clean up Mandl's original lecture presentation:"
   echo "  * remove duplicate footer elements"
   echo "  * remove page transition animations"
   echo "  * remove references to 'Wirtschaftsinformatik'"
   echo
   exit 1
}

[ "$1" == "--help" ] && help

set -e # exit on error

if [ "$1" = "--debug" ]; then
  DEBUG=1
  shift
else
  DO_NOT_INSERT_SPACE=-P
fi

doc="$1"

[ -z   "$doc" ] && help
[ ! -e "$doc" ] && echo "ERROR: didn't find a document named '$doc'. Exiting" && exit 1

origdir=`pwd`
tmpdir=`mktemp -d /tmp/clean.XXXXXX`

cp "$doc" "$tmpdir/"

cd "$tmpdir"

mv "$doc" "$doc.zip"

unzip "$doc.zip" >/dev/null

rm "$doc.zip"


# <draw:frame draw:name="Fußzeilenplatzhalter 4" presentation:style-name="pr1" draw:text-style-name="P2" draw:layer="layout" svg:width="8.042cm" svg:height="1.269cm" svg:x="8.678cm" svg:y="17.78cm" presentation:class="footer" presentation:user-transformed="true"><draw:text-box><text:p text:style-name="P1"><text:span text:style-name="T1">Betriebssysteme</text:span></text:p><text:p text:style-name="P1"><text:span text:style-name="T2"/></text:p></draw:text-box></draw:frame>
#
# ed - edit
# -d - delete
# -P - preserve white space
#
# /   - starting from root select
# *   - any element
# //  - any descendant (!= child!)
# draw:frame - name of element
# [   - when
# .   - this element's
# //* - random descendant
# [   - when that descendant
# text()='Betriebssysteme' - when the text of the element is 'Betriebssysteme'
#
# Remove random page transitions, they are annoying:
#   Remove from elements <style:drawing-page-properties...> the attribute "smil:type="random":
#     -d "//style:drawing-page-properties/@smil:type"
#
# Remove all transition animation definitions, they are annoying:
#   Remove all elements <anim:par ...>
#     -d "//anim-par"
#
cat content.xml                                                    | \
xmlstarlet ed $DO_NOT_INSERT_SPACE                                   \
	      -d "/*//draw:frame[.//*[text()='Betriebssysteme']]"  | \
xmlstarlet ed $DO_NOT_INSERT_SPACE                                   \
              -d "/*//draw:frame[.//*[text()='Seite ']]"           | \
xmlstarlet ed $DO_NOT_INSERT_SPACE                                   \
              -d "//style:drawing-page-properties/@smil:type"      | \
xmlstarlet ed $DO_NOT_INSERT_SPACE                                   \
              -d "//anim:par"        \
> content_edited.xml
#
# <dc:title>Wirtschaftsinformatik</dc:title>
# -u - update
# -v - value
#
cat meta.xml                                                      | \
xmlstarlet ed $DO_NOT_INSERT_SPACE                                  \
	      -u "/*//dc:title[text()='Wirtschaftsinformatik']"     \
	      -v "MAS: Betriebssysteme"                             \
> meta_edited.xml

# preserve copy with spaces for debugging
if [ "$DEBUG" ]; then
  xmlstarlet ed content.xml > content_orig.xml
  xmlstarlet ed meta.xml    > meta_orig.xml
fi

mv content_edited.xml content.xml
mv meta_edited.xml meta.xml

zip -r "$origdir/new_$doc" * > /dev/null

# don't remove if you want to debug
if [ "$DEBUG" ]; then
  echo "Please remove workdir '$tmpdir' when you're done"
else
  rm -R "$tmpdir"
fi
