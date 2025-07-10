.PHONY: help install lint check deploy test clean

# Default target
help:
	@echo "SummitEthic Ansible Infrastructure"
	@echo "=================================="
	@echo "Available targets:"
	@echo "  install    - Install dependencies"
	@echo "  lint       - Run ansible-lint"
	@echo "  check      - Run playbook in check mode"
	@echo "  deploy     - Deploy infrastructure"
	@echo "  test       - Run tests"
	@echo "  clean      - Clean temporary files"
	@echo "  ping       - Test connectivity"
	@echo "  info       - Show system information"

install:
	@echo "Installing dependencies..."
	pip3 install ansible ansible-lint
	ansible-galaxy collection install community.general

lint:
	@echo "Running ansible-lint..."
	ansible-lint

check:
	@echo "Running playbook in check mode..."
	ansible-playbook -i inventory/production/hosts.yml playbooks/site.yml --check --diff

deploy:
	@echo "Deploying SummitEthic infrastructure..."
	./scripts/deploy.sh

test:
	@echo "Running tests..."
	ansible-playbook -i inventory/production/hosts.yml playbooks/test-common.yml

clean:
	@echo "Cleaning temporary files..."
	rm -rf /tmp/facts_cache
	rm -f ansible.log
	rm -f *.retry

ping:
	@echo "Testing connectivity..."
	ansible all -i inventory/production/hosts.yml -m ping

info:
	@echo "Gathering system information..."
	ansible all -i inventory/production/hosts.yml -m setup --tree /tmp/facts

# Development targets
dev-setup:
	@echo "Setting up development environment..."
	python3 -m venv venv
	source venv/bin/activate && pip install ansible ansible-lint
	chmod +x scripts/deploy.sh

dev-check:
	@echo "Running development checks..."
	ansible-lint
	ansible-playbook -i inventory/production/hosts.yml playbooks/site.yml --syntax-check
