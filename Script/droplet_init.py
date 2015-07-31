#!/usr/bin/python3

import getopt
import os.path
import pexpect
import sys

def main(argv):
    print("Starting main...")

    # child = pexpect.spawn('ssh 178.62.18.112')

    file = ''

    try:
        opts, args = getopt.getopt(argv, "h", ["help", "ip=", "password="])
    except getopt.GetopError:
        print("Exc")
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print("Usage: ...")
            sys.exit()
        elif opt == "--ip":
            print("Got --ip")
        elif opt == "--password":
            print("Got --password")

if __name__ == '__main__':
    main(sys.argv[1:])
