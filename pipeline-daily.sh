#!/bin/bash
set -e # Abort if there is an issue with any build.

TIMEFORMAT='It took %R seconds.'
time {

runJumpServerDailyActions() {
  echo "Running JumpServer"
  cd jump_server
  
  ansible-playbook site.yml -K

  cd -
}
runProxmoxClusterDailyActions() {
  echo "Running Proxmox Cluster"
  cd proxmox_cluster/
  
  ansible-playbook control_machine.yml -K
  ansible-playbook host_machines.yml

  cd -
}

runJumpServerDailyActions
runProxmoxClusterDailyActions

}
