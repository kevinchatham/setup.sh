# SSH Keys

It's easy to forget the steps to generate a key pair to configure SSH for password-less authentication.

## Steps

Generate SSH Keys ( `laptop.rsa` + `laptop.pub` )

```
ssh-keygen -t rsa -b 4096
```

Add Remote SSH Host configuration to Laptop ( VSCode )

```
Host Ubuntu
    HostName ubuntu
    User kevin
    IdentityFile ~/.ssh/laptop.rsa
```

Add content of `laptop.pub` to authorized key file ( VM )

```
sudo nano ~/.ssh/authorized_keys
```

From there you can use `-i` with the private key file for password-less authentication.

```
ssh -i %USERPROFILE%\.ssh\laptop.rsa kevin@ubuntu
```

Disable password auth on vm

```
sudo vim /etc/ssh/sshd_config
```

Add the following

```
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PermitRootLogin no
PubkeyAuthentication yes
```

```
sudo systemctl reload ssh
```

