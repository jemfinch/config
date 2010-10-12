#!/usr/bin/env python

import os

def homify(*args):
  return os.path.join(os.environ('HOME'), *args)

for (dirpath, dirnames, filenames) in os.walk(os.curdir):
  for dirname in dirnames:
    hdirname = homify(dirpath, dirname)
    if not os.path.exists(hdirname):
      os.makedirs(hdirname)
  for filename in filenames:
    filename = os.path.join(dirpath, filename)
    hfilename = homify(filename)
    if not os.path.exists(hfilename):
      os.symlink(filename, hfilename)
