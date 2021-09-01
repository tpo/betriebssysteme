# Used docu:
# - http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# - http://stackoverflow.com/questions/4971865/patsubst-on-makefile
# - http://blog.softwaresafety.net/2010/09/transforming-files-with-wildcards-in.html
# - http://stackoverflow.com/questions/1435861/computing-makefile-variable-on-assignment
#
TMP := $(shell mktemp -d /tmp/MAS_LibreOffice_to_PDF.XXXXXX)

#ODP_FILES := $(wildcard *.odp) # will include symlinks, which we don't want
ODP_FILES := $(shell find . -maxdepth 2 -name "*.odp" -type f)
RST_FILES := $(shell find . -maxdepth 2 -name "*.rst" -type f)
MD_FILES  := $(shell find . -maxdepth 1 -name "*.md"  -type f ! -name README.md)
SYM_FILES := $(shell find . -maxdepth 2 \( -name "*.rst" -o -name "*.odp" \) -type l)

OPDF_FILES := $(patsubst %.odp,PDF/%.pdf,$(ODP_FILES))
RPDF_FILES := $(patsubst %.rst,PDF/%.pdf,$(RST_FILES))
MPDF_FILES := $(patsubst %.md,PDF/%.pdf,$(MD_FILES))
SPDF_FILES := $(patsubst %.rst,PDF/%.pdf,$(patsubst %.odp,PDF/%.pdf,$(SYM_FILES)))

PDF/%.pdf: %.odp
	libreoffice -env:UserInstallation=file://$(TMP) --headless --invisible --convert-to pdf --outdir PDF "$<"
	# libreoffice will put the generated file directly into outdir, lets move it where it belongs
	# this only needs to be done for files in optional/ -> PDF/optional
	output_file=`echo $@|sed 's#./optional/##'`; \
	[ "$$output_file" != "$@" ] && mv $$output_file $@; \
	true

PDF/%.pdf: %.md
	pandoc --pdf-engine=xelatex --template=latex.template --standalone --self-contained --listings "$<" -o "$@"

PDF/%.pdf: %.rst
	rst2pdf --header "T.Pospíšek, MAS: Betriebssysteme, ###Title###" --footer "###Page###/###Total###" "$<" -o "$@"

# echo $(for i in $(SYM_FILES); do $(basename $i)

.PHONY: all symlinks

all: $(OPDF_FILES) $(RPDF_FILES) $(MPDF_FILES) symlinks

symlinks: 
	cd PDF && [ -h 03-1_Shell.pdf ]              || ln -s 02-1_Shell.pdf 03-1_Shell.pdf
	cd PDF && [ -h 03-2_Architekturansätze.pdf ] || ln -s 02-2_Architekturansätze.pdf 03-2_Architekturansätze.pdf

