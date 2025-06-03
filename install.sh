#!/usr/bin/env bash

set -e 

# Colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BOLD="\033[1m"
RESET="\033[0m"

info()    { echo -e "${YELLOW}➡️  $1${RESET}"; }
success() { echo -e "${GREEN}✅ $1${RESET}"; }
warn()    { echo -e "${YELLOW}⚠️ $1${RESET}"; }
error()   { echo -e "${RED}❌ $1${RESET}"; }

# Check requirements
info "Checking required tools..."

if ! command -v cargo >/dev/null 2>&1; then
    error "No Rust installation found. Please visit https://rustup.rs/ to install it."
    exit 1
else
    success "Found Rust installation."
fi

if ! command -v ollama >/dev/null 2>&1; then
    error "Ollama not found. Scout will still work, but AI features will be unavailable."
else
    success "Found Ollama installation."
fi

# Build Scout
info "Building Scout in release mode..."
cargo build --release

INSTALL_DIR="$HOME/.local/bin"
BINARY_NAME="scout"
TARGET_BINARY="target/release/$BINARY_NAME"

info "Installing Scout to ${BOLD}$INSTALL_DIR${RESET}..."
mkdir -p "$INSTALL_DIR"
cp "$TARGET_BINARY" "$INSTALL_DIR"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    warn "Detected that $INSTALL_DIR is not in your PATH yet."

    read -p "👉 Do you want to add it to your PATH automatically? [Y/n] " -r
    echo
    if [[ $REPLY =~ ^[Yy]?$ ]]; then
        SHELL_CONFIG=""
        if [[ $SHELL == *zsh ]]; then
            SHELL_CONFIG="$HOME/.zshrc"
        elif [[ $SHELL == */bash ]]; then
            SHELL_CONFIG="$HOME/.bashrc"
        else
            SHELL_CONFIG="$HOME/.profile"
        fi

        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
        success "Added $INSTALL_DIR to PATH in $SHELL_CONFIG."
        echo -e "${YELLOW} ⚠️ Please restart your terminal or run: ${BOLD}source $SHELL_CONFIG${RESET}${YELLOW} to apply changes.${RESET}"
    else
        echo -e "${YELLOW}📝 Reminder: please manually add this to your shell config:"
        echo -e "   ${BOLD}export PATH=\"\$HOME/.local/bin:\$PATH\"${RESET}"
    fi
else
    success "🎉 Scout is installed and on your PATH."
fi

echo -e "\n${GREEN}🚀 We're all set! Run ${BOLD}scout${RESET}${GREEN} to get started.${RESET}"
