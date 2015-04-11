#!/usr/bin/python

import subprocess

p = subprocess.Popen([ "/usr/bin/tail", "-n", "1", "/var/log/kern.log"], stdout=subprocess.PIPE, shell=False)
(output, err) = p.communicate()

print "Last line is:\n"
print output
