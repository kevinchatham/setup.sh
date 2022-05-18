# WSL Ubuntu 20.04 Setup

This script will completely configure the current WSL environment. It has only been tested on the `Ubuntu 20.04` wsl image

### Instructions

Clone and run `setup.sh` to configure WSL.

```
cd ~
git clone https://github.com/kevinchatham/wsl-ubuntu-setup
chmod +x ~/wsl-ubuntu-setup/setup.sh
sh ~/wsl-ubuntu-setup/setup.sh
```

### Reset

The current WSL environment can be reset with this windows command.

```
// for wsl v1
wslconfig /unregister ubuntu

// for wsl v2
wsl --unregister ubuntu
```