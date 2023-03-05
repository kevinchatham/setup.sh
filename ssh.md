# SSH Keys

It's easy to forget the steps to generate a key pair to configure SSH for password-less authentication. This is a guide to help you remember the steps.

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
