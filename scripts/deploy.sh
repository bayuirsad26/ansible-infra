#!/bin/bash

# SummitEthic Deployment Script
# Modern and efficient deployment automation

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INVENTORY_FILE="inventory/production.yml"
PLAYBOOK_FILE="playbooks/site.yml"
TEST_PLAYBOOK="playbooks/test-common.yml"

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check if ansible is installed
    if ! command -v ansible &> /dev/null; then
        log_error "Ansible is not installed. Please install it first."
        exit 1
    fi
    
    # Check if ansible-playbook is installed
    if ! command -v ansible-playbook &> /dev/null; then
        log_error "ansible-playbook is not installed. Please install it first."
        exit 1
    fi
    
    # Check if inventory file exists
    if [ ! -f "$PROJECT_DIR/$INVENTORY_FILE" ]; then
        log_error "Inventory file not found: $INVENTORY_FILE"
        exit 1
    fi
    
    # Check if playbook file exists
    if [ ! -f "$PROJECT_DIR/$PLAYBOOK_FILE" ]; then
        log_error "Playbook file not found: $PLAYBOOK_FILE"
        exit 1
    fi
    
    log_success "Prerequisites check passed"
}

test_connectivity() {
    log_info "Testing connectivity to servers..."
    
    cd "$PROJECT_DIR"
    if ansible all -i "$INVENTORY_FILE" -m ping; then
        log_success "Connectivity test passed"
    else
        log_error "Connectivity test failed"
        exit 1
    fi
}

run_ansible_lint() {
    log_info "Running ansible-lint..."
    
    cd "$PROJECT_DIR"
    if command -v ansible-lint &> /dev/null; then
        if ansible-lint; then
            log_success "ansible-lint passed"
        else
            log_warning "ansible-lint found issues (continuing anyway)"
        fi
    else
        log_warning "ansible-lint not installed, skipping lint check"
    fi
}

deploy_common_role() {
    log_info "Deploying SummitEthic common role..."
    
    cd "$PROJECT_DIR"
    
    # Run the main playbook
    if ansible-playbook -i "$INVENTORY_FILE" "$PLAYBOOK_FILE" --diff; then
        log_success "Common role deployment completed successfully"
    else
        log_error "Common role deployment failed"
        exit 1
    fi
}

run_tests() {
    log_info "Running post-deployment tests..."
    
    cd "$PROJECT_DIR"
    
    # Run the test playbook
    if ansible-playbook -i "$INVENTORY_FILE" "$TEST_PLAYBOOK"; then
        log_success "All tests passed"
    else
        log_error "Some tests failed"
        exit 1
    fi
}

show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -c, --check    Run in check mode (dry run)"
    echo "  -t, --test     Run tests only"
    echo "  -l, --lint     Run ansible-lint only"
    echo "  -v, --verbose  Verbose output"
    echo ""
    echo "SummitEthic Deployment Script - Ethical DevOps Automation"
}

main() {
    local check_mode=false
    local test_only=false
    local lint_only=false
    local verbose=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -c|--check)
                check_mode=true
                shift
                ;;
            -t|--test)
                test_only=true
                shift
                ;;
            -l|--lint)
                lint_only=true
                shift
                ;;
            -v|--verbose)
                verbose="-v"
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Header
    echo "=========================================="
    echo "🚀 SummitEthic Infrastructure Deployment"
    echo "   Ethical DevOps - Building Tomorrow's Solutions"
    echo "=========================================="
    echo ""
    
    # Execute based on options
    if [ "$lint_only" = true ]; then
        run_ansible_lint
        exit 0
    fi
    
    if [ "$test_only" = true ]; then
        check_prerequisites
        test_connectivity
        run_tests
        exit 0
    fi
    
    # Full deployment process
    check_prerequisites
    test_connectivity
    run_ansible_lint
    
    if [ "$check_mode" = true ]; then
        log_info "Running in check mode (dry run)..."
        cd "$PROJECT_DIR"
        ansible-playbook -i "$INVENTORY_FILE" "$PLAYBOOK_FILE" --check --diff $verbose
    else
        deploy_common_role
        run_tests
    fi
    
    echo ""
    echo "=========================================="
    log_success "🎉 SummitEthic deployment completed successfully!"
    echo "   Your server is now configured with ethical DevOps practices"
    echo "=========================================="
}

# Run main function
main "$@"
