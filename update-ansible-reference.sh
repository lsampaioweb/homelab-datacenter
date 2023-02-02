#!/bin/bash
set -e # Abort if there is an issue with any build.

updatingAnsibleSubModule() {
  echo "Running $1"
  cd "$1"
    git pull --recurse-submodules
  cd -
}

updatingAnsibleSubModule "../datacenter/ansible/ansible-common-tasks/"
updatingAnsibleSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/"
updatingAnsibleSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/"
updatingAnsibleSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/"
updatingAnsibleSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/"
updatingAnsibleSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/"
updatingAnsibleSubModule "../datacenter/projects/firewall/"
updatingAnsibleSubModule "../datacenter/projects/jump-server/"
updatingAnsibleSubModule "../datacenter/projects/load-balancer/"
updatingAnsibleSubModule "../datacenter/projects/proxmox-cluster/"
