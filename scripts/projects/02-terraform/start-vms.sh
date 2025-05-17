#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./start-vms.sh

# Run these commands on the node that has the template files.
# PVE-01
qm start 910
qm start 901

# PVE-02
qm start 911
qm start 902
qm start 900
