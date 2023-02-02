#!/bin/bash
set -e # Abort if there is an issue with any build.

runningPackerBuild() {
  echo "Running $1"
  cd "$1"
    git pull --recurse-submodules
  cd -
}

runningPackerBuild "../datacenter/ansible/ansible-common-tasks/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/"
runningPackerBuild "../datacenter/projects/firewall/"
runningPackerBuild "../datacenter/projects/jump-server/"
runningPackerBuild "../datacenter/projects/load-balancer/"
runningPackerBuild "../datacenter/projects/proxmox-cluster/"
