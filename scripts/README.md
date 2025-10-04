# Homelab Automation Scripts

This directory contains `Bash` scripts to automate key tasks in the `homelab-datacenter` repository, such as updating `Git` repositories, building `Proxmox` VM templates with `Packer`, deploying infrastructure with `Terraform`, and running `Ansible` playbooks for daily maintenance. These scripts help maintain consistency across my Proxmox VE-based homelab setup.

For an overview of the homelab projects and setup instructions, see the main [README.md](../README.md).

## Prerequisites

Before running these scripts, ensure the following requirements are met on your Ubuntu VM:

1. **Proxmox VE**:

   Set up and configured with API access (e.g., a user token for Packer and Terraform). Tested with Proxmox VE 8.x.

1. **Tools**:

   Installed on your Ubuntu VM:
   - Bash (`bash`)
   - Git (`git`)
   - Packer (`packer`)
   - Terraform (`terraform`)
   - Ansible (`ansible`)

1. **GitHub Access**:

   A Personal Access Token (PAT) configured for HTTPS Git operations. Set up credential storage to avoid repeated prompts:

   Configure the Git credential helper.
   ```bash
   git config --global credential.helper store
   ```

   Authenticate with your PAT when prompted during the first Git operation.

1. **GPG Signing**:

   Enabled for commits to ensure security. Configure with a valid GPG key:

   Enable GPG signing for commits.
   ```bash
   git config --global commit.gpgsign true
   ```

   Set your GPG key ID.
   ```bash
   git config --global user.signingkey <YOUR_KEY_ID>
   ```

1. **Directory Structure**:

   Clone the `homelab-datacenter` repository and its submodules to `~/git` on your Ubuntu VM:

   Clone the repository.
   ```bash
   git clone https://github.com/lsampaioweb/homelab-datacenter.git ~/git/homelab-datacenter
   ```

   Change to the repository directory.
   ```bash
   cd ~/git/homelab-datacenter
   ```

   Ensure submodules are initialized and updated.
   ```bash
   git submodule update --init --recursive
   ```

1. **Ansible Inventory**:

   Ensure Ansible inventory files are configured in each project directory (e.g., `~/git/datacenter/06-projects/01-working-machine/ansible/inventory/hosts`) for scripts like `run-daily-updates.sh`.

## Available Scripts

The scripts are organized by project type in subfolders (`01-git`, `02-packer`, `03-terraform`, `04-ansible`).

## Logs and Troubleshooting

Each script logs its output to `logs/YYYY-MM-DD/

### 1. Update Git Repositories

Updates all 50+ Git repositories and their submodules to the latest commits, committing any submodule changes.

**Usage**:

Change to the Git scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/01-git
```

Run the repository update script on a MacBook.
```bash
./update-repos-macos.sh
```

Run the repository update script on a Ubuntu.
```bash
./update-repos-ubuntu.sh
```

**What It Does**:
- Pulls updates for repos like `homelab-datacenter`, `packer-proxmox-ubuntu-iso`, and `jump-server`.
- Syncs and updates submodules (e.g., `ansible/roles/common`, `packer/iso`).
- Commits and pushes new submodule commits with GPG signing.
- Logs to `logs/YYYY-MM-DD/update-repos.log`.

### 2. Build Proxmox VM Templates

Builds Ubuntu 24.04 VM templates in `Proxmox` using `Packer` for server and desktop variants.

**Usage**:

Change to the Packer scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/02-packer
```

Run the template build script with action and environment.
```bash
# ./build-templates.sh [validate|build] [home|homelab]
./build-templates.sh build home
```

**Options**:
  - `validate`:

    Validates Packer configs without building.

  - `build`:

    Builds the templates.

  - `home`:

    Uses home environment settings.

  - `homelab`:

    Uses homelab environment settings (default: `home`).

**What It Does**:
  - Builds templates for:
    - `proxmox-ubuntu-server-raw` (ID 900)
    - `proxmox-ubuntu-server-standard` (901)
    - `proxmox-ubuntu-server-std-docker` (902)
    - `proxmox-ubuntu-desktop-raw` (910)
    - `proxmox-ubuntu-desktop-standard` (911)
  - Runs Ansible playbooks to configure VMs (e.g., SSH, cloud-init, package updates).
  - Logs to `logs/YYYY-MM-DD/build-templates.log` and per-project logs (e.g., `10-proxmox-ubuntu-server-raw.log`).

**Tip**:
  - Use `validate` first to catch config errors.
  - Check `template-id.txt` for template IDs.

### 3. Destroy Proxmox VM Templates

Removes specific VM templates from Proxmox nodes to clean up.

**Usage**:

Change to the Packer scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/02-packer
```

Run the template destroy script.
```bash
./destroy-templates.sh
```

**What It Does**:
  - Runs `qm destroy` commands on Proxmox nodes (PVE-01, PVE-02) to remove templates (IDs 900, 901, 902, 910, 911).
  - Purges unreferenced disks.

**Tip**:
  - Run this on the Proxmox node hosting the templates.
  - Verify IDs in `template-id.txt` before destroying.

### 4. Deploy Infrastructure with Terraform

Deploys VMs for infrastructure projects (e.g., load balancer, DHCP) using Terraform.

**Usage**:

Change to the Terraform scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/03-terraform
```

Run the infrastructure deploy script with environment.
```bash
./apply.sh [staging|production]
```

**Options**:
  - `staging`:

    Deploys to the staging environment (default).

  - `production`:

    Deploys to the production environment.

**What It Does**:
  - Applies Terraform configs for `04-load-balancer`, `05-backup-manager`, `06-dhcp`, `07-dns`, and `08-ntp`.
  - Logs to `logs/YYYY-MM-DD/apply.log`.

**Tip**:
  - Ensure Proxmox credentials are set in your Terraform configs. Check logs for errors.

### 5. Destroy Infrastructure with Terraform

Removes VMs deployed by Terraform to clean up infrastructure.

**Usage**:

Change to the Terraform scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/03-terraform
```

Run the infrastructure destroy script with environment.
```bash
./destroy.sh [staging|production]
```

**Options**:
  - `staging`:

    Destroys the staging environment (default).

  - `production`:

    Destroys the production environment.

**What It Does**:
- Destroys Terraform-managed VMs for `08-ntp`, `07-dns`, `06-dhcp`, `05-backup-manager`, and `04-load-balancer`.
- Logs to `logs/YYYY-MM-DD/destroy.log`.

**Tip**:
  - Run `apply.sh` to redeploy after destroying. Verify no critical VMs are affected.

### 6. Start Proxmox VMs

Starts specific VM templates in Proxmox.

**Usage**:

Change to the Terraform scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/03-terraform
```

Run the VM start script.
```bash
./start-vms.sh
```

**What It Does**:
  - Runs `qm start` commands on Proxmox nodes (PVE-01, PVE-02) for templates (IDs 900, 901, 902, 910, 911).

**Tip**:
  - Run on the Proxmox node. Check `template-id.txt` for IDs.

### 7. Shutdown Proxmox VMs

Shuts down specific VM templates in Proxmox.

**Usage**:

Change to the Terraform scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/03-terraform
```

Run the VM shutdown script.
```bash
./shutdown-vms.sh
```

**What It Does**:
  - Runs `qm shutdown` commands on Proxmox nodes (PVE-01, PVE-02) for templates (IDs 900, 901, 902, 910, 911).

**Tip**:
  - Run on the Proxmox node. Use `start-vms.sh` to restart.

### 8. Run Daily Ansible Updates

Runs Ansible playbooks for daily maintenance tasks on specific VMs.

**Usage**:

Change to the Ansible scripts directory.
```bash
cd ~/git/homelab-datacenter/scripts/projects/04-ansible
```

Run the daily updates script.
```bash
./run-daily-updates.sh
```

**What It Does**:
  - Verifies OpenSSL certificates (`02-openssl-certificates`).
  - Updates the Proxmox cluster (`03-proxmox-cluster`).
  - Updates the jump server (`01-working-machine`).
  - Logs to `logs/YYYY-MM-DD/daily-updates.log`.

**Tip**:
  - Schedule this with a cron job for daily automation. Check logs for playbook errors.

## Logs and Troubleshooting

Each script logs output to `logs/YYYY-MM-DD/<script>.log` (e.g., `update-repos.log`, `build-templates.log`).

If a script fails:

  1. Check the log for errors (e.g., authentication, missing files).
  1. Verify your GitHub PAT, GPG signing, and tool versions.
  1. Ensure the repo directory exists and submodules are initialized (`git submodule update --init --recursive`).
  1. For Packer/Terraform issues, validate configs first (e.g., `./build-templates.sh validate home`).

## Getting Help

If you’re stuck, check the main [README.md](../README.md) for project details or open an issue on the [homelab-datacenter](https://github.com/lsampaioweb/homelab-datacenter) repo. For additional support, reach out via the GitHub repository's issues page.

## License
Licensed under the [MIT License](../LICENSE).

## Created by
1. Luciano Sampaio.
