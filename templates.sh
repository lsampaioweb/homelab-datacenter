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
  runningPackerBuild "10-proxmox-ubuntu-server-raw/packer/" $1 $2
  runningPackerBuild "11-proxmox-ubuntu-server-standard/packer/" $1 $2
  runningPackerBuild "12-proxmox-ubuntu-server-std-docker/packer/" $1 $2

  runningPackerBuild "20-proxmox-ubuntu-desktop-raw/packer/" $1 $2
  runningPackerBuild "21-proxmox-ubuntu-desktop-standard/packer/" $1 $2
}

createTemplates $1 $2

# # Run these commands on the node that has the template files.
# : << 'MULTILINE-COMMENT'
# qm destroy 911 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 910 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 902 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 901 --purge 1 --destroy-unreferenced-disks 1; \
# qm destroy 900 --purge 1 --destroy-unreferenced-disks 1
# MULTILINE-COMMENT
