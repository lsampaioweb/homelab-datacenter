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

# runningTerraformApply "../datacenter/projects/jump-server/terraform/" $1
runningTerraformApply "../datacenter/projects/dhcp/terraform/" $1
runningTerraformApply "../datacenter/projects/dns/terraform/" $1
runningTerraformApply "../datacenter/projects/load-balancer/terraform/" $1
runningTerraformApply "../datacenter/projects/ntp/terraform/" $1

}
