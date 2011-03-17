#!/usr/bin/env python
# Copyright (c) 2010 Jeremiah Fincher
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

import os, sys

def homify(*args):
  return os.path.normpath(os.path.join(os.environ['HOME'], *args))

for (dirpath, dirnames, filenames) in os.walk(os.curdir):
  if dirpath == os.curdir:
    for ignored_filename in ['LICENSE']:
      try:
        filenames.remove(ignored_filename)
      except ValueError:
        pass
    for ignored_dirname in ['.git', 'scripts']:
      try:
        dirnames.remove(ignored_dirname)
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
              'Did not symlink %s => %s; link exists and points elsewhere.' % \
              (rfilename, hfilename)
    elif os.path.isfile(hfilename):
      if open(hfilename).read() == open(rfilename).read():
        os.remove(hfilename)
        os.symlink(rfilename, hfilename)
      elif 'work' in os.path.basename(filename).split('.'):
        pass # Ignore .work or work. files.
      else:
        print >>sys.stderr, \
                'Did not symlink %s => %s; file exists and differs.' % \
                (rfilename, hfilename)
        os.system('diff -u %s %s' % (rfilename, hfilename))

scripts_dir = os.path.join(os.curdir, 'scripts')
for script in sorted(os.listdir(scripts_dir)):
  os.system(os.path.join(scripts_dir, script))
