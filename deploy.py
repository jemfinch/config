#!/usr/bin/env python

import os, sys

def homify(*args):
  return os.path.normpath(os.path.join(os.environ['HOME'], *args))

for (dirpath, dirnames, filenames) in os.walk(os.curdir):
  try:
    dirnames.remove('.git')
  except ValueError:
    pass
  for dirname in dirnames:
    hdirname = homify(dirpath, dirname)
    if not os.path.exists(hdirname):
      os.makedirs(hdirname)
  for filename in filenames:
    filename = os.path.join(dirpath, filename)
    rfilename = os.path.normpath(os.path.join(os.getcwd(), filename))
    hfilename = homify(filename)
    if not os.path.exists(hfilename): # True in case of bad symlinks, as well.
      if os.path.islink(hfilename):
        os.remove(hfilename)
      os.symlink(rfilename, hfilename)
    elif os.path.islink(hfilename):
      if os.readlink(hfilename) != rfilename:
        print >>sys.stderr, \
              'Wanted to create symlink %s => %s but symlink existed and pointed elsewhere.' % \
              (rfilename, hfilename)
    elif os.path.isfile(hfilename):
      if open(hfilename).read() == open(rfilename).read():
        os.remove(hfilename)
        os.symlink(rfilename, hfilename)
      else:
        print >>sys.stderr, \
                'Wanted to create symlink %s => %s but file existed and differs.' % \
                (rfilename, hfilename)
        os.system('diff -u %s %s' % (rfilename, hfilename))
