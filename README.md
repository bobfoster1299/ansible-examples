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
su - ansible
cd ~
mkdir .ssh
chmod 0700 .ssh
cd .ssh
touch authorized_keys
chmod 0600 authorized_keys
```
Add your SSH public key to the authorized_keys file. You should then be able to run ansible commands from your machine against the managed node without using a password. 

Test that it's working by running a ping (replace centos-7-1 with the hostname of your managed node):
```
ansible -i inv.yml centos-7-1 -u ansible -m ping 
```
Here is an example of running the ansible playbook users.yml against just host centos-7-1:
```
ansible-playbook -i ../inv.yml --limit centos-7-1 -u ansible users.yml
```

# Files
[**inv.yml**](inv.yml) - Inventory file

[**playbooks/create_users.yml**](playbooks/create_users.yml) - Create multiple users. 

[**playbooks/install_package.yml**](playbooks/install_package.yml) - Install package, start and enable service, create file, append line to file.

[**playbooks/add_line_when.yml**](playbooks/add_line_when.yml) - Append line to file when hostname matches.

[**playbooks/register_output.yml**](playbooks/register_output.yml) - Register output of task, display output to terminal, and write one element of the output to a file.

[**playbooks/block.yml**](playbooks/block.yml) - Use block task to download a file from a URL and copy it to a destination. Uses a rescue task to show if it fails.

[**playbooks/ignore_error.yml**](playbooks/ignore_error.yml) - Download files from multiple URLs and report task completed successfully even if some downloads failed. 

[**playbooks/stop_service.yml**](playbooks/stop_service.yml) - Stop and disable service.

