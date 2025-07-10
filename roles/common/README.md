# Common Role

This role provides base server configuration that applies to all systems in the infrastructure.

## Features

- ✅ System timezone and locale configuration
- ✅ Essential package installation
- ✅ User and group management
- ✅ System optimization (kernel parameters, limits)
- ✅ Service management
- ✅ Custom MOTD and shell configuration
- ✅ Log rotation setup
- ✅ Security hardening basics

## Requirements

- Ansible 2.12 or higher
- Target systems: Ubuntu 20.04+, Debian 11+, RHEL/Rocky/Alma 8+

## Role Variables

### Basic Configuration

- `common_timezone`: System timezone (default: UTC)
- `common_default_locale`: Default system locale (default: en_US.UTF-8)
- `common_set_hostname`: Whether to set hostname (default: false)

### Package Management

- `common_packages`: List of essential packages to install
- `common_update_all_packages`: Whether to update all packages (default: false)

### User Management

- `common_users`: List of users to create
- `common_groups`: List of groups to create

### System Optimization

- `common_sysctl_params`: Kernel parameters to set
- `common_limits`: System limits configuration

## Example Playbook

```yaml
- hosts: all
  become: yes
  roles:
    - role: common
      vars:
        common_timezone: "Asia/Jakarta"
        common_users:
          - name: devops
            sudo: true
            shell: /bin/bash
```

## Tags

- `timezone`: Timezone configuration
- `packages`: Package management
- `users`: User management
- `locale`: Locale configuration
- `shell`: Shell configuration
- `motd`: Message of the day
- `services`: Service management
- `kernel`: Kernel parameters
- `logging`: Log configuration

## Author

SummitEthic DevOps Team - Building ethical solutions with modern practices.
