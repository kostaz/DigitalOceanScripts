#!/bin/bash -x

ip=$1
initial_psw=$2
psw=$3

echo "Setting ssh password to: $psw"
./my_set_remote_psw.ex $ip $initial_psw $psw
