#!/usr/bin/python
# transposes a csv

import sys

for c in zip(*(l.strip().split(",") for l in sys.stdin.readlines() if l.strip())):
    print(','.join(c))
