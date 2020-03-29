#!/bin/bash

# Command line variable is $1

if [ -n "$1" ]; then
  echo "Package to install is $1"
else
  echo "Package to install not supplied."
  exit
fi

ansible all -i /home/robef3/ansible2/inv.yml -u vagrant -b -m yum -a "name=$1 state=present"
