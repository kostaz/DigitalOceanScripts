#!/bin/bash -x

### How to compile Bitcoin Core on Ubuntu 14.04
# -----------------------------------------------
# Creating new user

myuser="$1" # username
mypswd="$2" # password

bitdir="/home/$myuser/TheStuff/Dev/Bitcoin"
coredir="/home/$myuser/TheStuff/Dev/Bitcoin/Core"
srcdir="/home/$myuser/TheStuff/Dev/Bitcoin/Core/bitcoin"

num_of_cores=`grep -c ^processor /proc/cpuinfo`
num_of_cores=$((num_of_cores + 3))

#
# Create and configure new user
#
create_and_config_new_user()
{
    sudo adduser $myuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
    echo "$myuser:$mypswd" | sudo chpasswd
    sudo adduser $myuser sudo
}

#
# Update distribution
#
update_distribution()
{
    sudo apt-get -y update
    sudo apt-get -y upgrade
}

#
# Install software packages needed for bitcoin compilation
#
install_required_packages()
{
    sudo apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev
    sudo apt-get install -y libboost-all-dev
    sudo apt-get install -y libqt5gui5
    sudo apt-get install -y libqt5core5
    sudo apt-get install -y libqt5dbus5 qttools5-dev qttools5-dev-tools
    sudo apt-get install -y libprotobuf-dev protobuf-compiler
    sudo apt-get install -y libqrencode-dev
    sudo apt-get install -y libminiupnpc-dev
    sudo apt-get install -y git
    sudo apt-get install -y axel
    sudo apt-get install -y mc
    sudo apt-get install -y expect
}

#
# Download bitcoin source code
#
clone_bitcoin_source()
{
    mkdir -p $coredir
    cd $coredir
    git clone https://github.com/bitcoin/bitcoin.git
}

#
# Download and compile Berkley DB
#
download_berkley_db()
{
    cd $bitdir
    axel -n 10 http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
    tar -xzvf db-4.8.30.NC.tar.gz
}

#
# Configure, make and install Berkley DB
#
install_berkley_db()
{
    cd $bitdir
    cd db-4.8.30.NC/build_unix/
    mkdir "${srcdir}/db4"
    ../dist/configure --enable-cxx --disable-shared --with-pic --prefix="${srcdir}/db4"
    time make -s -j $num_of_cores # 2>errlog_db4.txt
    time make -s -j $num_of_cores install
}

#
# Compile Bitcoin with Berkley DB 4.8
#
compile_bitcoin()
{
    cd $srcdir
    ./autogen.sh
    ./configure LDFLAGS="-L${srcdir}/db4/lib/" CPPFLAGS="-I${srcdir}/db4/include/"
    time make -s -j $num_of_cores
    find src/ -type f -executable | wc -l
    find src/ -type f -executable
}

#
# Run Bitcoin Daemon/QT/Client
#
run_bitcoin()
{
    cd $srcdir
    ./src/bitcoind
    ./src/bitcoin-qt
    ./src/bitcoin-cli
}

install_required_packages
clone_bitcoin_source
download_berkley_db
install_berkley_db
compile_bitcoin
