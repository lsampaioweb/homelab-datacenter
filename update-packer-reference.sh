#!/bin/bash
# set -e # Abort if there is an issue when running.

# Usage:
# ./update-packer-reference.sh

updatingSubModule() {
  # Save the current directory.
  pushd "."

  echo "git pull on $1"
  cd "$1"
  git pull

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

updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/packer/iso/" "iso"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/packer/clone/" "clone"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/packer/clone/" "clone"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-std-k3s/packer/clone/" "clone"

updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/packer/clone/" "clone"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/packer/clone/" "clone"
