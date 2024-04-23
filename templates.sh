#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./templates.sh validate home
#   $1 -> validate, build.
#   $2 -> home, homelab.

runningPackerBuild() {
  TIMEFORMAT='Build took %R seconds.'
  time {
    echo "Running $1"
    cd "../datacenter/packer/$1"
      ./pkr.sh $2 $3
    cd -
    echo "Finished $1"
  }

  echo ""
}

function createTemplates() {
  runningPackerBuild "proxmox-ubuntu-22-04-server-raw/packer/" $1 $2

  runningPackerBuild "proxmox-ubuntu-22-04-server-standard/packer/" $1 $2
  runningPackerBuild "proxmox-ubuntu-22-04-server-std-docker/packer/" $1 $2
  # runningPackerBuild "proxmox-ubuntu-22-04-server-std-k3s/packer/" $1 $2

  runningPackerBuild "proxmox-ubuntu-22-04-desktop-raw/packer/" $1 $2
  runningPackerBuild "proxmox-ubuntu-22-04-desktop-standard/packer/" $1 $2
}

createTemplates

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
