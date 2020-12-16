#!/usr/bon/env python


import os
import sys
import tarfile

_, arc, *files = sys.argv

files_map = {}
for f in files:
    files_map[os.path.basename(f)] = f


with tarfile.open(arc, 'r') as tar:
    for x in tar.getnames():
        if os.path.basename(x) in files_map:
            with tar.extractfile(x) as f:
                with open(files_map[os.path.basename(x)], 'wb') as ff:
                    ff.write(f.read())
