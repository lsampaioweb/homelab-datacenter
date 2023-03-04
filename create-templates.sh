#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./pipeline-template.sh

TIMEFORMAT='Build took %R seconds.'
time {

runningPackerBuild() {
  echo "Running $1"
  cd "$1"
    ./pkr.sh build staging
    # ./pkr.sh build production
  cd -
  echo -e "Finished $1\n"
}

runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/packer/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/packer/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/packer/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/packer/"
runningPackerBuild "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/packer/"
runningPackerBuild "../datacenter/projects/firewall/packer/"

}

# Run these commands on the node that has the template files.
: << 'MULTILINE-COMMENT'
qm destroy 905 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 904 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 903 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 902 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 901 --purge 1 --destroy-unreferenced-disks 1; \
qm destroy 900 --purge 1 --destroy-unreferenced-disks 1
MULTILINE-COMMENT
