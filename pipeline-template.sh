#!/bin/bash
set -e # Abort if there is an issue with any build.

TIMEFORMAT='Build took %R seconds.'
time {

runningPackerBuild() {
  echo "Running $1"
  cd "packer/$1"
    ./pipeline.sh
  cd ../../../
}

# runningPackerBuild "proxmox-ubuntu-22-04-server-raw/packer/"
# runningPackerBuild "proxmox-ubuntu-22-04-server-standard/packer/"
# runningPackerBuild "proxmox-ubuntu-22-04-server-std-docker/packer/"
runningPackerBuild "proxmox-ubuntu-22-04-desktop-raw/packer/"
runningPackerBuild "proxmox-ubuntu-22-04-desktop-standard/packer/"

}
