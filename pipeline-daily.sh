#!/bin/bash
set -e # Abort if there is an issue with any build.

TIMEFORMAT='It took %R seconds.'
time {

runOpenSSLDailyActions() {
  echo "Running Open SSL Certificate"
  cd "projects/openssl_certificates"
  
  ansible-playbook site.yml

  cd -
}

runJumpServerDailyActions() {
  echo "Running JumpServer"
  cd "projects/jump-server"
  
  ansible-playbook site.yml

  cd -
}

runProxmoxClusterDailyActions() {
  echo "Running Proxmox Cluster"
  cd "projects/proxmox-cluster"
  
  ansible-playbook control_machine.yml
  ansible-playbook host_machines.yml

  cd -
}

runOpenSSLDailyActions
runJumpServerDailyActions
runProxmoxClusterDailyActions

}
