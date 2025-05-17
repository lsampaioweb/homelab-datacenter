#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./destroy-templates.sh

# Run these commands on the node that has the template files.
# PVE-01
qm destroy 910 --purge 1 --destroy-unreferenced-disks 1
qm destroy 901 --purge 1 --destroy-unreferenced-disks 1

# PVE-02
qm destroy 911 --purge 1 --destroy-unreferenced-disks 1
qm destroy 902 --purge 1 --destroy-unreferenced-disks 1
qm destroy 900 --purge 1 --destroy-unreferenced-disks 1
