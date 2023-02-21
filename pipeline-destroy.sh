#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./pipeline-destroy.sh staging
# ./pipeline-destroy.sh production

TIMEFORMAT='Destroy took %R seconds.'
time {

runningTerraformApply() {
  echo "Destroying $1"
  cd "$1"
    ./tf.sh destroy $2 -auto-approve
  cd -
}

runningTerraformApply "../datacenter/projects/ntp/terraform/" $1
runningTerraformApply "../datacenter/projects/dns/terraform/" $1
runningTerraformApply "../datacenter/projects/dhcp/terraform/" $1
runningTerraformApply "../datacenter/projects/load-balancer/terraform/" $1
runningTerraformApply "../datacenter/projects/jump-server/terraform/" $1

}
