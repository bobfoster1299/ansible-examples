By Rob Foster

Updated 08/08/2020

# Introduction
This repo contains ansible example playbooks.

# Instructions
To allow a host to be managed by ansible, SSH to it and run the following commands as root:
```
useradd ansible
cd /etc/sudoers.d/
touch 10_ansible
echo "ansible    ALL=(ALL)       NOPASSWD: ALL" >> 10_ansible
chmod 440 10_ansible
systemctl restart sshd
```
Switch to the ansible user and run the following:
```
su - ansible
cd ~
mkdir .ssh
chmod 0700 .ssh
cd .ssh
touch authorized_keys
chmod 0600 authorized_keys
```
Add your SSH public key to the authorized_keys file. You should then be able to run ansible commands from your machine against the managed node without using a password.

Test that it's working:
```
ansible -i inv.yml <hostname> -m ping -u ansible
```

# Files
**inv.yml - Inventory file
