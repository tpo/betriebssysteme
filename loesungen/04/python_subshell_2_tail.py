#!/usr/bin/python3

from subprocess import Popen, PIPE, STDOUT
p = Popen(["tail", "-f", "logfile"], stdin=PIPE, stdout=PIPE, stderr=STDOUT)
for line in p.stdout:
    print( line.decode('UTF-8'),
           end='')
