## Ubuntu Setup 

### Instructions

Clone and run `setup.sh`

```bash
cd ~
git clone https://github.com/kevinchatham/ubuntu-setup.git
chmod +x ~/ubuntu-setup/setup.sh
~/ubuntu-setup/setup.sh
```

- You will be prompted to configure `zsh`. Use the default options and `exit` when dropped into the new shell. Everything should continue normally after that.

## WSL

### Resetting Ubuntu

Ubuntu can be reset with one of these commands.

For WSL v1:
```batch
wslconfig /unregister Ubuntu && ubuntu
```

For WSL v2:
```batch
wsl --unregister Ubuntu && ubuntu
```

### Install Ubuntu Without Microsoft Store

If you do not have access to the Microsoft Store, don't worry, Ubuntu can be manually installed. Please see [this documentation](https://docs.microsoft.com/en-us/windows/wsl/install-manual) (at Downloading Distributions) for more details. Note that you will need to [install WSL](https://docs.microsoft.com/en-us/windows/wsl/install) first.

Manually Install Ubuntu 20.04 (using PowerShell):
```powershell
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing | Add-AppxPackage .\Ubuntu.appx
```
