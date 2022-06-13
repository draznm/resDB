#!/usr/bin/python
#
# Command line arguments:
# [1] -- Number of server nodes
# [2] -- Name of result file

import os
import sys
import datetime
import re
import shlex
import subprocess
import itertools
from sys import argv
from hostnames import *
import socket




dashboard = None
home_directory = "/rhome/tmane002/"
PATH = os.getcwd()
#result_dir = PATH + "/results/"
result_dir = home_directory+"/resilientdb/results/"

# Total nodes
nds = int(argv[1])
resfile = argv[2]
run = int(argv[3])
send_ifconfig = True

#cmd = "mkdir -p {}".format(result_dir)
# os.system(cmd)
cmd = "cp config.h {}".format(result_dir)
os.system(cmd)


machines = hostip
mach = hostmach

#	# check all rundb/runcl are killed
cmd = './vcloud_cmd.sh \"{}\" \"pkill -f \'rundb\'\"'.format(' '.join(machines))
print(cmd)
os.system(cmd)
cmd = './vcloud_cmd.sh \"{}\" \"pkill -f \'runcl\'\"'.format(' '.join(machines))
print(cmd)
# cmd = './vcloud_cmd.sh \"{}\" \"mkdir -p \'resilientdb\'\"'.format(' '.join(machines))
# print(cmd)
os.system(cmd)
