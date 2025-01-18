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

runningTerraformApply "../datacenter/06-projects/08-ntp/terraform/" $1
runningTerraformApply "../datacenter/06-projects/07-dns/terraform/" $1
runningTerraformApply "../datacenter/06-projects/06-dhcp/terraform/" $1
runningTerraformApply "../datacenter/06-projects/05-backup-manager/terraform/" $1
runningTerraformApply "../datacenter/06-projects/04-load-balancer/terraform/" $1

}
