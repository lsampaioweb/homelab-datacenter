#!/bin/bash

cd ~/git

updateGitRepository() {
  local dir="$1"
  local repo="$2"
  echo "Updating $repo at $dir"

  if [[ ! -d "$dir/$repo" ]]; then
    echo "Error: Directory $dir/$repo does not exist"
    return 1
  fi

  pushd "$dir/$repo" > /dev/null || { echo "Error: Failed to cd to $dir/$repo"; return 1; }

  git pull --recurse-submodules || { echo "Error: Git pull failed"; popd > /dev/null; return 1; }
  git submodule sync || { echo "Error: Submodule sync failed"; popd > /dev/null; return 1; }
  git submodule update --init --recursive || { echo "Error: Submodule update failed"; popd > /dev/null; return 1; }

  # Check for new submodule commits.
  if git status --porcelain | grep -q .; then
    echo "New submodule commits detected, committing..."
    git add .
    git commit -m "chore: Update submodule commits" --author "Bot<lsampaioweb+bot@gmail.com>" || { echo "Error: Commit failed"; popd > /dev/null; return 1; }
    git push origin main || { echo "Error: Push failed"; popd > /dev/null; return 1; }
  fi

  popd > /dev/null
  echo "Finished."
  echo -e "\n"
}

# Git.
updateGitRepository "homelab-datacenter"
updateGitRepository "git-template-repository"

# Ansible.
updateGitRepository "datacenter/01-ansible" "ansible-common-tasks"
updateGitRepository "datacenter/01-ansible" "ansible-kvm-cloud-init"

# Packer.
updateGitRepository "datacenter/02-packer" "01-packer-proxmox-ubuntu-iso"
updateGitRepository "datacenter/02-packer" "02-packer-proxmox-ubuntu-clone"
updateGitRepository "datacenter/02-packer" "10-proxmox-ubuntu-server-raw"
updateGitRepository "datacenter/02-packer" "11-proxmox-ubuntu-server-standard"
updateGitRepository "datacenter/02-packer" "12-proxmox-ubuntu-server-std-docker"
updateGitRepository "datacenter/02-packer" "20-proxmox-ubuntu-desktop-raw"
updateGitRepository "datacenter/02-packer" "21-proxmox-ubuntu-desktop-standard"

# Terraform.
updateGitRepository "datacenter/03-terraform" "01-terraform-random-target-node"
updateGitRepository "datacenter/03-terraform" "02-terraform-local-dynamic-inventory"
updateGitRepository "datacenter/03-terraform" "03-terraform-proxmox-vm-qemu"
updateGitRepository "datacenter/03-terraform" "04-terraform-proxmox-homelab-project"

# Docker.
updateGitRepository "datacenter/04-docker" "custom-docker-images"

# Spring Boot.
updateGitRepository "datacenter/05-spring-boot" "spring-boot-tutorial"

# Projects.
updateGitRepository "datacenter/06-projects" "01-working-machine"
updateGitRepository "datacenter/06-projects" "02-openssl-certificates"
updateGitRepository "datacenter/06-projects" "03-proxmox-cluster"
updateGitRepository "datacenter/06-projects" "04-load-balancer"
updateGitRepository "datacenter/06-projects" "05-backup-manager"
updateGitRepository "datacenter/06-projects" "06-dhcp"
updateGitRepository "datacenter/06-projects" "07-dns"
updateGitRepository "datacenter/06-projects" "08-ntp"
updateGitRepository "datacenter/06-projects" "09-bitcoin-puzzle"
updateGitRepository "datacenter/06-projects" "10-vault-chromium-extension"
updateGitRepository "datacenter/06-projects" "xx-gitea"
updateGitRepository "datacenter/06-projects" "xx-jenkins"
updateGitRepository "datacenter/06-projects" "xx-jenkins-shared-pipeline-libraries"
updateGitRepository "datacenter/06-projects" "xx-nexus"
updateGitRepository "datacenter/06-projects" "xx-openldap"
updateGitRepository "datacenter/06-projects" "xx-portainer"
updateGitRepository "datacenter/06-projects" "xx-postgresql"
updateGitRepository "datacenter/06-projects" "xx-rabbitmq"
updateGitRepository "datacenter/06-projects" "xx-redis"
updateGitRepository "datacenter/06-projects" "xx-sonarqube"
updateGitRepository "datacenter/06-projects" "xx-T1600G-28TS-SG2424"
updateGitRepository "datacenter/06-projects" "xx-tplink_router_ax1800"
updateGitRepository "datacenter/06-projects" "xx-vault"

# Home.
updateGitRepository "home" "01-backup-restic-s3-minio"
updateGitRepository "home" "02-home-edge-esxi"
updateGitRepository "home" "03-home-edge-firewall"
updateGitRepository "home" "04-home-edge-ldap"
updateGitRepository "home" "05-home-edge-postgresql"
updateGitRepository "home" "06-home-edge-zabbix"
updateGitRepository "home" "07-home-edge-grafana"
updateGitRepository "home" "08-home-edge-k3s"
