#!/usr/bin/expect -f

if { $argc != 3 } {
    puts stderr "wrong usage"
    exit 2
}

    set host [lindex $argv 0]
    set pass [lindex $argv 1]
    set user [lindex $argv 2]

    spawn ssh-copy-id $user@$host
    expect "assword:"
    send "$pass\n"
    expect eof
