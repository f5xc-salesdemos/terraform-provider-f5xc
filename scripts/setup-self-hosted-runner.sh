#!/bin/bash
# Setup Self-Hosted GitHub Actions Runner for F5 XC Terraform Provider
#
# This script helps fork users set up everything needed to run acceptance tests:
#   1. Validates prerequisites (gh CLI, Go, etc.)
#   2. Prompts for F5 XC credentials and configures GitHub secrets
#   3. Downloads and installs GitHub Actions runner
#   4. Registers the runner with your repository
#   5. Optionally starts the runner as a background service
#
# Usage:
#   ./scripts/setup-self-hosted-runner.sh
#
# Requirements:
#   - GitHub CLI (gh) authenticated with repo access
#   - Go 1.23+ installed
#   - curl, jq installed
#   - Network access to F5 XC API endpoint

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
RUNNER_DIR="${PROJECT_ROOT}/.github-runner"

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_step() { echo -e "\n${CYAN}${BOLD}==> $1${NC}"; }

# Check if a command exists
check_command() {
    if command -v "$1" &> /dev/null; then
        log_success "$1 found: $(command -v "$1")"
        return 0
    else
        log_error "$1 not found"
        return 1
    fi
}

# Prompt for input with default value
prompt_input() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    local is_secret="${4:-false}"  # pragma: allowlist secret

    if [[ "$is_secret" == "true" ]]; then  # pragma: allowlist secret
        echo -en "${CYAN}$prompt${NC}"
        if [[ -n "$default" ]]; then
            echo -en " [****]: "
        else
            echo -en ": "
        fi
        read -rs value
        echo ""
    else
        echo -en "${CYAN}$prompt${NC}"
        if [[ -n "$default" ]]; then
            echo -en " [$default]: "
        else
            echo -en ": "
        fi
        read -r value
    fi

    if [[ -z "$value" ]]; then
        value="$default"
    fi

    eval "$var_name='$value'"
}

# Confirm action
confirm() {
    local prompt="$1"
    echo -en "${YELLOW}$prompt (y/N): ${NC}"
    read -r response
    [[ "$response" =~ ^[Yy]$ ]]
}

# Header
print_header() {
    echo -e "${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║     F5 XC Terraform Provider - Self-Hosted Runner Setup              ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Check prerequisites
check_prerequisites() {
    log_step "Checking prerequisites..."

    local missing=()

    check_command "gh" || missing+=("gh (GitHub CLI)")
    check_command "go" || missing+=("go (Go 1.23+)")
    check_command "curl" || missing+=("curl")
    check_command "jq" || missing+=("jq")
    check_command "git" || missing+=("git")

    # Check Go version
    if command -v go &> /dev/null; then
        local go_version
        go_version=$(go version | grep -oE 'go[0-9]+\.[0-9]+' | sed 's/go//')
        local go_major go_minor
        go_major=$(echo "$go_version" | cut -d. -f1)
        go_minor=$(echo "$go_version" | cut -d. -f2)
        if [[ "$go_major" -lt 1 ]] || [[ "$go_major" -eq 1 && "$go_minor" -lt 23 ]]; then
            log_warning "Go version $go_version found, but 1.23+ recommended"
        else
            log_success "Go version $go_version meets requirements"
        fi
    fi

    # Check gh authentication
    if command -v gh &> /dev/null; then
        if gh auth status &> /dev/null; then
            log_success "GitHub CLI authenticated"
        else
            log_error "GitHub CLI not authenticated. Run: gh auth login"
            missing+=("gh auth (run 'gh auth login')")
        fi
    fi

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo ""
        log_error "Missing prerequisites:"
        for item in "${missing[@]}"; do
            echo "  - $item"
        done
        echo ""
        echo "Install missing tools and try again."
        exit 1
    fi

    log_success "All prerequisites satisfied"
}

# Detect repository info
detect_repo_info() {
    log_step "Detecting repository information..."

    cd "$PROJECT_ROOT"

    # Get repo owner and name
    REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")
    if [[ -z "$REPO_URL" ]]; then
        log_error "Could not detect git remote. Are you in the correct directory?"
        exit 1
    fi

    # Extract owner/repo from URL
    if [[ "$REPO_URL" =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
        REPO_OWNER="${BASH_REMATCH[1]}"
        REPO_NAME="${BASH_REMATCH[2]}"
    else
        log_error "Could not parse repository URL: $REPO_URL"
        exit 1
    fi

    REPO_FULL="${REPO_OWNER}/${REPO_NAME}"
    log_success "Repository: $REPO_FULL"
}

# Configure F5 XC credentials
configure_credentials() {
    log_step "Configuring F5 XC API credentials..."

    echo ""
    echo -e "${BOLD}F5 XC API credentials are required for acceptance tests.${NC}"
    echo ""
    echo "To get an API token from F5 XC Console:"
    echo "  1. Go to Administration → Personal Management → Credentials"
    echo "  2. Click 'Add Credentials' → 'API Token'"
    echo "  3. Copy the token value"
    echo ""

    # Get API URL
    prompt_input "F5 XC API URL" "https://console.ves.volterra.io" "F5XC_API_URL" "false"

    # Get API Token
    prompt_input "F5 XC API Token" "" "F5XC_API_TOKEN" "true"

    if [[ -z "$F5XC_API_TOKEN" ]]; then
        log_error "API Token is required"
        exit 1
    fi

    echo ""
    log_info "Setting GitHub secrets..."

    # Set secrets
    echo "$F5XC_API_URL" | gh secret set F5XC_API_URL --repo "$REPO_FULL"
    log_success "F5XC_API_URL secret set"

    echo "$F5XC_API_TOKEN" | gh secret set F5XC_API_TOKEN --repo "$REPO_FULL"
    log_success "F5XC_API_TOKEN secret set"

    echo ""
    log_success "GitHub secrets configured"
}

# Verify credentials work
verify_credentials() {
    log_step "Verifying F5 XC API connectivity..."

    # Try to make a simple API call
    local api_url="${F5XC_API_URL}/api/web/namespaces"
    local response
    local http_code

    http_code=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "Authorization: APIToken ${F5XC_API_TOKEN}" \
        "$api_url" 2>/dev/null || echo "000")

    case "$http_code" in
        200|401|403)
            log_success "API endpoint reachable (HTTP $http_code)"
            if [[ "$http_code" == "200" ]]; then
                log_success "Authentication successful"
            else
                log_warning "Authentication may need verification (HTTP $http_code)"
            fi
            ;;
        000)
            log_warning "Could not connect to API - check network access"
            ;;
        *)
            log_warning "Unexpected response (HTTP $http_code)"
            ;;
    esac
}

# Detect platform
detect_platform() {
    local os arch

    os=$(uname -s | tr '[:upper:]' '[:lower:]')
    arch=$(uname -m)

    case "$os" in
        linux) RUNNER_OS="linux" ;;
        darwin) RUNNER_OS="osx" ;;
        *) log_error "Unsupported OS: $os"; exit 1 ;;
    esac

    case "$arch" in
        x86_64|amd64) RUNNER_ARCH="x64" ;;
        arm64|aarch64) RUNNER_ARCH="arm64" ;;
        *) log_error "Unsupported architecture: $arch"; exit 1 ;;
    esac

    log_info "Platform: ${RUNNER_OS}-${RUNNER_ARCH}"
}

# Get latest runner version
get_runner_version() {
    RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.tag_name' | sed 's/v//')
    if [[ -z "$RUNNER_VERSION" || "$RUNNER_VERSION" == "null" ]]; then
        RUNNER_VERSION="2.311.0"  # Fallback version
        log_warning "Could not detect latest version, using $RUNNER_VERSION"
    else
        log_info "Latest runner version: $RUNNER_VERSION"
    fi
}

# Download and install runner
install_runner() {
    log_step "Installing GitHub Actions runner..."

    detect_platform
    get_runner_version

    local runner_file="actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz"
    local runner_url="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/${runner_file}"

    # Create runner directory
    mkdir -p "$RUNNER_DIR"
    cd "$RUNNER_DIR"

    # Download runner
    if [[ -f "run.sh" ]]; then
        log_info "Runner already installed, checking for updates..."
        local installed_version
        installed_version=$(./config.sh --version 2>/dev/null || echo "unknown")
        if [[ "$installed_version" == "$RUNNER_VERSION" ]]; then
            log_success "Runner $RUNNER_VERSION already installed"
            return 0
        fi
    fi

    log_info "Downloading runner v${RUNNER_VERSION}..."
    curl -sL "$runner_url" -o "$runner_file"

    log_info "Extracting runner..."
    tar -xzf "$runner_file"
    rm -f "$runner_file"

    log_success "Runner installed to: $RUNNER_DIR"
}

# Get runner registration token
get_registration_token() {
    log_info "Getting runner registration token..."

    RUNNER_TOKEN=$(gh api \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        "/repos/${REPO_FULL}/actions/runners/registration-token" \
        --jq '.token' 2>/dev/null)

    if [[ -z "$RUNNER_TOKEN" || "$RUNNER_TOKEN" == "null" ]]; then
        log_error "Could not get registration token. Check repository permissions."
        log_info "You need admin access to the repository to register runners."
        exit 1
    fi

    log_success "Registration token obtained"
}

# Configure runner
configure_runner() {
    log_step "Configuring runner..."

    cd "$RUNNER_DIR"

    # Check if already configured
    if [[ -f ".runner" ]]; then
        if confirm "Runner already configured. Reconfigure?"; then
            ./config.sh remove --token "$RUNNER_TOKEN" || true
        else
            log_info "Keeping existing configuration"
            return 0
        fi
    fi

    get_registration_token

    # Get runner name
    local default_name="${HOSTNAME:-$(hostname)}-f5xc-runner"
    prompt_input "Runner name" "$default_name" "RUNNER_NAME" "false"

    # Configure runner
    log_info "Registering runner with GitHub..."
    ./config.sh \
        --url "https://github.com/${REPO_FULL}" \
        --token "$RUNNER_TOKEN" \
        --name "$RUNNER_NAME" \
        --labels "self-hosted,${RUNNER_OS},${RUNNER_ARCH},f5xc" \
        --work "_work" \
        --unattended \
        --replace

    log_success "Runner configured and registered"
}

# Start runner
start_runner() {
    log_step "Starting runner..."

    cd "$RUNNER_DIR"

    echo ""
    echo -e "${BOLD}How would you like to run the GitHub Actions runner?${NC}"
    echo ""
    echo "  1) Foreground (interactive) - Good for testing"
    echo "  2) Background (nohup) - Run in background"
    echo "  3) Service (systemd/launchd) - Start on boot [Linux/macOS]"
    echo "  4) Don't start now - I'll start it manually later"
    echo ""

    prompt_input "Choose option" "1" "START_OPTION" "false"

    case "$START_OPTION" in
        1)
            log_info "Starting runner in foreground..."
            log_info "Press Ctrl+C to stop"
            echo ""
            ./run.sh
            ;;
        2)
            log_info "Starting runner in background..."
            nohup ./run.sh > runner.log 2>&1 &
            local pid=$!
            echo "$pid" > runner.pid
            log_success "Runner started (PID: $pid)"
            log_info "View logs: tail -f $RUNNER_DIR/runner.log"
            log_info "Stop runner: kill \$(cat $RUNNER_DIR/runner.pid)"
            ;;
        3)
            if [[ "$RUNNER_OS" == "linux" ]]; then
                log_info "Installing as systemd service..."
                sudo ./svc.sh install
                sudo ./svc.sh start
                log_success "Runner installed and started as service"
                log_info "Check status: sudo ./svc.sh status"
            elif [[ "$RUNNER_OS" == "osx" ]]; then
                log_info "Installing as launchd service..."
                ./svc.sh install
                ./svc.sh start
                log_success "Runner installed and started as service"
                log_info "Check status: ./svc.sh status"
            fi
            ;;
        4)
            log_info "Runner not started."
            echo ""
            echo "To start manually:"
            echo "  cd $RUNNER_DIR"
            echo "  ./run.sh"
            ;;
        *)
            log_warning "Invalid option, not starting runner"
            ;;
    esac
}

# Print summary
print_summary() {
    log_step "Setup Complete!"

    echo ""
    echo -e "${BOLD}Summary:${NC}"
    echo "  Repository: $REPO_FULL"
    echo "  Runner Dir: $RUNNER_DIR"
    echo "  API URL: $F5XC_API_URL"
    echo ""
    echo -e "${BOLD}GitHub Secrets configured:${NC}"
    echo "  - F5XC_API_URL"
    echo "  - F5XC_API_TOKEN"
    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    echo "  1. Ensure runner is running (check Actions → Runners in GitHub)"
    echo "  2. Trigger acceptance tests:"
    echo "     gh workflow run acceptance-tests.yml -f mode=full"
    echo ""
    echo "  Or run tests locally:"
    echo "     export F5XC_API_URL='$F5XC_API_URL'"
    echo "     export F5XC_API_TOKEN='<your-token>'"
    echo "     export TF_ACC=1"
    echo "     go test -v -run 'TestAcc.*' ./internal/provider/..."
    echo ""
    echo -e "${BOLD}Documentation:${NC}"
    echo "  - Workflow: .github/workflows/acceptance-tests.yml"
    echo "  - Test runner: scripts/run-comprehensive-tests.sh"
    echo ""
}

# Cleanup on error
cleanup_on_error() {
    log_error "Setup failed. Cleaning up..."
    # Add any cleanup logic here
}

trap cleanup_on_error ERR

# Main
main() {
    print_header

    check_prerequisites
    detect_repo_info

    echo ""
    if ! confirm "Continue with setup for $REPO_FULL?"; then
        log_info "Setup cancelled"
        exit 0
    fi

    configure_credentials
    verify_credentials
    install_runner
    configure_runner

    echo ""
    if confirm "Start the runner now?"; then
        start_runner
    fi

    print_summary
}

# Run main
main "$@"
