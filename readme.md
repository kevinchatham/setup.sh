# WSL Ubuntu 20.04 Setup

This script will completely configure the current [WSL](https://docs.microsoft.com/en-us/windows/wsl/) environment. It has only been tested on the `Ubuntu 20.04` image

### Instructions

Just clone and run `setup.sh`

```
cd ~
git clone https://github.com/kevinchatham/wsl-ubuntu-setup
chmod +x ~/wsl-ubuntu-setup/setup.sh
~/wsl-ubuntu-setup/setup.sh
```

### Reset

The current WSL environment can be reset with one of these windows commands.

WSL v1: `wslconfig /unregister ubuntu`

WSL v2: `wsl --unregister ubuntu`

### Microsoft Store

If you do not have access to the Microsoft Store to install the Ubuntu image, please see [this documentation](https://docs.microsoft.com/en-us/windows/wsl/install-manual) (see Downloading Distributions).