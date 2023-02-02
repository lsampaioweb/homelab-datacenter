#!/bin/bash
set -e # Abort if there is an issue with any build.

# ./pipeline-deploy.sh staging
# ./pipeline-deploy.sh production

TIMEFORMAT='Deploy took %R seconds.'
time {

runningTerraformApply() {
  echo "Deploying $1"
  cd "$1"
    ./tf.sh apply $2 -auto-approve
  cd -
}

runningTerraformApply "../datacenter/projects/load-balancer/terraform/" $1

}

