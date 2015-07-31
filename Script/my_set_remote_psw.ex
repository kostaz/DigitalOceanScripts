#!/usr/bin/expect -f

if { $argc != 3 } {
    puts stderr "wrong usage"
    exit 2
}

    set host     [lindex $argv 0]
    set init_psw [lindex $argv 1]
    set psw      [lindex $argv 2]

    spawn ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$host

    expect "assword:"
    send "$init_psw\n"
    expect "assword:"
    send "$init_psw\n"

    expect "assword:"
    send "$psw\n"
    expect "assword:"
    send "$psw\n"

    expect ":~#"
    send "exit\n"
