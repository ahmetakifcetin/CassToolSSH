#!/bin/bash

# CassToolSSH - Beautiful Server Greeting System
# Version: 1.0.1
# Author: Joel & Community
# License: MIT

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Banner
echo -e "${PURPLE}${BOLD}"
cat << "EOF"
 ██████╗ █████╗ ███████╗███████╗███████╗███╗   ███╗ █████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║
██║     ███████║███████╗███████╗█████╗  ██╔████╔██║███████║██████╔╝██████╔╝██║   ██║██║ █╗ ██║
██║     ██╔══██║╚════██║╚════██║██╔══╝  ██║╚██╔╝██║██╔══██║██╔══██╗██╔══██╗██║   ██║██║███╗██║
╚██████╗██║  ██║███████║███████║███████╗██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║╚██████╔╝╚███╔███╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ 
EOF
echo -e "${NC}"
echo -e "${CYAN}${BOLD}Beautiful Server Greeting System${NC}"
echo -e "${YELLOW}Installation Script v1.0.1 (Fixed)${NC}"
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script must be run as root${NC}" 
   exit 1
fi

echo -e "${GREEN}[✓]${NC} Running as root"

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    echo -e "${RED}[✗]${NC} Cannot detect OS"
    exit 1
fi

echo -e "${GREEN}[✓]${NC} Detected OS: $OS $VER"

# Check if Ubuntu/Debian based
if [[ ! "$OS" =~ "Ubuntu" ]] && [[ ! "$OS" =~ "Debian" ]]; then
    echo -e "${YELLOW}[!]${NC} Warning: This script is designed for Ubuntu/Debian"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Installation directory
INSTALL_DIR="/opt/CassToolSSH"
CONFIG_FILE="/etc/CassToolSSH.conf"

printf "\n"
echo -e "${CYAN}${BOLD}Installation Options:${NC}"
echo -e "  Installation directory: ${YELLOW}$INSTALL_DIR${NC}"
echo -e "  Configuration file: ${YELLOW}$CONFIG_FILE${NC}"
printf "\n"

read -p "Proceed with installation? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Installation cancelled${NC}"
    exit 0
fi

printf "\n"
echo -e "${BLUE}[→]${NC} Creating installation directory..."
mkdir -p "$INSTALL_DIR"

# Create configuration file
echo -e "${BLUE}[→]${NC} Creating configuration file..."
cat > "$CONFIG_FILE" << 'CONFIGEOF'
# CassToolSSH Configuration File
# Customize your server greeting here

# Display Settings
SHOW_HOSTNAME=true
SHOW_KERNEL=true
SHOW_UPTIME=true
SHOW_LOAD=true
SHOW_MEMORY=true
SHOW_DISK=true
SHOW_IP=true
SHOW_DOCKER=true
SHOW_SERVICES=true
SHOW_LAST_LOGIN=true

# Custom Text
SYSTEM_NAME="CassToolSSH Infrastructure"
SYSTEM_VERSION="v1.0"
CUSTOM_MESSAGE=""

# Color Theme (options: blue, green, purple, cyan, red, yellow)
COLOR_THEME="cyan"

# ASCII Art Style (options: CassToolSSH, minimal, blocks, simple)
ASCII_STYLE="CassToolSSH"

# Services to monitor (space-separated)
MONITORED_SERVICES="nginx docker postgresql mysql"

# Custom header text (leave empty for default)
CUSTOM_HEADER=""
CONFIGEOF

echo -e "${GREEN}[✓]${NC} Configuration file created: $CONFIG_FILE"

# Create the main MOTD script
echo -e "${BLUE}[→]${NC} Creating MOTD script..."
cat > "$INSTALL_DIR/motd.sh" << 'SCRIPTEOF'
#!/bin/bash

# Load configuration
if [ -f /etc/CassToolSSH.conf ]; then
    source /etc/CassToolSSH.conf
else
    SHOW_HOSTNAME=true
    SHOW_KERNEL=true
    SHOW_UPTIME=true
    SHOW_LOAD=true
    SHOW_MEMORY=true
    SHOW_DISK=true
    SHOW_IP=true
    SHOW_DOCKER=true
    SHOW_SERVICES=true
    SHOW_LAST_LOGIN=true
    SYSTEM_NAME="CassToolSSH Infrastructure"
    SYSTEM_VERSION="v1.0"
    COLOR_THEME="cyan"
    ASCII_STYLE="CassToolSSH"
    MONITORED_SERVICES="nginx docker postgresql mysql"
fi

# Color definitions
case $COLOR_THEME in
    blue)
        PRIMARY='\033[0;34m'
        BRIGHT='\033[1;34m'
        ;;
    green)
        PRIMARY='\033[0;32m'
        BRIGHT='\033[1;32m'
        ;;
    purple)
        PRIMARY='\033[0;35m'
        BRIGHT='\033[1;35m'
        ;;
    cyan)
        PRIMARY='\033[0;36m'
        BRIGHT='\033[1;36m'
        ;;
    red)
        PRIMARY='\033[0;31m'
        BRIGHT='\033[1;31m'
        ;;
    yellow)
        PRIMARY='\033[0;33m'
        BRIGHT='\033[1;33m'
        ;;
    *)
        PRIMARY='\033[0;36m'
        BRIGHT='\033[1;36m'
        ;;
esac

SECONDARY='\033[0;37m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m'

# ASCII Art
print_ascii_art() {
    case $ASCII_STYLE in
        CassToolSSH)
            echo -e "${BRIGHT}"
            cat << "EOF"
 ██████╗ █████╗ ███████╗███████╗███╗   ███╗ █████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║
██║     ███████║███████╗███████╗██╔████╔██║███████║██████╔╝██████╔╝██║   ██║██║ █╗ ██║
██║     ██╔══██║╚════██║╚════██║██║╚██╔╝██║██╔══██║██╔══██╗██╔══██╗██║   ██║██║███╗██║
╚██████╗██║  ██║███████║███████║██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║╚██████╔╝╚███╔███╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝
EOF
            ;;
        minimal)
            echo -e "${BRIGHT}"
            echo "╔═══════════════════════════════════════╗"
            echo "║        C A S S T O O L S S H          ║"
            echo "╚═══════════════════════════════════════╝"
            ;;
        blocks)
            echo -e "${BRIGHT}"
            cat << "EOF"
█▀▀ ▄▀█ █▀ █▀ ▀█▀ █▀█ █▀█ █   █▀ █▀ █ █
█▄▄ █▀█ ▄█ ▄█  █  █▄█ █▄█ █▄▄ ▄█ ▄█ █▀█
EOF
            ;;
        simple)
            echo -e "${BRIGHT}"
            echo "=================================="
            echo "      C A S S T O O L S S H"
            echo "=================================="
            ;;
    esac
    echo -e "${NC}"
}

# Helper functions
get_uptime() {
    uptime -p | sed 's/up //'
}

get_load() {
    cat /proc/loadavg | awk '{print $1", "$2", "$3}'
}

get_memory() {
    free -m | awk 'NR==2{printf "%dMB used / %dMB total (%.1f%%)", $3, $2, $3*100/$2}'
}

get_disk() {
    df -h / | awk 'NR==2{printf "%s used / %s total (%s)", $3, $2, $5}'
}

get_ip() {
    ip -4 addr show scope global | grep inet | awk '{print $2}' | cut -d/ -f1 | head -1
}

get_public_ip() {
    timeout 2 curl -s ifconfig.me 2>/dev/null || echo "N/A"
}

get_docker_status() {
    if command -v docker &> /dev/null; then
        if systemctl is-active --quiet docker; then
            CONTAINERS=$(docker ps -q | wc -l)
            echo -e "${PRIMARY}●${NC} Running (${CONTAINERS} containers)"
        else
            echo -e "\033[0;31m●${NC} Stopped"
        fi
    else
        echo -e "${DIM}Not installed${NC}"
    fi
}

check_service() {
    local service=$1
    if systemctl list-unit-files | grep -q "^${service}.service"; then
        if systemctl is-active --quiet "$service"; then
            echo -e "${PRIMARY}●${NC} ${service}"
        else
            echo -e "\033[0;31m●${NC} ${service}"
        fi
    fi
}

get_last_login() {
    last -n 1 -F | head -1
}

# Main display
clear
print_ascii_art

# Header
if [ -n "$CUSTOM_HEADER" ]; then
    echo -e "${BRIGHT}${CUSTOM_HEADER}${NC}"
else
    echo -e "${PRIMARY}${BOLD}${SYSTEM_NAME}${NC}"
fi
echo -e "${SECONDARY}Version: ${SYSTEM_VERSION}${NC}"
echo -e "${SECONDARY}Status: ${PRIMARY}[ ${BOLD}ONLINE${NC}${PRIMARY} ]${NC}"
echo ""

# System Information
echo -e "${BRIGHT}═══════════════════════════════════════════════════════════════════${NC}"

if [ "$SHOW_HOSTNAME" = true ]; then
    echo -e "${PRIMARY}${BOLD}Host:${NC}           $(hostname -f)"
fi

if [ "$SHOW_KERNEL" = true ]; then
    echo -e "${PRIMARY}${BOLD}Kernel:${NC}         $(uname -r)"
fi

if [ "$SHOW_UPTIME" = true ]; then
    echo -e "${PRIMARY}${BOLD}Uptime:${NC}         $(get_uptime)"
fi

if [ "$SHOW_LOAD" = true ]; then
    echo -e "${PRIMARY}${BOLD}Load Average:${NC}   $(get_load)"
fi

if [ "$SHOW_MEMORY" = true ]; then
    echo -e "${PRIMARY}${BOLD}Memory:${NC}         $(get_memory)"
fi

if [ "$SHOW_DISK" = true ]; then
    echo -e "${PRIMARY}${BOLD}Disk /:${NC}         $(get_disk)"
fi

if [ "$SHOW_IP" = true ]; then
    LOCAL_IP=$(get_ip)
    PUBLIC_IP=$(get_public_ip)
    echo -e "${PRIMARY}${BOLD}Local IP:${NC}       ${LOCAL_IP}"
    if [ "$PUBLIC_IP" != "N/A" ]; then
        echo -e "${PRIMARY}${BOLD}Public IP:${NC}      ${PUBLIC_IP}"
    fi
fi

# Docker Status
if [ "$SHOW_DOCKER" = true ]; then
    echo ""
    echo -e "${PRIMARY}${BOLD}Docker:${NC}         $(get_docker_status)"
fi

# Services Status
if [ "$SHOW_SERVICES" = true ] && [ -n "$MONITORED_SERVICES" ]; then
    echo ""
    echo -e "${PRIMARY}${BOLD}Services:${NC}"
    for service in $MONITORED_SERVICES; do
        check_service "$service"
    done
fi

# Last Login
if [ "$SHOW_LAST_LOGIN" = true ]; then
    echo ""
    echo -e "${PRIMARY}${BOLD}Last Login:${NC}"
    echo -e "${SECONDARY}$(get_last_login)${NC}"
fi

echo ""
echo -e "${BRIGHT}═══════════════════════════════════════════════════════════════════${NC}"

# Custom message
if [ -n "$CUSTOM_MESSAGE" ]; then
    echo ""
    echo -e "${SECONDARY}${CUSTOM_MESSAGE}${NC}"
    echo ""
fi

echo ""
SCRIPTEOF

chmod +x "$INSTALL_DIR/motd.sh"
echo -e "${GREEN}[✓]${NC} MOTD script created"

# Backup existing MOTD
echo -e "${BLUE}[→]${NC} Backing up existing MOTD..."
if [ -d /etc/update-motd.d ]; then
    mkdir -p /etc/update-motd.d.backup
    cp -r /etc/update-motd.d/* /etc/update-motd.d.backup/ 2>/dev/null || true
    echo -e "${GREEN}[✓]${NC} Backup created at /etc/update-motd.d.backup"
fi

# Disable default Ubuntu MOTD scripts
echo -e "${BLUE}[→]${NC} Disabling default MOTD scripts..."
if [ -d /etc/update-motd.d ]; then
    chmod -x /etc/update-motd.d/* 2>/dev/null || true
fi

# Clear static MOTD files
echo "" > /etc/motd
rm -f /etc/motd.dynamic

# Create new MOTD script in update-motd.d
echo -e "${BLUE}[→]${NC} Installing CassToolSSH MOTD..."
cat > /etc/update-motd.d/00-CassToolSSH << 'MOTDEOF'
#!/bin/bash
/opt/CassToolSSH/motd.sh
MOTDEOF

chmod +x /etc/update-motd.d/00-CassToolSSH
echo -e "${GREEN}[✓]${NC} CassToolSSH MOTD installed"

# Create uninstall script
echo -e "${BLUE}[→]${NC} Creating uninstall script..."
cat > "$INSTALL_DIR/uninstall.sh" << 'UNINSTALLEOF'
#!/bin/bash

echo "Uninstalling CassToolSSH..."

# Restore backups
if [ -d /etc/update-motd.d.backup ]; then
    rm -f /etc/update-motd.d/*
    cp -r /etc/update-motd.d.backup/* /etc/update-motd.d/
    chmod +x /etc/update-motd.d/*
    rm -rf /etc/update-motd.d.backup
fi

# Remove CassToolSSH files
rm -rf /opt/CassToolSSH
rm -f /etc/CassToolSSH.conf

echo "CassToolSSH has been uninstalled"
UNINSTALLEOF

chmod +x "$INSTALL_DIR/uninstall.sh"

# Create customization helper
cat > "$INSTALL_DIR/customize.sh" << 'CUSTOMEOF'
#!/bin/bash

CONFIG_FILE="/etc/CassToolSSH.conf"

echo "CassToolSSH Customization Helper"
echo "================================"
echo ""

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found"
    exit 1
fi

# Menu
while true; do
    echo ""
    echo "1. Change color theme"
    echo "2. Change ASCII style"
    echo "3. Edit system name"
    echo "4. Add monitored services"
    echo "5. Toggle display options"
    echo "6. Edit configuration file directly"
    echo "7. Test current configuration"
    echo "8. Exit"
    echo ""
    read -p "Select option: " choice

    case $choice in
        1)
            echo "Available themes: blue, green, purple, cyan, red, yellow"
            read -p "Enter theme: " theme
            sed -i "s/COLOR_THEME=.*/COLOR_THEME=\"$theme\"/" "$CONFIG_FILE"
            echo "Theme updated!"
            ;;
        2)
            echo "Available styles: CassToolSSH, minimal, blocks, simple"
            read -p "Enter style: " style
            sed -i "s/ASCII_STYLE=.*/ASCII_STYLE=\"$style\"/" "$CONFIG_FILE"
            echo "Style updated!"
            ;;
        3)
            read -p "Enter system name: " name
            sed -i "s/SYSTEM_NAME=.*/SYSTEM_NAME=\"$name\"/" "$CONFIG_FILE"
            echo "System name updated!"
            ;;
        4)
            read -p "Enter services (space-separated): " services
            sed -i "s/MONITORED_SERVICES=.*/MONITORED_SERVICES=\"$services\"/" "$CONFIG_FILE"
            echo "Services updated!"
            ;;
        5)
            nano "$CONFIG_FILE"
            ;;
        6)
            ${EDITOR:-nano} "$CONFIG_FILE"
            ;;
        7)
            /opt/CassToolSSH/motd.sh
            ;;
        8)
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done
CUSTOMEOF

chmod +x "$INSTALL_DIR/customize.sh"

echo ""
echo -e "${BRIGHT}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}✓ Installation Complete!${NC}"
echo -e "${BRIGHT}═══════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYAN}${BOLD}Next Steps:${NC}"
echo -e "  1. Edit configuration: ${YELLOW}nano /etc/CassToolSSH.conf${NC}"
echo -e "  2. Customize settings: ${YELLOW}/opt/CassToolSSH/customize.sh${NC}"
echo -e "  3. Test your MOTD: ${YELLOW}/opt/CassToolSSH/motd.sh${NC}"
echo -e "  4. Uninstall: ${YELLOW}/opt/CassToolSSH/uninstall.sh${NC}"
echo ""
echo -e "${CYAN}${BOLD}Quick Customization:${NC}"
echo -e "  Color themes: ${YELLOW}blue, green, purple, cyan, red, yellow${NC}"
echo -e "  ASCII styles: ${YELLOW}CassToolSSH, minimal, blocks, simple${NC}"
echo ""
echo -e "${PRIMARY}${BOLD}Log out and log back in to see your new server greeting!${NC}"
echo ""
echo -e "${DIM}For more info: https://github.com/ahmetakifcetin/CassToolSSH${NC}"
echo ""