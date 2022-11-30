#!/bin/bash
set -e # Abort if there is an issue with any build.

TIMEFORMAT='It took %R seconds.'
time {

runOpenSSLDailyActions() {
  echo "Running Open SSL Certificate"
  cd openssl_certificates
  
  ansible-playbook site.yml

  cd -
}

runJumpServerDailyActions() {
  echo "Running JumpServer"
  cd jump-server
  
  ansible-playbook site.yml

  cd -
}

runProxmoxClusterDailyActions() {
  echo "Running Proxmox Cluster"
  cd proxmox-cluster/
  
  ansible-playbook control_machine.yml
  ansible-playbook host_machines.yml

  cd -
}

runOpenSSLDailyActions
runJumpServerDailyActions
runProxmoxClusterDailyActions

}
