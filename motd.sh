#!/bin/bash

# CassMarrow - Advanced MOTD Script with Dynamic Themes
# Version: 2.0.0

# Load configuration
if [ -f /etc/cassmarrow.conf ]; then
    source /etc/cassmarrow.conf
else
    # Defaults
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
    SYSTEM_NAME="Production Infrastructure"
    SYSTEM_VERSION="v1.0"
    COLOR_THEME="ice"
    ASCII_STYLE="cassmarrow"
    MONITORED_SERVICES="nginx docker postgresql mysql redis"
    MOTD_ENABLED="true"
fi

# Check if MOTD is enabled
if [ "$MOTD_ENABLED" != "true" ]; then
    exit 0
fi

# Load theme colors
load_theme() {
    local theme=$1
    
    case $theme in
        # Gradient Themes
        matrix)
            PRIMARY='\033[38;5;46m'
            BRIGHT='\033[38;5;82m'
            ACCENT='\033[38;5;40m'
            DIM='\033[38;5;22m'
            ;;
        ocean)
            PRIMARY='\033[38;5;39m'
            BRIGHT='\033[38;5;51m'
            ACCENT='\033[38;5;33m'
            DIM='\033[38;5;24m'
            ;;
        sunset)
            PRIMARY='\033[38;5;208m'
            BRIGHT='\033[38;5;213m'
            ACCENT='\033[38;5;202m'
            DIM='\033[38;5;166m'
            ;;
        hacker)
            PRIMARY='\033[38;5;28m'
            BRIGHT='\033[38;5;40m'
            ACCENT='\033[38;5;34m'
            DIM='\033[38;5;22m'
            ;;
        neon)
            PRIMARY='\033[38;5;201m'
            BRIGHT='\033[38;5;213m'
            ACCENT='\033[38;5;165m'
            DIM='\033[38;5;127m'
            ;;
        fire)
            PRIMARY='\033[38;5;196m'
            BRIGHT='\033[38;5;208m'
            ACCENT='\033[38;5;202m'
            DIM='\033[38;5;88m'
            ;;
        ice)
            PRIMARY='\033[38;5;51m'
            BRIGHT='\033[38;5;159m'
            ACCENT='\033[38;5;87m'
            DIM='\033[38;5;45m'
            ;;
        corporate)
            PRIMARY='\033[38;5;67m'
            BRIGHT='\033[38;5;75m'
            ACCENT='\033[38;5;61m'
            DIM='\033[38;5;241m'
            ;;
        gold)
            PRIMARY='\033[38;5;220m'
            BRIGHT='\033[38;5;228m'
            ACCENT='\033[38;5;214m'
            DIM='\033[38;5;136m'
            ;;
        dracula)
            PRIMARY='\033[38;5;141m'
            BRIGHT='\033[38;5;183m'
            ACCENT='\033[38;5;135m'
            DIM='\033[38;5;97m'
            ;;
        # Classic Themes
        blue)
            PRIMARY='\033[38;5;33m'
            BRIGHT='\033[38;5;39m'
            ACCENT='\033[38;5;27m'
            DIM='\033[38;5;24m'
            ;;
        green)
            PRIMARY='\033[38;5;34m'
            BRIGHT='\033[38;5;40m'
            ACCENT='\033[38;5;28m'
            DIM='\033[38;5;22m'
            ;;
        purple)
            PRIMARY='\033[38;5;135m'
            BRIGHT='\033[38;5;141m'
            ACCENT='\033[38;5;129m'
            DIM='\033[38;5;97m'
            ;;
        cyan)
            PRIMARY='\033[38;5;51m'
            BRIGHT='\033[38;5;87m'
            ACCENT='\033[38;5;45m'
            DIM='\033[38;5;39m'
            ;;
        red)
            PRIMARY='\033[38;5;196m'
            BRIGHT='\033[38;5;202m'
            ACCENT='\033[38;5;160m'
            DIM='\033[38;5;88m'
            ;;
        yellow)
            PRIMARY='\033[38;5;220m'
            BRIGHT='\033[38;5;226m'
            ACCENT='\033[38;5;214m'
            DIM='\033[38;5;136m'
            ;;
        *)
            # Default to ice
            PRIMARY='\033[38;5;51m'
            BRIGHT='\033[38;5;159m'
            ACCENT='\033[38;5;87m'
            DIM='\033[38;5;45m'
            ;;
    esac
    
    # Common colors
    WHITE='\033[38;5;255m'
    GRAY='\033[38;5;245m'
    DARK_GRAY='\033[38;5;240m'
    BOLD='\033[1m'
    NC='\033[0m'
}

# Load theme
load_theme "$COLOR_THEME"

# ASCII Art Styles
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
            cat << "EOF"
╔════════════════════════════════════════════════════════════════════════════════╗
║                              C A S S M A R R O W                               ║
╠════════════════════════════════════════════════════════════════════════════════╣
EOF
            ;;
        retro)
            echo -e "${BRIGHT}"
            cat << "EOF"
  ___   _   ___ ___ __  __   _   ___ ___  _____      __
 / __| /_\ / __/ __|  \/  | /_\ | _ \ _ \/ _ \ \    / /
| (__ / _ \\__ \__ \ |\/| |/ _ \|   /   / (_) \ \/\/ / 
 \___/_/ \_\___/___/_|  |_/_/ \_\_|_\_|_\\___/ \_/\_/  
EOF
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
    free -m | awk 'NR==2{
        total=$2
        used=$3
        percent=used*100/total
        printf "%d MB / %d MB", used, total
        if (percent >= 90) printf " (⚠ %.1f%%)", percent
        else if (percent >= 75) printf " (%.1f%%)", percent
        else printf " (%.1f%%)", percent
    }'
}

get_disk() {
    df -h / | awk 'NR==2{
        gsub("%","",$5)
        used=$3
        total=$2
        percent=$5
        printf "%s / %s", used, total
        if (percent >= 90) printf " (⚠ %s%%)", percent
        else if (percent >= 75) printf " (%s%%)", percent
        else printf " (%s%%)", percent
    }'
}

get_ip() {
    ip -4 addr show scope global | grep inet | awk '{print $2}' | cut -d/ -f1 | head -1
}

get_public_ip() {
    timeout 2 curl -s ifconfig.me 2>/dev/null || echo "N/A"
}

get_docker_status() {
    if command -v docker &> /dev/null; then
        if systemctl is-active --quiet docker 2>/dev/null; then
            CONTAINERS=$(docker ps -q 2>/dev/null | wc -l)
            if [ "$CONTAINERS" -gt 0 ]; then
                echo -e "${PRIMARY}●${NC} Running ${DIM}($CONTAINERS containers)${NC}"
            else
                echo -e "${GRAY}●${NC} Running ${DIM}(no containers)${NC}"
            fi
        else
            echo -e "${RED}●${NC} Stopped"
        fi
    else
        echo -e "${DIM}not installed${NC}"
    fi
}

check_service() {
    local service=$1
    if systemctl list-unit-files 2>/dev/null | grep -q "^${service}.service"; then
        if systemctl is-active --quiet "$service" 2>/dev/null; then
            echo -e "  ${PRIMARY}●${NC} ${service}"
        else
            echo -e "  ${ACCENT}●${NC} ${service} ${DIM}(stopped)${NC}"
        fi
    fi
}

get_last_login() {
    last -n 1 -F 2>/dev/null | head -1 | awk '{
        if (NF >= 10) {
            printf "%s from %s on %s %s %s at %s", $1, $3, $5, $6, $7, $8
        } else if (NF >= 7) {
            printf "%s from %s on %s %s %s", $1, $3, $5, $6, $7
        } else {
            print $0
        }
    }'
}

get_status_indicator() {
    local load=$(cat /proc/loadavg | awk '{print $1}')
    local cores=$(nproc)
    local load_percent=$(echo "$load $cores" | awk '{printf "%.0f", ($1/$2)*100}')
    
    if [ "$load_percent" -ge 90 ]; then
        echo -e "${ACCENT}● HEAVY LOAD${NC}"
    elif [ "$load_percent" -ge 70 ]; then
        echo -e "${PRIMARY}● MODERATE${NC}"
    else
        echo -e "${PRIMARY}● OPTIMAL${NC}"
    fi
}

# Main display
clear
echo ""
print_ascii_art

# System header with gradient effect
if [ "$ASCII_STYLE" = "retro" ]; then
    echo -e "${WHITE}${BOLD}${SYSTEM_NAME}${NC}  ${DARK_GRAY}│${NC}  ${GRAY}${SYSTEM_VERSION}${NC}  ${DARK_GRAY}│${NC}  $(get_status_indicator)"
else
    echo -e "${WHITE}${BOLD}${SYSTEM_NAME}${NC}  ${DIM}│${NC}  ${GRAY}${SYSTEM_VERSION}${NC}  ${DIM}│${NC}  $(get_status_indicator)"
fi

if [ "$ASCII_STYLE" = "minimal" ]; then
    echo -e "╠════════════════════════════════════════════════════════════════════════════════╣"
else
    echo -e "${BRIGHT}────────────────────────────────────────────────────────────────────────────────${NC}"
fi

echo ""

# System Information - Two column layout
if [ "$SHOW_HOSTNAME" = true ] || [ "$SHOW_KERNEL" = true ]; then
    printf "${GRAY}%-20s${NC} ${WHITE}%-35s${NC}" "System" "$(hostname -f 2>/dev/null || hostname)"
    if [ "$SHOW_KERNEL" = true ]; then
        printf "  ${GRAY}Kernel${NC} ${WHITE}%s${NC}\n" "$(uname -r)"
    else
        echo ""
    fi
fi

if [ "$SHOW_UPTIME" = true ] || [ "$SHOW_LOAD" = true ]; then
    printf "${GRAY}%-20s${NC} ${WHITE}%-35s${NC}" "Uptime" "$(get_uptime)"
    if [ "$SHOW_LOAD" = true ]; then
        printf "  ${GRAY}Load${NC} ${WHITE}%s${NC}\n" "$(get_load)"
    else
        echo ""
    fi
fi

if [ "$SHOW_MEMORY" = true ]; then
    printf "${GRAY}%-20s${NC} ${WHITE}%s${NC}\n" "Memory" "$(get_memory)"
fi

if [ "$SHOW_DISK" = true ]; then
    printf "${GRAY}%-20s${NC} ${WHITE}%s${NC}\n" "Disk (/)" "$(get_disk)"
fi

if [ "$SHOW_IP" = true ]; then
    LOCAL_IP=$(get_ip)
    PUBLIC_IP=$(get_public_ip)
    if [ -n "$LOCAL_IP" ]; then
        printf "${GRAY}%-20s${NC} ${WHITE}%-35s${NC}" "Local IP" "$LOCAL_IP"
        if [ "$PUBLIC_IP" != "N/A" ]; then
            printf "  ${GRAY}Public${NC} ${WHITE}%s${NC}\n" "$PUBLIC_IP"
        else
            echo ""
        fi
    fi
fi

# Docker Status
if [ "$SHOW_DOCKER" = true ]; then
    echo ""
    printf "${GRAY}%-20s${NC} %s\n" "Docker" "$(get_docker_status)"
fi

# Services Status
if [ "$SHOW_SERVICES" = true ] && [ -n "$MONITORED_SERVICES" ]; then
    echo ""
    echo -e "${GRAY}Services${NC}"
    for service in $MONITORED_SERVICES; do
        check_service "$service"
    done
fi

# Last Login
if [ "$SHOW_LAST_LOGIN" = true ]; then
    echo ""
    echo -e "${GRAY}Last Login${NC}"
    echo -e "  ${DIM}$(get_last_login)${NC}"
fi

echo ""

if [ "$ASCII_STYLE" = "minimal" ]; then
    echo -e "╚════════════════════════════════════════════════════════════════════════════════╝"
else
    echo -e "${BRIGHT}────────────────────────────────────────────────────────────────────────────────${NC}"
fi

# Custom message with accent color
if [ -n "$CUSTOM_MESSAGE" ]; then
    echo ""
    echo -e "${ACCENT}${CUSTOM_MESSAGE}${NC}"
fi

echo ""
