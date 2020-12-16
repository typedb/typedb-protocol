#!/usr/bin/env python

# Copyright (C) 2020 Grakn Labs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

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
