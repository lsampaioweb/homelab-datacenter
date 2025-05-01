#!/bin/bash

# Usage:
# ./update-packer-reference.sh

updatingSubModule() {
  # Save the current directory.
  pushd "."

  echo "git pull on $1"
  cd "$1"
  git submodule init
  git pull --recurse-submodules

  echo "git add $2"
  cd ".."
  git add $2
  git commit -m "Updated Packer submodule." --author "Bot<lsampaioweb+bot@gmail.com>"
  echo "git push"
  git push

  # Go back to the original directory.
  popd
  echo "Finished."
}

updatingSubModule "../datacenter/02-packer/10-proxmox-ubuntu-server-raw/packer/iso/" "iso"
updatingSubModule "../datacenter/02-packer/11-proxmox-ubuntu-server-standard/packer/clone/" "clone"
updatingSubModule "../datacenter/02-packer/12-proxmox-ubuntu-server-std-docker/packer/clone/" "clone"

updatingSubModule "../datacenter/02-packer/20-proxmox-ubuntu-desktop-raw/packer/clone/" "clone"
updatingSubModule "../datacenter/02-packer/21-proxmox-ubuntu-desktop-standard/packer/clone/" "clone"
