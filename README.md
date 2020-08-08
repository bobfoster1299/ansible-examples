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
Here is an example of running the ansible playbook create_users.yml against just host centos-7-1:
```
ansible-playbook -i inv.yml --limit centos-7-1 -u ansible create_users.yml
```

# Files
[inv.yml](inv.yml) - Inventory file.

[create_users.yml](create_users.yml) - Creates multiple users. 

[install_package.yml](install_package.yml) - Installs package, starts and enables service, creates file, appends line to file.

[add_line_when.yml](add_line_when.yml) - Appends line to file when hostname matches.

[register_output.yml](register_output.yml) - Registers output of task, displays output to terminal, writes one element of the output to a file.

[block.yml](block.yml) - Uses block task to download a file from a URL and copy it to a destination. Rescue task shows if it fails.

[ignore_errors.yml](ignore_errors.yml) - Downloads files from multiple URLs and reports task completed successfully even if some downloads failed. 

[stop_service.yml](stop_service.yml) - Stops and disables service.

[replace.yml](replace.yml) - Downloads a file and replaces some lines in it using a regular expression. If the file cannot be downloaded displays a debug error. 

[handler.yml](handler.yml) - Replaces line in file and notifies handler to restart service.

[unarchive.yml](unarchive.yml) - Installs apache, starts and enables service, downloads content from URL, unarchives it.

[template_example/*](template_example) - Creates a file which contains facts about the target.

[tags/*](tags) - Contains two host groups. On first group copies file to target. On second creates directory and copies file into it. Some of the tasks are tagged so you can run only the tagged tags like this:
```
ansible-playbook -i ../inv.yml -u ansible tags.yaml --tags dbdeploy
```

[variables/*](variables) - Assigns a file path to a variable and creates a file from the variable. You reference another file called user.lst via the command line to populate the file:
```
ansible-playbook -i ../inv.yml --limit centos-7-1 -u ansible user_list.yaml -e "@users.lst"
```