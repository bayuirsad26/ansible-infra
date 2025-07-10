# SummitEthic Ansible Infrastructure

🚀 **Ethical DevOps - Building Tomorrow's Solutions Today**

This repository contains the Ansible infrastructure code for SummitEthic, implementing modern DevOps practices with a strong emphasis on ethical principles and operational excellence.

## 🏗️ Project Structure

```
ansible-infrastructure/
├── ansible.cfg                 # Ansible configuration
├── inventory/                  # Inventory management
│   └── production.yml         # Production inventory
├── group_vars/                # Group-specific variables
│   ├── all.yml               # Global variables
│   └── web_servers.yml       # Web server variables
├── playbooks/                 # Ansible playbooks
│   ├── site.yml              # Main deployment playbook
│   └── test-common.yml       # Testing playbook
├── roles/                     # Custom roles
│   └── common/               # Base server configuration
├── scripts/                   # Deployment scripts
│   └── deploy.sh             # Automated deployment script
├── Makefile                   # Build automation
└── README.md                 # This file
```

## 🚀 Quick Start

### Prerequisites

- Python 3.8+
- Ansible 2.12+
- SSH access to target servers
- Sudo privileges on target servers

### 1. Clone and Setup

```bash
git clone <repository-url>
cd ansible-infrastructure
make install
```

### 2. Configure Inventory

Edit `inventory/production/hosts.yml` to match your server details:

```yaml
summitethic-web-01:
  ansible_host: YOUR_SERVER_IP
  ansible_user: YOUR_USERNAME
```

### 3. Test Connectivity

```bash
make ping
```

### 4. Run Deployment

```bash
# Dry run (check mode)
make check

# Full deployment
make deploy
```

## 🎯 Features

### Common Role Capabilities

✅ **System Configuration**
- Timezone and locale setup
- Hostname configuration
- Essential package installation
- User and group management

✅ **Performance Optimization**
- Kernel parameter tuning
- System limits configuration
- Network optimization
- Memory management

✅ **Security Hardening**
- User privilege management
- Service configuration
- Security settings

✅ **Operational Excellence**
- Custom MOTD with system information
- Enhanced shell configuration
- Log rotation setup
- Monitoring preparation

✅ **DevOps Integration**
- Built-in aliases for Docker, Kubernetes, Git
- System health monitoring functions
- Deployment safety checks
- Comprehensive logging

## 🔧 Usage Examples

### Basic Deployment

```bash
# Test connectivity
ansible all -i inventory/production/hosts.yml -m ping

# Deploy common role
ansible-playbook -i inventory/production/hosts.yml playbooks/site.yml

# Run tests
ansible-playbook -i inventory/production/hosts.yml playbooks/test-common.yml
```

### Advanced Usage

```bash
# Check mode (dry run)
ansible-playbook -i inventory/production/hosts.yml playbooks/site.yml --check --diff

# Deploy specific tags
ansible-playbook -i inventory/production/hosts.yml playbooks/site.yml --tags "hostname,packages"

# Limit to specific hosts
ansible-playbook -i inventory/production/hosts.yml playbooks/site.yml --limit "web_servers"
```

### Using the Deployment Script

```bash
# Full deployment with tests
./scripts/deploy.sh

# Check mode only
./scripts/deploy.sh --check

# Run tests only
./scripts/deploy.sh --test

# Run with verbose output
./scripts/deploy.sh --verbose
```

## 🎨 Customization

### Hostname Configuration

The current setup changes your server hostname to `summitethic.com`. To customize:

```yaml
# group_vars/all.yml
common_hostname: "your-custom-hostname.com"
```

### Adding Custom Users

```yaml
# group_vars/all.yml
common_users:
  - name: your-user
    shell: /bin/bash
    sudo: true
    groups: ["docker", "sudo"]
```

### Package Management

```yaml
# group_vars/all.yml
common_packages:
  - your-package-1
  - your-package-2
```

## 🧪 Testing

### Automated Testing

```bash
# Run all tests
make test

# Run specific test tags
ansible-playbook -i inventory/production/hosts.yml playbooks/test-common.yml --tags "test_hostname"
```

### Manual Verification

After deployment, verify the configuration:

```bash
# Check hostname
hostname

# Check timezone
timedatectl

# Check system limits
ulimit -n

# Check installed packages
dpkg -l | grep -E "(curl|git|htop|vim)"
```

## 🔒 Security Considerations

- SSH keys are recommended over passwords
- Regular security updates are automated
- System limits are configured for performance
- Unnecessary services are disabled
- Fail2ban integration ready

## 🌟 SummitEthic Principles

This infrastructure embodies our core values:

- **Transparency**: All configurations are documented and version-controlled
- **Collaboration**: Shared standards and practices across all systems
- **Continuous Improvement**: Regular updates and optimization
- **Ethical Standards**: Responsible resource usage and security practices
- **Innovation**: Modern DevOps practices and automation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `make test`
5. Run lint: `make lint`
6. Submit a pull request

## 📊 Monitoring

After deployment, use the built-in commands:

```bash
# System information
sysinfo

# Health check
healthcheck

# Ethical guidelines reminder
ethics
```

## 🆘 Troubleshooting

### Common Issues

**Connection Issues**
```bash
# Test SSH connection
ssh -o StrictHostKeyChecking=no admin@167.86.108.4

# Check inventory
ansible-inventory -i inventory/production/hosts.yml --list
```

**Permission Issues**
```bash
# Verify sudo access
ansible all -i inventory/production/hosts.yml -m shell -a "sudo whoami"
```

**Package Installation Issues**
```bash
# Update package cache
ansible all -i inventory/production/hosts.yml -m apt -a "update_cache=yes" --become
```

## 📞 Support

For technical support or questions:
- 📧 Email: devops@summitethic.com
- 🌐 Website: https://summitethic.com
- 📚 Documentation: Check the `docs/` directory

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Built with ❤️ by the SummitEthic DevOps Team**

*Ethical DevOps - Building Tomorrow's Solutions Today*
