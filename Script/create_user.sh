#!/bin/bash -x

### How to compile Bitcoin Core on Ubuntu 14.04
# -----------------------------------------------
# Creating new user

myuser="$1" # username
mypswd="$2" # password

#
# Create and configure new user
#
create_and_config_new_user()
{
    sudo adduser $myuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
    echo "$myuser:$mypswd" | sudo chpasswd
    sudo adduser $myuser sudo
}

create_and_config_new_user
