#!/bin/bash

# Automated ZSH installation script with Oh My Zsh, Starship and plugins
# 100% Automated

set -e  # Stop script on errors

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   Automated ZSH Setup Installation     ${NC}"
echo -e "${GREEN}========================================${NC}\n"

# Function to display messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detectar o sistema operacional
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            OS="debian"
        elif [ -f /etc/redhat-release ]; then
            OS="redhat"
        else
            OS="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
    log_info "Operating system detected: $OS"
}

# Check basic dependencies
check_dependencies() {
    log_info "Checking basic dependencies..."
    local missing=()
    
    if ! command -v curl &> /dev/null; then
        missing+=("curl")
    fi
    
    if ! command -v git &> /dev/null; then
        missing+=("git")
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        log_error "Missing dependencies: ${missing[*]}"
        log_info "Attempting to install dependencies..."
        
        if [ "$OS" == "debian" ]; then
            sudo apt update && sudo apt install -y "${missing[@]}"
        elif [ "$OS" == "macos" ]; then
            if ! command -v brew &> /dev/null; then
                log_error "Homebrew not found. Please install manually: curl and git"
                exit 1
            fi
            brew install "${missing[@]}"
        elif [ "$OS" == "redhat" ]; then
            sudo yum install -y "${missing[@]}"
        fi
    else
        log_info "All basic dependencies are installed"
    fi
}

# Install ZSH
install_zsh() {
    log_info "Checking ZSH installation..."
    if command -v zsh &> /dev/null; then
        log_warning "ZSH is already installed"
        return 0
    fi

    log_info "Installing ZSH..."
    if [ "$OS" == "debian" ]; then
        sudo apt update
        sudo apt install -y zsh curl git
    elif [ "$OS" == "macos" ]; then
        if ! command -v brew &> /dev/null; then
            log_error "Homebrew not found. Please install Homebrew first."
            exit 1
        fi
        brew install zsh curl git
    elif [ "$OS" == "redhat" ]; then
        sudo yum install -y zsh curl git
    else
        log_error "Operating system not supported"
        exit 1
    fi
    log_info "ZSH installed successfully!"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    log_info "Checking Oh My Zsh installation..."
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_warning "Oh My Zsh is already installed"
        return 0
    fi

    log_info "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_info "Oh My Zsh installed successfully!"
}

# Install Starship
install_starship() {
    log_info "Checking Starship installation..."
    if command -v starship &> /dev/null; then
        log_warning "Starship is already installed"
        return 0
    fi

    log_info "Installing Starship..."
    
    # For macOS, use homebrew if available
    if [ "$OS" == "macos" ] && command -v brew &> /dev/null; then
        brew install starship
    else
        # Create bin directory if it doesn't exist
        if [ ! -d "$HOME/.local/bin" ]; then
            mkdir -p "$HOME/.local/bin"
        fi
        
        # Add to PATH if necessary
        if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
            export PATH="$HOME/.local/bin:$PATH"
        fi
        
        curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir "$HOME/.local/bin"
    fi
    
    log_info "Starship installed successfully!"
}

# Install ZSH Syntax Highlighting
install_syntax_highlighting() {
    log_info "Checking ZSH Syntax Highlighting installation..."
    PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    
    if [ -d "$PLUGIN_DIR" ]; then
        log_warning "ZSH Syntax Highlighting is already installed"
        return 0
    fi

    log_info "Installing ZSH Syntax Highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR"
    log_info "ZSH Syntax Highlighting installed successfully!"
}

# Install ZSH Autosuggestions
install_autosuggestions() {
    log_info "Checking ZSH Autosuggestions installation..."
    PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    
    if [ -d "$PLUGIN_DIR" ]; then
        log_warning "ZSH Autosuggestions is already installed"
        return 0
    fi

    log_info "Installing ZSH Autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
    log_info "ZSH Autosuggestions installed successfully!"
}

# Install fzf
install_fzf() {
    log_info "Checking fzf installation..."
    if [ -d "$HOME/.fzf" ]; then
        log_warning "fzf is already installed"
        return 0
    fi

    log_info "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
    log_info "fzf installed successfully!"
}

# Check optional tools
check_optional_tools() {
    log_info "Checking optional tools configured in plugins..."
    
    local missing_tools=()
    
    # Check AWS CLI
    if ! command -v aws &> /dev/null; then
        missing_tools+=("AWS CLI")
    fi
    
    # Check Terraform
    if ! command -v terraform &> /dev/null; then
        missing_tools+=("Terraform")
    fi
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        missing_tools+=("Docker")
    fi
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        log_warning "The following tools are configured as plugins but were not found:"
        for tool in "${missing_tools[@]}"; do
            echo "  - $tool"
        done
        echo ""
        echo -e "${YELLOW}Installation instructions:${NC}"
        
        if [[ " ${missing_tools[@]} " =~ " AWS CLI " ]]; then
            if [ "$OS" == "macos" ]; then
                echo "  AWS CLI (macOS): brew install awscli"
            else
                echo "  AWS CLI (Linux): https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
            fi
        fi
        
        if [[ " ${missing_tools[@]} " =~ " Terraform " ]]; then
            if [ "$OS" == "macos" ]; then
                echo "  Terraform (macOS): brew tap hashicorp/tap && brew install hashicorp/tap/terraform"
            else
                echo "  Terraform (Linux): https://developer.hashicorp.com/terraform/downloads"
            fi
        fi
        
        if [[ " ${missing_tools[@]} " =~ " Docker " ]]; then
            if [ "$OS" == "macos" ]; then
                echo "  Docker (macOS): brew install --cask docker"
            else
                echo "  Docker (Linux): https://docs.docker.com/engine/install/"
            fi
        fi
        echo ""
    else
        log_info "All optional tools are installed!"
    fi
}

# Copy configuration file
setup_zshrc() {
    log_info "Configuring .zshrc..."
    
    # Backup existing .zshrc
    if [ -f "$HOME/.zshrc" ]; then
        log_warning "Creating backup of existing .zshrc..."
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Copy custom configuration
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cp "$SCRIPT_DIR/zsh.rc" "$HOME/.zshrc"
    log_info ".zshrc file configured successfully!"
}

# Set ZSH as default shell
set_default_shell() {
    log_info "Checking default shell..."
    
    if [ "$SHELL" == "$(which zsh)" ]; then
        log_warning "ZSH is already the default shell"
        return 0
    fi

    log_info "Setting ZSH as default shell..."
    
    # Add ZSH to valid shells if not already there
    if ! grep -q "$(which zsh)" /etc/shells; then
        echo "$(which zsh)" | sudo tee -a /etc/shells
    fi
    
    # Change default shell
    chsh -s "$(which zsh)"
    log_info "ZSH set as default shell!"
    log_warning "You will need to logout and login again for the change to take effect"
}

# Função principal
main() {
    detect_os
    echo ""
    
    check_dependencies
    echo ""
    
    install_zsh
    echo ""
    
    install_oh_my_zsh
    echo ""
    
    install_starship
    echo ""
    
    install_syntax_highlighting
    echo ""
    
    install_autosuggestions
    echo ""
    
    install_fzf
    echo ""
    
    check_optional_tools
    echo ""
    
    setup_zshrc
    echo ""
    
    set_default_shell
    echo ""
    
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}   Installation Completed Successfully! ${NC}"
    echo -e "${GREEN}========================================${NC}\n"
    echo -e "${YELLOW}To activate ZSH, run one of the following commands:${NC}"
    echo -e "  1. ${GREEN}zsh${NC} (temporary, current session only)"
    echo -e "  2. Logout and login again (permanent)\n"
    echo -e "${YELLOW}To test immediately, run:${NC} ${GREEN}exec zsh${NC}\n"
}

# Run the script
main
