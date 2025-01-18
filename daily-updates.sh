#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./daily-updates.sh

TIMEFORMAT='It took %R seconds.'
time {

runOpenSSLDailyActions() {
  echo "Running Open SSL Certificate"
  cd "../datacenter/06-projects/02-openssl-certificates"

  ansible-playbook site.yml

  cd -
}

runJumpServerDailyActions() {
  echo "Running JumpServer"
  cd "../datacenter/06-projects/01-working-machine/ansible"

  ansible-playbook site.yml

  cd -
}

runProxmoxClusterDailyActions() {
  echo "Running Proxmox Cluster"
  cd "../datacenter/06-projects/03-proxmox-cluster"

  ansible-playbook site.yml

  cd -
}

runJumpServerDailyActions
runOpenSSLDailyActions
runProxmoxClusterDailyActions

}
