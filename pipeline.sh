#!/bin/bash
set -e # Abort if there is an issue with any build.

cd proxmox-ubuntu-22-04-server-raw/packer/
./pipeline.sh
cd ../../

cd proxmox-ubuntu-22-04-server-standard/packer/
./pipeline.sh
cd ../../

cd proxmox-ubuntu-22-04-desktop-raw/packer/
./pipeline.sh
cd ../../

cd proxmox-ubuntu-22-04-desktop-standard/packer/
./pipeline.sh
cd ../../
