#!/usr/bin/python3

import getopt
import pexpect
import sys

ip = ''
password = ''

def process_params(argv):
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
            global ip
            ip = arg
        elif opt == "--password":
            print("Got --password")
            global password
            password = arg

def main(argv):
    print('Entered.')

    process_params(argv)

    ssh = 'ssh root@' + ip
    cmd = ssh + ' uname -a'
    print('Spawning: ' + cmd)
    child = pexpect.spawn(cmd)
    child.expect('password')
    child.sendline(password)
    print(child.before)
    print('Finished.')

if __name__ == '__main__':
    main(sys.argv[1:])
