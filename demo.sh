#!/bin/bash

# CassMarrow Demo Script
# Shows all available features and styles

echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                    CassMarrow Feature Demo                        ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

# Temporary config for demo
TEMP_CONFIG="/tmp/cassmarrow_demo.conf"

show_demo() {
    local style=$1
    local theme=$2
    local title=$3
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " $title"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    cat > "$TEMP_CONFIG" << EOF
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
SYSTEM_NAME="CassMarrow Demo Infrastructure"
SYSTEM_VERSION="v1.0 Demo"
COLOR_THEME="$theme"
ASCII_STYLE="$style"
MONITORED_SERVICES="nginx docker postgresql"
CUSTOM_MESSAGE="This is a demo of CassMarrow server greeting system"
EOF
    
    # Create temporary motd script
    cat > /tmp/demo_motd.sh << 'DEMOSCRIPT'
#!/bin/bash
source /tmp/cassmarrow_demo.conf

case $COLOR_THEME in
    blue) PRIMARY='\033[0;34m'; BRIGHT='\033[1;34m' ;;
    green) PRIMARY='\033[0;32m'; BRIGHT='\033[1;32m' ;;
    purple) PRIMARY='\033[0;35m'; BRIGHT='\033[1;35m' ;;
    cyan) PRIMARY='\033[0;36m'; BRIGHT='\033[1;36m' ;;
    red) PRIMARY='\033[0;31m'; BRIGHT='\033[1;31m' ;;
    yellow) PRIMARY='\033[0;33m'; BRIGHT='\033[1;33m' ;;
    *) PRIMARY='\033[0;36m'; BRIGHT='\033[1;36m' ;;
esac

SECONDARY='\033[0;37m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m'

print_ascii_art() {
    case $ASCII_STYLE in
        cassmarrow)
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
            echo "║        C A S S M A R R O W            ║"
            echo "╚═══════════════════════════════════════╝"
            ;;
        blocks)
            echo -e "${BRIGHT}"
            cat << "EOF"
█▀▀ ▄▀█ █▀ █▀ █▀▄▀█ ▄▀█ █▀█ █▀█ █▀█ █ █ █
█▄▄ █▀█ ▄█ ▄█ █ ▀ █ █▀█ █▀▄ █▀▄ █▄█ ▀▄▀▄▀
EOF
            ;;
        simple)
            echo -e "${BRIGHT}"
            echo "=================================="
            echo "      C A S S M A R R O W"
            echo "=================================="
            ;;
    esac
    echo -e "${NC}"
}

print_ascii_art
echo -e "${PRIMARY}${BOLD}${SYSTEM_NAME}${NC}"
echo -e "${SECONDARY}Version: ${SYSTEM_VERSION}${NC}"
echo -e "${SECONDARY}Status: ${PRIMARY}[ ${BOLD}ONLINE${NC}${PRIMARY} ]${NC}"
echo ""
echo -e "${BRIGHT}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${PRIMARY}${BOLD}Host:${NC}           demo.cassmarrow.local"
echo -e "${PRIMARY}${BOLD}Kernel:${NC}         6.8.0-88-generic"
echo -e "${PRIMARY}${BOLD}Uptime:${NC}         7 days, 3 hours, 42 minutes"
echo -e "${PRIMARY}${BOLD}Load Average:${NC}   0.45, 0.38, 0.32"
echo -e "${PRIMARY}${BOLD}Memory:${NC}         3854MB used / 7941MB total (48.5%)"
echo -e "${PRIMARY}${BOLD}Disk /:${NC}         118G used / 145G total (81%)"
echo -e "${PRIMARY}${BOLD}Local IP:${NC}       192.168.1.100"
echo -e "${PRIMARY}${BOLD}Public IP:${NC}      203.0.113.42"
echo ""
echo -e "${PRIMARY}${BOLD}Docker:${NC}         ${PRIMARY}●${NC} Running (8 containers)"
echo ""
echo -e "${PRIMARY}${BOLD}Services:${NC}"
echo -e "${PRIMARY}●${NC} nginx"
echo -e "${PRIMARY}●${NC} docker"
echo -e "${PRIMARY}●${NC} postgresql"
echo ""
echo -e "${PRIMARY}${BOLD}Last Login:${NC}"
echo -e "${SECONDARY}admin    pts/0        Mon Dec  8 10:30 - 14:45  (04:15)${NC}"
echo ""
echo -e "${BRIGHT}═══════════════════════════════════════════════════════════════════${NC}"
if [ -n "$CUSTOM_MESSAGE" ]; then
    echo ""
    echo -e "${SECONDARY}${CUSTOM_MESSAGE}${NC}"
    echo ""
fi
DEMOSCRIPT

    chmod +x /tmp/demo_motd.sh
    /tmp/demo_motd.sh
    
    echo ""
    read -p "Press Enter to continue..."
}

# Demo 1: CassMarrow style with Cyan theme
show_demo "cassmarrow" "cyan" "Style: CassMarrow (Default) | Theme: Cyan"

# Demo 2: CassMarrow style with Purple theme
show_demo "cassmarrow" "purple" "Style: CassMarrow | Theme: Purple"

# Demo 3: Minimal style with Green theme
show_demo "minimal" "green" "Style: Minimal | Theme: Green"

# Demo 4: Blocks style with Blue theme
show_demo "blocks" "blue" "Style: Blocks | Theme: Blue"

# Demo 5: Simple style with Yellow theme
show_demo "simple" "yellow" "Style: Simple | Theme: Yellow"

# Demo 6: CassMarrow style with Red theme
show_demo "cassmarrow" "red" "Style: CassMarrow | Theme: Red"

# Cleanup
rm -f "$TEMP_CONFIG" /tmp/demo_motd.sh

echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                         Demo Complete!                             ║"
echo "╠════════════════════════════════════════════════════════════════════╣"
echo "║  Install CassMarrow:                                              ║"
echo "║  curl -fsSL https://cassmarrow.sh/install | sudo bash             ║"
echo "║                                                                    ║"
echo "║  GitHub: https://github.com/ahmetakifcetin/cassmarrow               ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""
