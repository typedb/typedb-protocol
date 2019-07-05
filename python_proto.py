#!/usr/bin/env python

import argparse

import sys
import re

IMPORT_PATTERN = re.compile(r'import "(?P<imported>.*)";\n')

print(sys.argv)

parser = argparse.ArgumentParser()
parser.add_argument('--pkg', help="Proto sources to preprocess")
parser.add_argument('--srcs', nargs='+', help="Proto sources to preprocess")
parser.add_argument('--outs', nargs='+', help="Outputs")

args = parser.parse_args()
print(args)

for src, out in zip(args.srcs, args.outs):
    with open(src) as srcf:
        lines = srcf.readlines()
    for i, line in enumerate(lines):
        m = IMPORT_PATTERN.match(line)
        if m:
            new_import = "/".join([
                args.pkg.replace('.', '/'),
                m.group('imported')
            ])
            lines[i] = 'import "{}";\n'.format(new_import)
    with open(out, 'w') as outf:
        outf.writelines(lines)
