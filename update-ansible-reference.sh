#!/bin/bash
# set -e # Abort if there is an issue when running.

# Usage:
# ./update-ansible-reference.sh

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
  git commit -m "Updated ansible $2 submodule." --author "Bot<lsampaioweb+bot@gmail.com>"
  echo "git push"
  git push

  # Go back to the original directory.
  popd
  echo -e "Finished.\n"
}

updatingCommonSubModule() {
  updatingSubModule "../datacenter/02-packer/03-proxmox-ubuntu-22-04-server-raw/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/02-packer/04-proxmox-ubuntu-22-04-server-standard/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/02-packer/05-proxmox-ubuntu-22-04-server-std-docker/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/02-packer/06-proxmox-ubuntu-22-04-server-std-k3s/ansible/roles/common/" "common"

  updatingSubModule "../datacenter/02-packer/07-proxmox-ubuntu-22-04-desktop-raw/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/02-packer/08-proxmox-ubuntu-22-04-desktop-standard/ansible/roles/common/" "common"

  updatingSubModule "../datacenter/06-projects/01-working-machine/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/02-openssl-certificates/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/03-proxmox-cluster/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/04-load-balancer/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/05-backup-manager/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/06-dhcp/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/07-dns/ansible/roles/common/" "common"
  updatingSubModule "../datacenter/06-projects/08-ntp/ansible/roles/common/" "common"

  updatingSubModule "../home/03-home-edge-firewall/playbook/roles/common/" "common"
}

updatingKvmSetupSubModule() {
  updatingSubModule "../datacenter/02-packer/03-proxmox-ubuntu-22-04-server-raw/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/02-packer/04-proxmox-ubuntu-22-04-server-standard/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/02-packer/05-proxmox-ubuntu-22-04-server-std-docker/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/02-packer/06-proxmox-ubuntu-22-04-server-std-k3s/ansible/roles/kvm_setup/" "kvm_setup"

  updatingSubModule "../datacenter/02-packer/07-proxmox-ubuntu-22-04-desktop-raw/ansible/roles/kvm_setup/" "kvm_setup"
  updatingSubModule "../datacenter/02-packer/08-proxmox-ubuntu-22-04-desktop-standard/ansible/roles/kvm_setup/" "kvm_setup"
}

updatingCommonSubModule
updatingKvmSetupSubModule
