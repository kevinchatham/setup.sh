#!/usr/bin/env bash

main() {
    set -e
    sudo apt install git -y
    cd ~
    rm -rf setup.sh 
    git clone https://github.com/kevinchatham/setup.sh
    chmod +x ~/setup.sh/setup.sh
    sh ~/setup.sh/setup.sh
}

main
