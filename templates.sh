#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./template.sh validate staging
#   $1 -> validate, build.
#   $2 -> staging, production.

runningPackerBuild() {
  TIMEFORMAT='Build took %R seconds.'
  time {
    echo "Running $1"
    cd "../datacenter/packer/$1"
      ./pkr.sh $2 $3
    cd -
    echo "Finished $1"
  }

  echo -e "\n"
}

runningPackerBuild "proxmox-ubuntu-22-04-server-raw/packer/" $1 $2
runningPackerBuild "proxmox-ubuntu-22-04-server-standard/packer/" $1 $2
runningPackerBuild "proxmox-ubuntu-22-04-server-std-docker/packer/" $1 $2
runningPackerBuild "proxmox-ubuntu-22-04-desktop-raw/packer/" $1 $2
runningPackerBuild "proxmox-ubuntu-22-04-desktop-standard/packer/" $1 $2
# runningPackerBuild "firewall/packer/" $2 $3

# Run these commands on the node that has the template files.
: << 'MULTILINE-COMMENT'
qm destroy 905 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 904 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 903 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 902 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 901 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 900 --purge 1 --destroy-unreferenced-disks 1
MULTILINE-COMMENT
