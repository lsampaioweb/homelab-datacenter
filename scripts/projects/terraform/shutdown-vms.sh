#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./shutdown-vms.sh

# Run these commands on the node that has the template files.
# PVE-01
qm shutdown 910
qm shutdown 901

# PVE-02
qm shutdown 911
qm shutdown 902
qm shutdown 900
