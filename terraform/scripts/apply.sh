#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./vms.sh staging
# ./vms.sh production

TIMEFORMAT='Deploy took %R seconds.'
time {

runningTerraformApply() {
  echo "Deploying $1"
  cd "$1"
    ./tf.sh apply $2 -auto-approve
  cd -
}

# runningTerraformApply "../datacenter/06-projects/01-working-machine/terraform/" $1
runningTerraformApply "../datacenter/06-projects/04-load-balancer/terraform/" $1
# runningTerraformApply "../datacenter/06-projects/05-backup-manager/terraform/" $1
runningTerraformApply "../datacenter/06-projects/06-dhcp/terraform/" $1
runningTerraformApply "../datacenter/06-projects/07-dns/terraform/" $1
runningTerraformApply "../datacenter/06-projects/08-ntp/terraform/" $1
}
