#!/bin/bash
#set -e # Abort if there is an issue when running.

# Usage:
# ./update-ansible-reference.sh

updatingSubModule() {
  # Save the current directory.
  pushd "."

  echo "git pull on $1"
  cd "$1"
  git pull

  echo "git add common"
  cd ".."
  git add common
  git commit -m "Updated ansible common submodule."
  echo "git push"
  git push

  # Go back to the original directory.
  popd
  echo "Finished."
}

updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/ansible/roles/common/"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/ansible/roles/common/"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/ansible/roles/common/"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/ansible/roles/common/"
updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/ansible/roles/common/"
updatingSubModule "../datacenter/projects/dhcp/ansible/roles/common/"
updatingSubModule "../datacenter/projects/dns/ansible/roles/common/"
updatingSubModule "../datacenter/projects/firewall/ansible/roles/common/"
updatingSubModule "../datacenter/projects/jump-server/ansible/roles/common/"
updatingSubModule "../datacenter/projects/load-balancer/ansible/roles/common/"
updatingSubModule "../datacenter/projects/ntp/ansible/roles/common/"
updatingSubModule "../datacenter/projects/openssl-certificates/roles/common/"
updatingSubModule "../datacenter/projects/proxmox-cluster/roles/common/"
