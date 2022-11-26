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

runJumpServerDailyActions

}
