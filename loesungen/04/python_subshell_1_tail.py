#!/usr/bin/python

import subprocess

p = subprocess.Popen([ "/usr/bin/tail", "-n", "1", "logfile"], stdout=subprocess.PIPE, shell=False)
(output, err) = p.communicate()

print "Last line is:\n"
print output
