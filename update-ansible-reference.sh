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

  echo "git add $2"
  cd ".."
  git add $2
  git commit -m "Updated ansible $2 submodule." --author "Bot<lsampaioweb+bot@gmail.com>"
  echo "git push"
  git push

  # Go back to the original directory.
  popd
  echo -e "Finished.\n"
}

updatingCommonSubModule() {
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/dhcp/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/dns/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/firewall/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/jump-server/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/load-balancer/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/ntp/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/projects/openssl-certificates/roles/common/" "common"
  updatingSubModule "../datacenter/projects/proxmox-cluster/roles/common/" "common"
}

updatingKvmSetupSubModule() {
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-raw/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-standard/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-server-std-docker/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-raw/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/packer/proxmox-ubuntu-22-04-desktop-standard/ansible/roles/kvm_setup/" "kvm_setup"
}

updatingCommonSubModule
updatingKvmSetupSubModule
