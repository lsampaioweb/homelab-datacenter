#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./templates.sh validate home
#   $1 -> validate, build.
#   $2 -> home, homelab.

runningPackerBuild() {
  TIMEFORMAT='Build took %R seconds.'
  time {
    echo "Running $1 with commands: $2 - $3"
    cd "../datacenter/02-packer/$1"
      ./pkr.sh $2 $3
    cd -
    echo "Finished $1"
  }

  echo ""
}

function createTemplates() {
  runningPackerBuild "03-proxmox-ubuntu-22-04-server-raw/packer/" $1 $2
  runningPackerBuild "04-proxmox-ubuntu-22-04-server-standard/packer/" $1 $2
  runningPackerBuild "05-proxmox-ubuntu-22-04-server-std-docker/packer/" $1 $2
  # runningPackerBuild "06-proxmox-ubuntu-22-04-server-std-k3s/packer/" $1 $2

  runningPackerBuild "07-proxmox-ubuntu-22-04-desktop-raw/packer/" $1 $2
  runningPackerBuild "08-proxmox-ubuntu-22-04-desktop-standard/packer/" $1 $2
}

createTemplates $1 $2

# # Run these commands on the node that has the template files.
# : << 'MULTILINE-COMMENT'
# qm destroy 931 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 921 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 914 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 913 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 912 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 911 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 901 --purge 1 --destroy-unreferenced-disks 1
# MULTILINE-COMMENT
