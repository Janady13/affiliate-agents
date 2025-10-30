#!/bin/bash

# Affiliate Agents - Linux Setup Script
# This script sets up the affiliate agents project on Linux

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
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

# Banner
echo "=================================================="
echo "  Affiliate Agents - Linux Setup"
echo "=================================================="
echo ""

# Detect Linux distribution
log_info "Detecting Linux distribution..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    log_info "Detected: $OS $VER"
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
    log_info "Detected: $OS $VER"
else
    OS="Unknown"
    log_warning "Could not detect Linux distribution"
fi

echo ""
log_info "Starting setup process..."
echo ""

# Check for Git
log_info "Checking for Git..."
if ! command -v git &> /dev/null; then
    log_error "Git is not installed."
    echo ""
    log_info "Install Git with:"
    echo "  Ubuntu/Debian: sudo apt-get update && sudo apt-get install git"
    echo "  Fedora/RHEL:   sudo dnf install git"
    echo "  Arch Linux:    sudo pacman -S git"
    exit 1
fi
log_success "Git is installed: $(git --version)"

# Check if we're in a git repository
log_info "Checking repository status..."
if [ ! -d .git ]; then
    log_error "Not in a git repository."
    log_info "Please run this script from the affiliate-agents directory."
    exit 1
fi
log_success "Repository detected"

# Get repository information
REPO_URL=$(git config --get remote.origin.url)
CURRENT_BRANCH=$(git branch --show-current)

echo ""
log_info "Repository: $REPO_URL"
log_info "Current branch: $CURRENT_BRANCH"
echo ""

# Check for agent directories
log_info "Scanning agent directories..."
AGENT_COUNT=$(find . -maxdepth 1 -type d -name "AGENT*" | wc -l | tr -d ' ')
log_success "Found $AGENT_COUNT agent directories"

# Verify structure
log_info "Verifying project structure..."
MISSING_FILES=0

if [ ! -f .nojekyll ]; then
    log_warning ".nojekyll file is missing"
    log_info "Creating .nojekyll file..."
    touch .nojekyll
    log_success "Created .nojekyll file"
fi

if [ ! -f .gitignore ]; then
    log_warning ".gitignore file is missing"
    log_info "Creating .gitignore file..."
    cat > .gitignore << 'EOF'
# macOS
.DS_Store
.AppleDouble
.LSOverride

# Linux
*~
.directory

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Logs
*.log

# Temporary files
*.tmp
.cache/
EOF
    log_success "Created .gitignore file"
fi

# Sample agent validation
log_info "Validating sample agent structure..."
if [ -d "AGENT4001" ]; then
    if [ -f "AGENT4001/index.html" ]; then
        log_success "AGENT4001/index.html exists"
    else
        log_error "AGENT4001/index.html is missing"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi

    if [ -f "AGENT4001/qr.png" ]; then
        log_success "AGENT4001/qr.png exists"
    else
        log_warning "AGENT4001/qr.png is missing"
    fi
else
    log_error "AGENT4001 directory not found"
fi

echo ""
log_info "Checking for optional dependencies..."

# Check for Python (for local testing)
if command -v python3 &> /dev/null; then
    log_success "Python 3 is installed: $(python3 --version)"
    log_info "You can test locally with: python3 -m http.server 8000"
else
    log_warning "Python 3 not found (optional for local testing)"
    log_info "Install with:"
    echo "  Ubuntu/Debian: sudo apt-get install python3"
    echo "  Fedora/RHEL:   sudo dnf install python3"
    echo "  Arch Linux:    sudo pacman -S python"
fi

# Check for curl
if command -v curl &> /dev/null; then
    log_success "curl is installed"
else
    log_warning "curl not found (optional)"
fi

# Check for wget
if command -v wget &> /dev/null; then
    log_success "wget is installed"
else
    log_warning "wget not found (optional)"
fi

# Check for Node.js
if command -v node &> /dev/null; then
    log_success "Node.js is installed: $(node --version)"
    log_info "You can test locally with: npx http-server -p 8000"
else
    log_warning "Node.js not found (optional for local testing)"
fi

echo ""
log_info "File permissions check..."
# Make sure files are readable
find . -name "*.html" -type f -exec chmod 644 {} \; 2>/dev/null || true
find . -name "*.png" -type f -exec chmod 644 {} \; 2>/dev/null || true
log_success "File permissions verified"

echo ""
log_info "Setup summary:"
echo "  - Operating System: $OS"
echo "  - Git: ✓"
echo "  - Repository: ✓"
echo "  - Agent directories: $AGENT_COUNT"
echo "  - Project structure: ✓"

if [ $MISSING_FILES -gt 0 ]; then
    log_warning "Some files are missing. Please review the warnings above."
fi

echo ""
log_info "GitHub Pages deployment instructions:"
echo ""
echo "1. Push your changes to GitHub:"
echo "   git add ."
echo "   git commit -m 'Setup complete'"
echo "   git push origin $CURRENT_BRANCH"
echo ""
echo "2. Enable GitHub Pages:"
echo "   - Go to: https://github.com/Janady13/affiliate-agents/settings/pages"
echo "   - Source: Deploy from branch"
echo "   - Branch: $CURRENT_BRANCH"
echo "   - Folder: / (root)"
echo "   - Click 'Save'"
echo ""
echo "3. Your site will be available at:"
echo "   https://janady13.github.io/affiliate-agents/"
echo ""

log_info "To test locally, run:"
echo "   python3 -m http.server 8000"
echo "   Then visit: http://localhost:8000/AGENT4001/"
echo ""

log_success "Setup complete! ✓"
echo ""
echo "=================================================="
echo "  Need help? Check README.md for documentation"
echo "=================================================="
