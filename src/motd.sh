#!/bin/bash

if [ -f /etc/casstool.conf ]; then
    source /etc/casstool.conf
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
    SYSTEM_VERSION="1.0"
    COLOR_THEME="ice"
    ASCII_STYLE="casstool"
    MONITORED_SERVICES="nginx docker postgresql mysql redis"
    MOTD_ENABLED="true"
fi
if [ "$MOTD_ENABLED" != "true" ]; then
    exit 0
fi

load_theme() {
    local theme=$1
    
    case $theme in
        # Gradient Themes
        ice)
            # Crisp Cyan-White Gradient
            PRIMARY='\033[38;5;51m'    # Cyan
            BRIGHT='\033[38;5;195m'    # Very Light Cyan/White
            ACCENT='\033[38;5;123m'    # Light Sky Blue
            DIM='\033[38;5;39m'        # Deep Sky Blue
            ;;
        matrix)
            # Authentic Matrix Digital Rain
            PRIMARY='\033[38;5;46m'    # Matrix Green
            BRIGHT='\033[38;5;119m'    # Light Green
            ACCENT='\033[38;5;34m'     # Darker Green
            DIM='\033[38;5;22m'        # Very Dark Green
            ;;
        ocean)
            # Deep Ocean Blue Gradient
            PRIMARY='\033[38;5;33m'    # Dodger Blue
            BRIGHT='\033[38;5;45m'     # Light Blue
            ACCENT='\033[38;5;27m'     # Deep Blue
            DIM='\033[38;5;21m'        # Dark Blue
            ;;
        sunset)
            # Rich Purple to Orange Gradient
            PRIMARY='\033[38;5;208m'   # Dark Orange
            BRIGHT='\033[38;5;213m'    # Pink/Orchid
            ACCENT='\033[38;5;202m'    # Orange Red
            DIM='\033[38;5;166m'       # Darker Orange
            ;;
        fire)
            # Intense Fire Gradient
            PRIMARY='\033[38;5;196m'   # Red
            BRIGHT='\033[38;5;214m'    # Orange
            ACCENT='\033[38;5;208m'    # Dark Orange
            DIM='\033[38;5;124m'       # Dark Red
            ;;
        neon)
            # Cyberpunk Neon Gradient
            PRIMARY='\033[38;5;201m'   # Magenta
            BRIGHT='\033[38;5;51m'     # Cyan
            ACCENT='\033[38;5;213m'    # Light Purple
            DIM='\033[38;5;93m'        # Purple
            ;;
        hacker)
            # Modern Hacker (Green/Grey)
            PRIMARY='\033[38;5;41m'    # Spring Green
            BRIGHT='\033[38;5;48m'     # Medium Spring Green
            ACCENT='\033[38;5;35m'     # Green
            DIM='\033[38;5;28m'        # Dark Green
            ;;
        corporate)
            # Professional Blue-Grey
            PRIMARY='\033[38;5;75m'    # Steel Blue
            BRIGHT='\033[38;5;110m'    # Light Steel Blue
            ACCENT='\033[38;5;67m'     # Steel Blue Dark
            DIM='\033[38;5;60m'        # Dark Slate Blue
            ;;
        gold)
            # Luxurious Gold gradient
            PRIMARY='\033[38;5;220m'   # Gold
            BRIGHT='\033[38;5;226m'    # Yellow
            ACCENT='\033[38;5;214m'    # Orange Gold
            DIM='\033[38;5;178m'       # Dark Gold
            ;;
        dracula)
            # Dracula Theme (Purple/Pink)
            PRIMARY='\033[38;5;141m'   # Light Purple
            BRIGHT='\033[38;5;212m'    # Pink
            ACCENT='\033[38;5;105m'    # Pale Purple
            DIM='\033[38;5;61m'        # Dark Blue/Purple
            ;;
        forest)
            # Deep Forest Gradient
            PRIMARY='\033[38;5;34m'    # Green
            BRIGHT='\033[38;5;154m'    # Light Green
            ACCENT='\033[38;5;40m'     # Lime Green
            DIM='\033[38;5;22m'        # Dark Green
            ;;
        cosmic)
            # Deep Space Gradient
            PRIMARY='\033[38;5;99m'    # Slate Blue
            BRIGHT='\033[38;5;147m'    # Light Steel Blue
            ACCENT='\033[38;5;57m'     # Violet
            DIM='\033[38;5;17m'        # Dark Blue
            ;;
        # Classic Themes (Single Color / Flat)
        blue)
            PRIMARY='\033[0;94m'
            BRIGHT='\033[0;94m'
            ACCENT='\033[0;94m'
            DIM='\033[0;94m'
            ;;
        green)
            PRIMARY='\033[0;92m'
            BRIGHT='\033[0;92m'
            ACCENT='\033[0;92m'
            DIM='\033[0;92m'
            ;;
        purple)
            PRIMARY='\033[0;95m'
            BRIGHT='\033[0;95m'
            ACCENT='\033[0;95m'
            DIM='\033[0;95m'
            ;;
        cyan)
            PRIMARY='\033[0;96m'
            BRIGHT='\033[0;96m'
            ACCENT='\033[0;96m'
            DIM='\033[0;96m'
            ;;
        red)
            PRIMARY='\033[0;91m'
            BRIGHT='\033[0;91m'
            ACCENT='\033[0;91m'
            DIM='\033[0;91m'
            ;;
        yellow)
            PRIMARY='\033[0;93m'
            BRIGHT='\033[0;93m'
            ACCENT='\033[0;93m'
            DIM='\033[0;93m'
            ;;
        *)
            # Default to ice
            PRIMARY='\033[38;5;51m'
            BRIGHT='\033[38;5;195m'
            ACCENT='\033[38;5;123m'
            DIM='\033[38;5;39m'
            ;;
    esac
    
    WHITE='\033[38;5;255m'
    GRAY='\033[38;5;245m'
    DARK_GRAY='\033[38;5;240m'
    BOLD='\033[1m'
    NC='\033[0m'
}

load_theme "$COLOR_THEME"

print_ascii_art() {
    case $ASCII_STYLE in
        casstool)
            echo -e "${BRIGHT}  ██████╗ █████╗ ███████╗███████╗███╗   ███╗ █████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗${NC}"
            echo -e "${PRIMARY} ██╔════╝██╔══██╗██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║${NC}"
            echo -e "${ACCENT} ██║     ███████║███████╗███████╗██╔████╔██║███████║██████╔╝██████╔╝██║   ██║██║ █╗ ██║${NC}"
            echo -e "${PRIMARY} ██║     ██╔══██║╚════██║╚════██║██║╚██╔╝██║██╔══██║██╔══██╗██╔══██╗██║   ██║██║███╗██║${NC}"
            echo -e "${DIM} ╚██████╗██║  ██║███████║███████║██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║╚██████╔╝╚███╔███╔╝${NC}"
            echo -e "${DIM}  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝${NC}"
            ;;
        minimal)
            echo -e "${BRIGHT}┌────────────────────────────────────────────────────────────────────────────────┐${NC}"
            echo -e "${PRIMARY}│                              C A S S M A R R O W                               │${NC}"
            echo -e "${BRIGHT}└────────────────────────────────────────────────────────────────────────────────┘${NC}"
            ;;
        retro)
            echo -e "${BRIGHT}   ___   _   ___ ___ __  __   _   ___ ___  _____      __${NC}"
            echo -e "${PRIMARY}  / __| /_\ / __/ __|  \/  | /_\ | _ \ _ \/ _ \ \    / /${NC}"
            echo -e "${ACCENT} | (__ / _ \\__ \\__ \\ |\\/| |/ _ \\|   /   / (_) \\ \\/\\/ / ${NC}"
            echo -e "${DIM}  \\___/_/ \\_\\___/___/_|  |_/_/ \\_\\_| _\\_| _\\___/ \\_/\\_/  ${NC}"
            ;;
        cyber)
            echo -e "${BRIGHT}   ▄████▄   ▄▄▄       ██████  ██████  ███▄ ▄███▓ ▄▄▄       ██████  ██████  ▒█████   █     █░${NC}"
            echo -e "${PRIMARY}  ▒██▀ ▀█  ▒████▄   ▒██    ▒ ▒██    ▒ ▓██▒▀█▀ ██▒▒████▄   ▒██    ▒ ▒██    ▒ ▒██▒  ██▒▓█░ █ ░█░${NC}"
            echo -e "${ACCENT}  ▒▓█    ▄ ▒██  ▀█▄ ░ ▓██▄   ░ ▓██▄   ▓██    ▓██░▒██  ▀█▄ ░ ▓██▄   ░ ▓██▄   ▒██░  ██▒▒█░ █ ░█ ${NC}"
            echo -e "${PRIMARY}  ▒▓▓▄ ▄██▒░██▄▄▄▄██  ▒   ██▒  ▒   ██▒▒██    ▒██ ░██▄▄▄▄██  ▒   ██▒  ▒   ██▒▒██   ██░░█░ █ ░█ ${NC}"
            echo -e "${DIM}  ▒ ▓███▀ ░ ▓█   ▓██▒██████▒▒██████▒▒▒██▒   ░██▒ ▓█   ▓██▒██████▒▒██████▒▒░ ████▓▒░░░██▒██▓ ${NC}"
            echo -e "${DIM}  ░ ░▒ ▒  ░ ▒▒   ▓▒█░ ▒░▓  ░ ▒ ▒▓  ░ ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒░▓  ░ ▒ ▒▓  ░ ░ ▒░▒░▒░ ░ ▓░▒ ▒  ${NC}"
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
    local cache_file="/tmp/casstool_public_ip"
    local cache_duration=3600 # 1 hour

    if [ -f "$cache_file" ] && [ $(($(date +%s) - $(stat -c %Y "$cache_file"))) -lt $cache_duration ]; then
        cat "$cache_file"
    else
        local ip=$(timeout 2 curl -s ifconfig.me 2>/dev/null)
        if [ -n "$ip" ]; then
            echo "$ip" > "$cache_file"
            echo "$ip"
        else
            if [ -f "$cache_file" ]; then
                cat "$cache_file"
            else
                echo "N/A"
            fi
        fi
    fi
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
    if systemctl is-active --quiet "$service" 2>/dev/null; then
        echo -e "  ${PRIMARY}●${NC} ${service}"
    elif systemctl list-unit-files "$service.service" &>/dev/null; then
         echo -e "  ${ACCENT}●${NC} ${service} ${DIM}(stopped)${NC}"
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
