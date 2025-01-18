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

updatingSubModule "../datacenter/02-packer/03-proxmox-ubuntu-22-04-server-raw/packer/iso/" "iso"
updatingSubModule "../datacenter/02-packer/04-proxmox-ubuntu-22-04-server-standard/packer/clone/" "clone"
updatingSubModule "../datacenter/02-packer/05-proxmox-ubuntu-22-04-server-std-docker/packer/clone/" "clone"
updatingSubModule "../datacenter/02-packer/06-proxmox-ubuntu-22-04-server-std-k3s/packer/clone/" "clone"

updatingSubModule "../datacenter/02-packer/07-proxmox-ubuntu-22-04-desktop-raw/packer/clone/" "clone"
updatingSubModule "../datacenter/02-packer/08-proxmox-ubuntu-22-04-desktop-standard/packer/clone/" "clone"
