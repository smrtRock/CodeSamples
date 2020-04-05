#!/usr/bin/env python3
# Copyright 2009-2017 BHG http://bw.org/

import sys
def main():
    try:
        x = int('foo')
    except ValueError:
        print(f'I caught a ValueError: {sys.exec_info()[1]}')
    except ZeroDivisionError:
        print('dont divide by 0')
    except:
        print('unknown error')
    else:
        print('good job')
        print(x)

if __name__ == '__main__': main()
