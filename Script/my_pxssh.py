#!/usr/bin/python3

import getpass
import os
import pxssh
import subprocess

def execute(cmd):
    popen = subprocess.Popen(cmd, stdout = subprocess.PIPE)
    lines_iter = iter(popen.stdout.readline, '')
    for line in lines_iter:
        print(line)

def main():
    print('Strated ---------------------')

    # execute(['ls', '-ls'])

    # proc = subprocess.Popen(['ls -lsa'], stdout = subprocess.PIPE, shell = True)
    # (out, err) = proc.communicate()
    # proc_status = proc.wait()
    # print("Command exit status: " + str(proc_status))
    # print("Command output: " + str(out))

    # output = subprocess.check_output('ls -ls', shell = True)
    # print(output)

    ip = '178.62.18.112'
    cmd = 'ssh-keygen -f ~/.ssh/known_hosts -R ' + ip
    print('CMD [' + cmd + ']')
    stdoutdata = subprocess.getoutput(cmd)
    print('------- OUTPUT START --------')
    print(stdoutdata)
    print('======= OUTPUT END   ========')

    cmd = 'echo -e \"Host ${myvmip}\n\tStrictHostKeyChecking no\n\" >> ~/.ssh/config'
    print('CMD [' + cmd + ']')
    stdoutdata = subprocess.getoutput(cmd)
    print('------- OUTPUT START --------')
    print(stdoutdata)
    print('======= OUTPUT END   ========')

    # s = pxssh.pxssh()
    # s.login()
    print('Finished --------------------')

if __name__ == '__main__':
    main()
