# WSL Ubuntu 20.04 Setup

This script will completely configure Ubuntu 20.04 in [WSL](https://docs.microsoft.com/en-us/windows/wsl/). It has only been tested on Ubuntu 20.04 WSL!

### Instructions

From Ubuntu WSL, just clone and run `setup.sh`

```bash
cd ~
git clone https://github.com/kevinchatham/wsl-ubuntu-setup
chmod +x ~/wsl-ubuntu-setup/setup.sh
~/wsl-ubuntu-setup/setup.sh
```

### Resetting WSL

The current WSL environment can be reset with one of these powershell commands.

For WSL v1: 
```powershell
wslconfig /unregister Ubuntu | Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu2004.appx -UseBasicParsing | Add-AppxPackage .\Ubuntu2004.appx
```

For WSL v2: 
```powershell
wsl --unregister Ubuntu | Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu2004.appx -UseBasicParsing | Add-AppxPackage .\Ubuntu2004.appx
```

### Install WSL Without Microsoft Store

If you do not have access to the Microsoft Store to install Ubuntu WSL, don't worry, it can be manually installed. Please see [this documentation](https://docs.microsoft.com/en-us/windows/wsl/install-manual) (at Downloading Distributions) for more details. Note that you will need to install WSL first.

Manually Install Ubuntu 20.04:
```powershell
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu2004.appx -UseBasicParsing | Add-AppxPackage .\Ubuntu2004.appx
```
