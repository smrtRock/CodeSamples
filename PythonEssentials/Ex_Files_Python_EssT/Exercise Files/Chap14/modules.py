#!/usr/bin/env python3
# Copyright 2009-2017 BHG http://bw.org/

import sys
import os

def main():
    v = sys.version_info
    print('Python version {}.{}.{}'.format(*v))
    o = os.name
    print(o)
if __name__ == '__main__': main()
