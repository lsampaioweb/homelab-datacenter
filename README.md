# Homelab Datacenter

This repository serves as a central index for my homelab projects, which use **Packer**, **Terraform**, and **Ansible** to automate infrastructure provisioning. Below, you’ll find links to various repositories that allow you to recreate my homelab setup from scratch.

#
### Packer Modules
Packer modules that help automate the creation of VM templates in Proxmox VE. You can choose to build a template from an ISO or from a cloned template.

- **[Packer Proxmox Ubuntu 24.04 ISO](https://github.com/lsampaioweb/packer-proxmox-ubuntu-iso)** - Packer module to create an Ubuntu 24.04 template from an ISO.
- **[Packer Proxmox Ubuntu 24.04 Clone](https://github.com/lsampaioweb/packer-proxmox-ubuntu-clone)** - Packer module to create an Ubuntu 24.04 template from a cloned template.

#
### Terraform Modules
Terraform modules that help automate VM creation and infrastructure provisioning in the homelab.

- **[Terraform Random Target Node](https://github.com/lsampaioweb/terraform-random-target-node)** - Generates random numbers for selecting which Proxmox node will host a new VM.
- **[Terraform Local Dynamic Inventory](https://github.com/lsampaioweb/terraform-local-dynamic-inventory)** - Generates local dynamic Ansible inventory files.
- **[Terraform Proxmox VM QEMU](https://github.com/lsampaioweb/terraform-proxmox-vm-qemu)** - Automates VM creation in Proxmox VE.
- **[Terraform Proxmox Homelab Project](https://github.com/lsampaioweb/terraform-proxmox-homelab-project)** - Default Terraform configurations for the homelab projects.

#
### Ansible Modules
Reusable Ansible playbooks and tasks for configuring VMs.

- **[Ansible Common Tasks](https://github.com/lsampaioweb/ansible-common-tasks)** - Common Ansible tasks that can be used in other playbooks.
- **[Ansible KVM Cloud Init](https://github.com/lsampaioweb/ansible-kvm-cloud-init)** - Sets up cloud-init settings on KVM instances.

#
### Template Project
- **[Template Project](https://github.com/lsampaioweb/git-template-repository)** - Scripts to create a project with all default files and folders.

#
### Infrastructure Projects
Scripts for setting up key network and infrastructure components in the homelab.

- **[Router - AX1800](https://github.com/lsampaioweb/tplink_router_ax1800)** - Scripts to configure the TP-Link AX1800 router.
- **[Firewall Fortigate 80E](https://github.com/lsampaioweb/home-edge-firewall)** - Configuration scripts for the Fortigate 80E firewall.
- **[Switch - T1600G-28TS-SG2424](https://github.com/lsampaioweb/T1600G-28TS-SG2424)** - Setup scripts for the TP-Link SFP switch T1600G-28TS SG2424.
- **[KVM - Proxmox-Cluster](https://github.com/lsampaioweb/proxmox-cluster)** - Scripts to create and manage a Proxmox Cluster.

#
### Packer Projects
Projects for creating Ubuntu VM templates using Packer.

- **[Ubuntu Server 24.04 Raw](https://github.com/lsampaioweb/proxmox-ubuntu-server-raw)** - Ubuntu template from an ISO with the bare minimum packages and updates.
- **[Ubuntu Server 24.04 Standard](https://github.com/lsampaioweb/proxmox-ubuntu-server-standard)** - Ubuntu template from a cloned template.
- **[Ubuntu Server 24.04 Docker](https://github.com/lsampaioweb/proxmox-ubuntu-server-std-docker)** - Ubuntu template from the server-standard with Docker installed.
- **[Ubuntu Desktop 24.04 Raw](https://github.com/lsampaioweb/proxmox-ubuntu-desktop-raw)** - Ubuntu Desktop template from an ISO with the bare minimum packages and updates.
- **[Ubuntu Desktop 24.04 Standard](https://github.com/lsampaioweb/proxmox-ubuntu-desktop-standard)** - Ubuntu Desktop template from a cloned template with default packages.

#
### Virtual Machine Projects
Projects focused on deploying and managing specific VMs.

1. **[Jump Server](https://github.com/lsampaioweb/jump-server)** - Deploys VMs that function as jump servers.
1. **[OpenSSL Certificates](https://github.com/lsampaioweb/openssl-certificates)** - Automates OpenSSL certificate creation and verification with Ansible.
1. **[Proxmox Cluster](https://github.com/lsampaioweb/proxmox-cluster)** - Scripts to create and manage a Proxmox Cluster.
1. **[Load Balancer](https://github.com/lsampaioweb/load-balancer)** - Deploys VMs that function as load balancing (with Traefik) servers.
1. **[Backup Manager](https://github.com/lsampaioweb/backup-manager)** - Scripts and configurations for setting up and managing Restic backups and restores across VMs.
1. **[DHCP](https://github.com/lsampaioweb/dhcp)** - Deploys VMs that function as DHCP servers.
1. **[DNS](https://github.com/lsampaioweb/dns)** - Deploys VMs that function as DNS servers.
1. **[NTP](https://github.com/lsampaioweb/ntp)** - Deploys VMs that function as NTP servers.

#
### Usage Instructions
To get started:
1. Ensure you have **Proxmox VE** installed and properly configured.
2. Clone the repositories relevant to your setup.
3. Follow the instructions in each repository’s README.
4. Use **Terraform** and **Ansible** to deploy and configure VMs automatically.

For detailed steps, refer to the individual repository documentation.

#
### License
This project is licensed under the [MIT License](LICENSE).

#
### Created by
1. Luciano Sampaio.
