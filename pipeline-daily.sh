#!/bin/bash
set -e # Abort if there is an issue with any build.

TIMEFORMAT='It took %R seconds.'
time {

runOpenSSLDailyActions() {
  echo "Running Open SSL Certificate"
  cd "../datacenter/projects/openssl-certificates"
  
  ansible-playbook site.yml

  cd -
}

runJumpServerDailyActions() {
  echo "Running JumpServer"
  cd "../datacenter/projects/jump-server/ansible"
  
  ansible-playbook site.yml

  cd -
}

runProxmoxClusterDailyActions() {
  echo "Running Proxmox Cluster"
  cd "../datacenter/projects/proxmox-cluster"
  
  ansible-playbook site.yml

  cd -
}

runOpenSSLDailyActions
runJumpServerDailyActions
runProxmoxClusterDailyActions

}
