#!/bin/bash -x

ip=$1
initial_psw=$2
psw=$3

sudo apt-get install -y expect

ssh-keygen -f ~/.ssh/known_hosts -R $ip

# rm ~/.ssh/config
echo -e "Host ${ip}\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
cat ~/.ssh/config

# Change temporary password to constant password
./my_set_remote_psw.sh $ip $initial_psw $psw

# Copy SSH public key to enable ssh without password
if [ ! -f ~/.ssh/id_rsa]; then
    ssh-keygen -t rsa
fi
./my_ssh_config_ssh_copy_id.ex $ip $psw "root"

