Arbeiten in der Shell (Bash)
============================

verschiedene Shells
-------------------
* bash
* /bin/sh
* zsh
* ksh
* etc.

cd
--
* cd DIR
* cd ..
* cd ~

ls
--
* ls
* Farbe
* ls -l
* ls -latr
* man ls - siehe Paragraph "man"
* tree
  - siehe Paketverwaltung
 
Pfad-Vervollständigung ("globing")
----------------------------------

::

    *
    **/*.c

man
---
* man man
* man -w -a
* man -l
* sections

Docu
----
* /usr/share/doc

Dateien anzeigen
----------------
* cat
* cat -n
* less
* less -r

Varianten von Anzeigen
----------------------
* tac
* tail
  - tail -f
  - tail -f mit mehreren dateien
  - tail -n
* head

Logs
----
* /var/log
  - system
  - kern

Was geht?
---------
* ps
* ps -ef
* ps auxw
  - was sieht man da?
  - siehe nächsten Paragraph
* ps faux
* ps mit eigenen Feldern

Daemons, Kernel Threads
-----------------------
* [
* pstree
* pstree -a -n
* ps mit eigenen Feldern
* /etc/init.d
* /etc/init
* /etc/systemd/system

Speicher und Prozesse
---------------------
* smem
* top

Dateien finden
--------------
* find
* find -exec
* man find
* find -newer
* find -type

Sachen in Dateien finden
------------------------
* grep
* grep -C
* grep --color
* man 7 regex
* grep -r
* grep -R
* ack

Paketverwaltung
---------------
* http://packages.debian.org
* dpkg -i
* dpkg -P
* dpkg -r
* dpkg -S
* dpkg -L
* apt-get install
* apt-get remove
* aptitude
* yum/rpm

Tab Completion
--------------
* bash-completion
* CTRL-r
* TAB-TAB
* $PATH

Command Options
---------------
* short options

  - dpkg -i

* long options

  - dpkg --install

* commands

  - apt-get install

Kommando-Alias
--------------

* alias

  - alias cdx="cd irgendwo"
  - ~/.bashrc
  - ~/.bash_aliases
  - Nachteile

    * kein Pfad
    * kann nicht von anderen Scripts verwendet werden

Umleiten
--------
* >
* <
* >>
* 2>&1
* &>
* |

Iterieren
---------
* ls | while read x; do
* for i in 1 2 3; do
* for i in `seq 1 10`; do

Quoting
-------
* for in in `seq 1 10`
* for in in $( seq 1 10 )
* "$foo"
  - foo="a b"
* `$foo`
* '$foo'
* '\''
* Space als Separator

Variablen
---------
* A=7
* a=7
* a="a b c"

Scripte Schreiben
-----------------
* history

Editoren
--------
* nano
* vim
  - i
  - r
  - Esc
  - :w
  - :q!
* emacs

Hashbang
--------
* #!

Filesystem Layout
-----------------
* /etc
* /bin, /usr, /lib, /boot
* /run
* /var
* /mnt
* /media
* /dev
* /sys
* /proc
* /proc/id
* /home
* ~/.dotfiles
* ~/.config
* ~/.cache
* ~/.local -> daten

Skript anschauen
----------------
* /etc/init.d/*

SSH
---
* ssh
* sshfs

sed
---

awk, perl
---------

Othogonalität
-------------
* ssh + shell

