#!/bin/bash
set -e # Abort if there is an issue with any build.

TIMEFORMAT='Build took %R seconds.'
time {

runningPackerBuild() {
  echo "Running $1"
  cd "$1"
    ./pipeline.sh
  cd ../../../
}

# runningPackerBuild "proxmox-ubuntu-22-04-server-raw/packer/"
# runningPackerBuild "packer/proxmox-ubuntu-22-04-server-standard/packer/"
# runningPackerBuild "packer/proxmox-ubuntu-22-04-server-std-docker/packer/"
# runningPackerBuild "packer/proxmox-ubuntu-22-04-desktop-raw/packer/"
# runningPackerBuild "packer/proxmox-ubuntu-22-04-desktop-standard/packer/"
runningPackerBuild "projects/firewall/packer/"

}
