#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./update-repos.sh

# Source common functions and variables.
. $(dirname "$0")/../../lib/common.sh
. $(dirname "$0")/vars/variables.sh

# Create logs directory with date if it doesn't exist.
create_directory "$LOG_DIR"

# Redirect output to both console and log file.
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

update_git_repository() {
  local dir="$1"
  local repo="$2"
  log_info "Updating $repo at $dir."

  navigate_to_dir "$dir/$repo"

  git pull || { log_error "Git pull failed"; return_to_previous_dir; return 1; }
  git submodule update --init --recursive || { log_error "Submodule update failed"; return_to_previous_dir; return 1; }
  git submodule sync || { log_error "Submodule sync failed"; return_to_previous_dir; return 1; }

  # Check for new submodule commits.
  if git status --porcelain | grep -q .; then
    log_info "New submodule commits detected, committing..."
    git add .
    git commit -m "chore: Update submodule commits" --author "Bot<lsampaioweb+bot@gmail.com>" || { log_error "Commit failed"; return_to_previous_dir; return 1; }
    git push origin main || { log_error "Push failed"; return_to_previous_dir; return 1; }
  fi

  return_to_previous_dir
}

# Navigate to the git directory.
navigate_to_dir "$HOME/git"

# Git.
measure_time "Updating homelab-datacenter" update_git_repository "$HOME/git" "homelab-datacenter"
measure_time "Updating git-template-repository" update_git_repository "$HOME/git" "git-template-repository"

# Ansible.
measure_time "Updating ansible-common-tasks" update_git_repository "$HOME/git/datacenter/01-ansible" "ansible-common-tasks"
measure_time "Updating ansible-kvm-cloud-init" update_git_repository "$HOME/git/datacenter/01-ansible" "ansible-kvm-cloud-init"

# Packer.
measure_time "Updating 01-packer-proxmox-ubuntu-iso" update_git_repository "$HOME/git/datacenter/02-packer" "01-packer-proxmox-ubuntu-iso"
measure_time "Updating 02-packer-proxmox-ubuntu-clone" update_git_repository "$HOME/git/datacenter/02-packer" "02-packer-proxmox-ubuntu-clone"
measure_time "Updating 10-proxmox-ubuntu-server-raw" update_git_repository "$HOME/git/datacenter/02-packer" "10-proxmox-ubuntu-server-raw"
measure_time "Updating 11-proxmox-ubuntu-server-standard" update_git_repository "$HOME/git/datacenter/02-packer" "11-proxmox-ubuntu-server-standard"
measure_time "Updating 12-proxmox-ubuntu-server-std-docker" update_git_repository "$HOME/git/datacenter/02-packer" "12-proxmox-ubuntu-server-std-docker"
measure_time "Updating 20-proxmox-ubuntu-desktop-raw" update_git_repository "$HOME/git/datacenter/02-packer" "20-proxmox-ubuntu-desktop-raw"
measure_time "Updating 21-proxmox-ubuntu-desktop-standard" update_git_repository "$HOME/git/datacenter/02-packer" "21-proxmox-ubuntu-desktop-standard"

# Terraform.
measure_time "Updating 01-terraform-random-target-node" update_git_repository "$HOME/git/datacenter/03-terraform" "01-terraform-random-target-node"
measure_time "Updating 02-terraform-local-dynamic-inventory" update_git_repository "$HOME/git/datacenter/03-terraform" "02-terraform-local-dynamic-inventory"
measure_time "Updating 03-terraform-proxmox-vm-qemu" update_git_repository "$HOME/git/datacenter/03-terraform" "03-terraform-proxmox-vm-qemu"
measure_time "Updating 04-terraform-proxmox-homelab-project" update_git_repository "$HOME/git/datacenter/03-terraform" "04-terraform-proxmox-homelab-project"

# Docker.
measure_time "Updating custom-docker-images" update_git_repository "$HOME/git/datacenter/04-docker" "custom-docker-images"

# Spring Boot.
measure_time "Updating spring-boot-tutorial" update_git_repository "$HOME/git/datacenter/05-spring-boot" "spring-boot-tutorial"

# Projects.
measure_time "Updating 01-working-machine" update_git_repository "$HOME/git/datacenter/06-projects" "01-working-machine"
measure_time "Updating 02-openssl-certificates" update_git_repository "$HOME/git/datacenter/06-projects" "02-openssl-certificates"
measure_time "Updating 03-proxmox-cluster" update_git_repository "$HOME/git/datacenter/06-projects" "03-proxmox-cluster"
measure_time "Updating 04-load-balancer" update_git_repository "$HOME/git/datacenter/06-projects" "04-load-balancer"
measure_time "Updating 05-backup-manager" update_git_repository "$HOME/git/datacenter/06-projects" "05-backup-manager"
measure_time "Updating 06-dhcp" update_git_repository "$HOME/git/datacenter/06-projects" "06-dhcp"
measure_time "Updating 07-dns" update_git_repository "$HOME/git/datacenter/06-projects" "07-dns"
measure_time "Updating 08-ntp" update_git_repository "$HOME/git/datacenter/06-projects" "08-ntp"
measure_time "Updating 09-bitcoin-puzzle" update_git_repository "$HOME/git/datacenter/06-projects" "09-bitcoin-puzzle"
measure_time "Updating 10-vault-chromium-extension" update_git_repository "$HOME/git/datacenter/06-projects" "10-vault-chromium-extension"
measure_time "Updating xx-gitea" update_git_repository "$HOME/git/datacenter/06-projects" "xx-gitea"
measure_time "Updating xx-jenkins" update_git_repository "$HOME/git/datacenter/06-projects" "xx-jenkins"
measure_time "Updating xx-jenkins-shared-pipeline-libraries" update_git_repository "$HOME/git/datacenter/06-projects" "xx-jenkins-shared-pipeline-libraries"
measure_time "Updating xx-nexus" update_git_repository "$HOME/git/datacenter/06-projects" "xx-nexus"
measure_time "Updating xx-openldap" update_git_repository "$HOME/git/datacenter/06-projects" "xx-openldap"
measure_time "Updating xx-portainer" update_git_repository "$HOME/git/datacenter/06-projects" "xx-portainer"
measure_time "Updating xx-postgresql" update_git_repository "$HOME/git/datacenter/06-projects" "xx-postgresql"
measure_time "Updating xx-rabbitmq" update_git_repository "$HOME/git/datacenter/06-projects" "xx-rabbitmq"
measure_time "Updating xx-redis" update_git_repository "$HOME/git/datacenter/06-projects" "xx-redis"
measure_time "Updating xx-sonarqube" update_git_repository "$HOME/git/datacenter/06-projects" "xx-sonarqube"
measure_time "Updating xx-T1600G-28TS-SG2424" update_git_repository "$HOME/git/datacenter/06-projects" "xx-T1600G-28TS-SG2424"
measure_time "Updating xx-tplink_router_ax1800" update_git_repository "$HOME/git/datacenter/06-projects" "xx-tplink_router_ax1800"
measure_time "Updating xx-vault" update_git_repository "$HOME/git/datacenter/06-projects" "xx-vault"

# Home.
measure_time "Updating 01-backup-restic-s3-minio" update_git_repository "$HOME/git/home" "01-backup-restic-s3-minio"
measure_time "Updating 02-home-edge-esxi" update_git_repository "$HOME/git/home" "02-home-edge-esxi"
measure_time "Updating 03-home-edge-firewall" update_git_repository "$HOME/git/home" "03-home-edge-firewall"
measure_time "Updating 04-home-edge-ldap" update_git_repository "$HOME/git/home" "04-home-edge-ldap"
measure_time "Updating 05-home-edge-postgresql" update_git_repository "$HOME/git/home" "05-home-edge-postgresql"
measure_time "Updating 06-home-edge-zabbix" update_git_repository "$HOME/git/home" "06-home-edge-zabbix"
measure_time "Updating 07-home-edge-grafana" update_git_repository "$HOME/git/home" "07-home-edge-grafana"
measure_time "Updating 08-home-edge-k3s" update_git_repository "$HOME/git/home" "08-home-edge-k3s"

# Return to the original directory.
return_to_previous_dir

log_info "Git repository updates completed successfully."
