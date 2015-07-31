#!/usr/bin/env python3

import os
import getopt
import pexpect
import sys

def ssh_disable_strict_host_key_checking(ip, config_file):
    config_file = "~/.ssh/config"
    config_file = os.path.expanduser(config_file)
    fo = open(config_file, "a")
    fo.write("Host " + ip + "\n\tStrictHostKeyChecking no\n")
    fo.close

def main(argv):
    print("Starting ...")

    try:
        opts, args = getopt.getopt(argv, "h", ["help", "ip=", "password="])
    except getopt.GetopError:
        print("Exc")
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print("Got: " + opt + ": " + arg)
            sys.exit()
        elif opt == "--ip":
            print("Got: " + opt + ": " + arg)
            ip = arg
        elif opt == "--password":
            print("Got: " + opt + ": " + arg)

    ssh_disable_strict_host_key_checking(ip, "~/.ssh/config")

    print("... finished.")

if __name__ == '__main__':
    main(sys.argv[1:])
