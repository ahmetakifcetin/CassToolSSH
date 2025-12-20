#!/bin/bash

# CassMarrow - Beautiful Server Greeting System
# Version: 1.1.0
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
NC='\033[0m'
BOLD='\033[1m'

# Detect if running interactively
if [ -t 0 ]; then
    INTERACTIVE=true
else
    INTERACTIVE=false
fi

# Banner
show_banner() {
    echo -e "${CYAN}${BOLD}"
    cat << "EOF"
 ██████╗ █████╗ ███████╗███████╗███╗   ███╗ █████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║
██║     ███████║███████╗███████╗██╔████╔██║███████║██████╔╝██████╔╝██║   ██║██║ █╗ ██║
██║     ██╔══██║╚════██║╚════██║██║╚██╔╝██║██╔══██║██╔══██╗██╔══██╗██║   ██║██║███╗██║
╚██████╗██║  ██║███████║███████║██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║╚██████╔╝╚███╔███╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝
EOF
    echo -e "${NC}"
    echo -e "${CYAN}${BOLD}Beautiful Server Greeting System${NC}"
    echo -e "${YELLOW}Installation Script v1.1.0${NC}"
    echo ""
}

# Ask user with fallback for non-interactive
ask_user() {
    local prompt="$1"
    local default="$2"
    
    if [ "$INTERACTIVE" = true ]; then
        read -p "$prompt" -r response < /dev/tty
        echo "$response"
    else
        echo "$default"
    fi
}

# Check root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}[✗]${NC} Bu script root olarak çalıştırılmalı"
        echo -e "${YELLOW}Tekrar deneyin: sudo $0${NC}"
        exit 1
    fi
    echo -e "${GREEN}[✓]${NC} Root yetkileri kontrol edildi"
}

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    else
        echo -e "${RED}[✗]${NC} İşletim sistemi tespit edilemedi"
        exit 1
    fi
    
    echo -e "${GREEN}[✓]${NC} İşletim Sistemi: $OS $VER"
    
    if [[ ! "$OS" =~ "Ubuntu" ]] && [[ ! "$OS" =~ "Debian" ]]; then
        echo -e "${YELLOW}[!]${NC} Uyarı: Bu script Ubuntu/Debian için tasarlandı"
        if [ "$INTERACTIVE" = true ]; then
            response=$(ask_user "Yine de devam edilsin mi? (e/h): " "h")
            if [[ ! "$response" =~ ^[EeYy]$ ]]; then
                exit 1
            fi
        fi
    fi
}

# Installation wizard
installation_wizard() {
    if [ "$INTERACTIVE" = false ]; then
        echo -e "${YELLOW}[!]${NC} Non-interactive mode: Hızlı kurulum yapılıyor..."
        INSTALL_MODE="quick"
        ENABLE_MOTD="true"
        SELECTED_THEME="cyan"
        SELECTED_STYLE="cassmarrow"
        SYSTEM_NAME="Production Infrastructure"
        return
    fi
    
    clear
    show_banner
    
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}${BOLD}              CassMarrow Kurulum Sihirbazı                  ${NC}"
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Kurulum tipini seçin:${NC}"
    echo ""
    echo -e "  ${GREEN}1)${NC} Hızlı Kurulum ${DIM}(Önerilen - varsayılan ayarlar)${NC}"
    echo -e "  ${GREEN}2)${NC} Özel Kurulum ${DIM}(Tema, stil ve ayarları seç)${NC}"
    echo ""
    
    while true; do
        response=$(ask_user "Seçiminiz [1-2]: " "1")
        case $response in
            1|"") 
                INSTALL_MODE="quick"
                break
                ;;
            2)
                INSTALL_MODE="custom"
                break
                ;;
            *)
                echo -e "${RED}Geçersiz seçim. 1 veya 2 girin.${NC}"
                ;;
        esac
    done
    
    if [ "$INSTALL_MODE" = "quick" ]; then
        echo -e "${GREEN}[✓]${NC} Hızlı kurulum seçildi"
        ENABLE_MOTD="true"
        SELECTED_THEME="cyan"
        SELECTED_STYLE="cassmarrow"
        SYSTEM_NAME="Production Infrastructure"
    else
        custom_setup
    fi
}

# Custom setup wizard
custom_setup() {
    echo ""
    echo -e "${CYAN}${BOLD}═══ Özel Kurulum Ayarları ═══${NC}"
    echo ""
    
    # 1. MOTD Enable/Disable
    echo -e "${YELLOW}1. SSH girişinde otomatik gösterilsin mi?${NC}"
    echo -e "   ${DIM}(Her SSH bağlantısında CassMarrow karşılama ekranı gösterilir)${NC}"
    while true; do
        response=$(ask_user "   [E/h]: " "E")
        case $response in
            [EeYy]*|"")
                ENABLE_MOTD="true"
                break
                ;;
            [Hh]*)
                ENABLE_MOTD="false"
                echo -e "   ${DIM}Not: Daha sonra 'cassmarrow enable' komutuyla aktifleştirebilirsiniz${NC}"
                break
                ;;
            *)
                echo -e "${RED}   E veya H girin${NC}"
                ;;
        esac
    done
    
    # 2. Color Theme
    echo ""
    echo -e "${YELLOW}2. Renk teması seçin:${NC}"
    echo -e "   ${BLUE}1)${NC} Blue    ${GREEN}2)${NC} Green   ${PURPLE}3)${NC} Purple"
    echo -e "   ${CYAN}4)${NC} Cyan    ${RED}5)${NC} Red     ${YELLOW}6)${NC} Yellow"
    while true; do
        response=$(ask_user "   Seçim [1-6]: " "4")
        case $response in
            1) SELECTED_THEME="blue"; break ;;
            2) SELECTED_THEME="green"; break ;;
            3) SELECTED_THEME="purple"; break ;;
            4|"") SELECTED_THEME="cyan"; break ;;
            5) SELECTED_THEME="red"; break ;;
            6) SELECTED_THEME="yellow"; break ;;
            *) echo -e "${RED}   1-6 arası bir sayı girin${NC}" ;;
        esac
    done
    echo -e "   ${GREEN}✓${NC} Tema: $SELECTED_THEME"
    
    # 3. ASCII Style
    echo ""
    echo -e "${YELLOW}3. ASCII art stilini seçin:${NC}"
    echo -e "   ${GREEN}1)${NC} CassMarrow ${DIM}(Varsayılan - tam logo)${NC}"
    echo -e "   ${GREEN}2)${NC} Minimal ${DIM}(Basit tasarım)${NC}"
    echo -e "   ${GREEN}3)${NC} Blocks ${DIM}(Modern blok karakterler)${NC}"
    echo -e "   ${GREEN}4)${NC} Simple ${DIM}(Düz metin)${NC}"
    while true; do
        response=$(ask_user "   Seçim [1-4]: " "1")
        case $response in
            1|"") SELECTED_STYLE="cassmarrow"; break ;;
            2) SELECTED_STYLE="minimal"; break ;;
            3) SELECTED_STYLE="blocks"; break ;;
            4) SELECTED_STYLE="simple"; break ;;
            *) echo -e "${RED}   1-4 arası bir sayı girin${NC}" ;;
        esac
    done
    echo -e "   ${GREEN}✓${NC} Stil: $SELECTED_STYLE"
    
    # 4. System Name
    echo ""
    echo -e "${YELLOW}4. Sistem adı:${NC}"
    response=$(ask_user "   [Production Infrastructure]: " "Production Infrastructure")
    if [ -z "$response" ]; then
        SYSTEM_NAME="Production Infrastructure"
    else
        SYSTEM_NAME="$response"
    fi
    echo -e "   ${GREEN}✓${NC} Sistem adı: $SYSTEM_NAME"
    
    echo ""
    echo -e "${GREEN}[✓]${NC} Özel kurulum ayarları tamamlandı"
    sleep 1
}

# Create configuration
create_config() {
    local config_file="/etc/cassmarrow.conf"
    
    echo -e "${BLUE}[→]${NC} Yapılandırma dosyası oluşturuluyor..."
    
    cat > "$config_file" << EOF
# CassMarrow Configuration File
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
SYSTEM_NAME="$SYSTEM_NAME"
SYSTEM_VERSION="v1.0"
CUSTOM_MESSAGE=""

# Color Theme (options: blue, green, purple, cyan, red, yellow)
COLOR_THEME="$SELECTED_THEME"

# ASCII Art Style (options: cassmarrow, minimal, blocks, simple)
ASCII_STYLE="$SELECTED_STYLE"

# Services to monitor (space-separated)
MONITORED_SERVICES="nginx docker postgresql mysql redis"

# Custom header text (leave empty for default)
CUSTOM_HEADER=""

# MOTD Enabled (true/false)
MOTD_ENABLED="$ENABLE_MOTD"
EOF
    
    echo -e "${GREEN}[✓]${NC} Yapılandırma dosyası oluşturuldu: $config_file"
}

# Create MOTD script
create_motd_script() {
    local install_dir="/opt/cassmarrow"
    
    echo -e "${BLUE}[→]${NC} Kurulum dizini oluşturuluyor..."
    mkdir -p "$install_dir"
    
    echo -e "${BLUE}[→]${NC} MOTD scripti oluşturuluyor..."
    
    cat > "$install_dir/motd.sh" << 'SCRIPTEOF'
#!/bin/bash

# Load configuration
if [ -f /etc/cassmarrow.conf ]; then
    source /etc/cassmarrow.conf
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
    SYSTEM_NAME="Production Infrastructure"
    SYSTEM_VERSION="v1.0"
    COLOR_THEME="cyan"
    ASCII_STYLE="cassmarrow"
    MONITORED_SERVICES="nginx docker postgresql mysql redis"
    MOTD_ENABLED="true"
fi

# Check if MOTD is enabled
if [ "$MOTD_ENABLED" != "true" ]; then
    exit 0
fi

# Color definitions based on theme
case $COLOR_THEME in
    blue)
        PRIMARY='\033[38;5;33m'
        BRIGHT='\033[38;5;39m'
        ACCENT='\033[38;5;27m'
        ;;
    green)
        PRIMARY='\033[38;5;34m'
        BRIGHT='\033[38;5;40m'
        ACCENT='\033[38;5;28m'
        ;;
    purple)
        PRIMARY='\033[38;5;135m'
        BRIGHT='\033[38;5;141m'
        ACCENT='\033[38;5;129m'
        ;;
    cyan)
        PRIMARY='\033[38;5;51m'
        BRIGHT='\033[38;5;87m'
        ACCENT='\033[38;5;45m'
        ;;
    red)
        PRIMARY='\033[38;5;196m'
        BRIGHT='\033[38;5;202m'
        ACCENT='\033[38;5;160m'
        ;;
    yellow)
        PRIMARY='\033[38;5;220m'
        BRIGHT='\033[38;5;226m'
        ACCENT='\033[38;5;214m'
        ;;
    *)
        PRIMARY='\033[38;5;51m'
        BRIGHT='\033[38;5;87m'
        ACCENT='\033[38;5;45m'
        ;;
esac

WHITE='\033[38;5;255m'
GRAY='\033[38;5;245m'
DIM='\033[38;5;240m'
BOLD='\033[1m'
NC='\033[0m'

# ASCII Art
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
┌────────────────────────────────────────────────────────────────────────────────┐
│                              C A S S M A R R O W                               │
└────────────────────────────────────────────────────────────────────────────────┘
EOF
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
            cat << "EOF"
════════════════════════════════════════════
        C A S S M A R R O W
════════════════════════════════════════════
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
            echo -e "  ${RED}●${NC} ${service} ${DIM}(stopped)${NC}"
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
        echo -e "${RED}● HEAVY LOAD${NC}"
    elif [ "$load_percent" -ge 70 ]; then
        echo -e "${YELLOW}● MODERATE${NC}"
    else
        echo -e "${PRIMARY}● OPTIMAL${NC}"
    fi
}

# Main display
clear
echo ""
print_ascii_art

# System header with status
echo -e "${WHITE}${BOLD}${SYSTEM_NAME}${NC}  ${DIM}│${NC}  ${GRAY}v${SYSTEM_VERSION}${NC}  ${DIM}│${NC}  $(get_status_indicator)"

echo -e "${BRIGHT}────────────────────────────────────────────────────────────────────────────────${NC}"
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
echo -e "${BRIGHT}────────────────────────────────────────────────────────────────────────────────${NC}"

# Custom message
if [ -n "$CUSTOM_MESSAGE" ]; then
    echo ""
    echo -e "${ACCENT}${CUSTOM_MESSAGE}${NC}"
fi

echo ""
SCRIPTEOF

    chmod +x "$install_dir/motd.sh"
    echo -e "${GREEN}[✓]${NC} MOTD scripti oluşturuldu"
}

# Setup MOTD system
setup_motd() {
    echo -e "${BLUE}[→]${NC} MOTD sistemi yapılandırılıyor..."
    
    # Backup existing MOTD
    if [ -d /etc/update-motd.d ]; then
        if [ ! -d /etc/update-motd.d.backup ]; then
            mkdir -p /etc/update-motd.d.backup
            cp -r /etc/update-motd.d/* /etc/update-motd.d.backup/ 2>/dev/null || true
            echo -e "${GREEN}[✓]${NC} Mevcut MOTD yedeklendi: /etc/update-motd.d.backup"
        fi
    fi
    
    # Disable default Ubuntu MOTD scripts
    if [ -d /etc/update-motd.d ]; then
        chmod -x /etc/update-motd.d/* 2>/dev/null || true
    fi
    
    # Clear static MOTD files
    echo "" > /etc/motd 2>/dev/null || true
    rm -f /etc/motd.dynamic 2>/dev/null || true
    
    # Create CassMarrow MOTD hook
    cat > /etc/update-motd.d/00-cassmarrow << 'MOTDEOF'
#!/bin/bash
/opt/cassmarrow/motd.sh
MOTDEOF
    
    chmod +x /etc/update-motd.d/00-cassmarrow
    
    # Ensure SSH is configured to show MOTD
    if [ -f /etc/ssh/sshd_config ]; then
        if grep -q "^PrintMotd" /etc/ssh/sshd_config; then
            sed -i 's/^PrintMotd.*/PrintMotd yes/' /etc/ssh/sshd_config
        else
            echo "PrintMotd yes" >> /etc/ssh/sshd_config
        fi
    fi
    
    echo -e "${GREEN}[✓]${NC} MOTD sistemi yapılandırıldı"
}

# Create management tool
create_cassmarrow_command() {
    echo -e "${BLUE}[→]${NC} Yönetim komutu oluşturuluyor..."
    
    cat > /usr/local/bin/cassmarrow << 'TOOLEOF'
#!/bin/bash

# CassMarrow Management Tool

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

CONFIG="/etc/cassmarrow.conf"

show_usage() {
    echo -e "${CYAN}${BOLD}CassMarrow Yönetim Aracı${NC}"
    echo ""
    echo "Kullanım: cassmarrow <komut>"
    echo ""
    echo "Komutlar:"
    echo -e "  ${GREEN}enable${NC}      - CassMarrow'u aktifleştir"
    echo -e "  ${GREEN}disable${NC}     - CassMarrow'u devre dışı bırak"
    echo -e "  ${GREEN}status${NC}      - Durum bilgisi göster"
    echo -e "  ${GREEN}config${NC}      - Yapılandırmayı düzenle"
    echo -e "  ${GREEN}customize${NC}   - İnteraktif özelleştirme"
    echo -e "  ${GREEN}test${NC}        - Karşılama ekranını test et"
    echo -e "  ${GREEN}theme${NC}       - Hızlı tema değiştir"
    echo -e "  ${GREEN}style${NC}       - Hızlı stil değiştir"
    echo -e "  ${GREEN}uninstall${NC}   - CassMarrow'u kaldır"
    echo ""
}

enable_motd() {
    if [ ! -f "$CONFIG" ]; then
        echo -e "${RED}Hata: Yapılandırma dosyası bulunamadı${NC}"
        exit 1
    fi
    
    sed -i 's/MOTD_ENABLED="false"/MOTD_ENABLED="true"/' "$CONFIG"
    echo -e "${GREEN}✓ CassMarrow aktifleştirildi${NC}"
    echo -e "${CYAN}SSH girişlerinde karşılama ekranı gösterilecek${NC}"
}

disable_motd() {
    if [ ! -f "$CONFIG" ]; then
        echo -e "${RED}Hata: Yapılandırma dosyası bulunamadı${NC}"
        exit 1
    fi
    
    sed -i 's/MOTD_ENABLED="true"/MOTD_ENABLED="false"/' "$CONFIG"
    echo -e "${YELLOW}! CassMarrow devre dışı bırakıldı${NC}"
    echo -e "${CYAN}SSH girişlerinde karşılama ekranı gösterilmeyecek${NC}"
}

show_status() {
    if [ ! -f "$CONFIG" ]; then
        echo -e "${RED}CassMarrow kurulu değil${NC}"
        exit 1
    fi
    
    source "$CONFIG"
    
    echo -e "${CYAN}${BOLD}CassMarrow Durum${NC}"
    echo -e "${CYAN}═══════════════════════════════════${NC}"
    
    if [ "$MOTD_ENABLED" = "true" ]; then
        echo -e "Durum:          ${GREEN}●${NC} Aktif"
    else
        echo -e "Durum:          ${RED}●${NC} Devre Dışı"
    fi
    
    echo -e "Tema:           ${CYAN}$COLOR_THEME${NC}"
    echo -e "Stil:           ${CYAN}$ASCII_STYLE${NC}"
    echo -e "Sistem Adı:     ${CYAN}$SYSTEM_NAME${NC}"
    echo -e "Config:         ${CYAN}$CONFIG${NC}"
    echo ""
}

change_theme() {
    echo -e "${CYAN}Mevcut Temalar:${NC}"
    echo "1) blue    2) green   3) purple"
    echo "4) cyan    5) red     6) yellow"
    echo ""
    read -p "Tema seçin [1-6]: " choice
    
    case $choice in
        1) theme="blue" ;;
        2) theme="green" ;;
        3) theme="purple" ;;
        4) theme="cyan" ;;
        5) theme="red" ;;
        6) theme="yellow" ;;
        *) echo -e "${RED}Geçersiz seçim${NC}"; exit 1 ;;
    esac
    
    sed -i "s/COLOR_THEME=\".*\"/COLOR_THEME=\"$theme\"/" "$CONFIG"
    echo -e "${GREEN}✓ Tema değiştirildi: $theme${NC}"
    /opt/cassmarrow/motd.sh
}

change_style() {
    echo -e "${CYAN}Mevcut Stiller:${NC}"
    echo "1) cassmarrow  2) minimal"
    echo "3) blocks      4) simple"
    echo ""
    read -p "Stil seçin [1-4]: " choice
    
    case $choice in
        1) style="cassmarrow" ;;
        2) style="minimal" ;;
        3) style="blocks" ;;
        4) style="simple" ;;
        *) echo -e "${RED}Geçersiz seçim${NC}"; exit 1 ;;
    esac
    
    sed -i "s/ASCII_STYLE=\".*\"/ASCII_STYLE=\"$style\"/" "$CONFIG"
    echo -e "${GREEN}✓ Stil değiştirildi: $style${NC}"
    /opt/cassmarrow/motd.sh
}

case "$1" in
    enable)
        enable_motd
        ;;
    disable)
        disable_motd
        ;;
    status)
        show_status
        ;;
    config)
        ${EDITOR:-nano} "$CONFIG"
        ;;
    customize)
        /opt/cassmarrow/customize.sh
        ;;
    test)
        /opt/cassmarrow/motd.sh
        ;;
    theme)
        change_theme
        ;;
    style)
        change_style
        ;;
    uninstall)
        /opt/cassmarrow/uninstall.sh
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
TOOLEOF

    chmod +x /usr/local/bin/cassmarrow
    echo -e "${GREEN}[✓]${NC} 'cassmarrow' komutu oluşturuldu"
}

# Create helper scripts
create_helper_scripts() {
    local install_dir="/opt/cassmarrow"
    
    # Customize script
    cat > "$install_dir/customize.sh" << 'CUSTOMEOF'
#!/bin/bash

CONFIG_FILE="/etc/cassmarrow.conf"

echo "CassMarrow Özelleştirme Yardımcısı"
echo "===================================="
echo ""

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Hata: Yapılandırma dosyası bulunamadı"
    exit 1
fi

while true; do
    echo ""
    echo "1. Renk temasını değiştir"
    echo "2. ASCII stilini değiştir"
    echo "3. Sistem adını düzenle"
    echo "4. İzlenen servisleri düzenle"
    echo "5. Yapılandırma dosyasını düzenle"
    echo "6. Mevcut yapılandırmayı test et"
    echo "7. Çıkış"
    echo ""
    read -p "Seçim yapın: " choice

    case $choice in
        1)
            echo "Mevcut temalar: blue, green, purple, cyan, red, yellow"
            read -p "Tema girin: " theme
            sed -i "s/COLOR_THEME=.*/COLOR_THEME=\"$theme\"/" "$CONFIG_FILE"
            echo "Tema güncellendi!"
            ;;
        2)
            echo "Mevcut stiller: cassmarrow, minimal, blocks, simple"
            read -p "Stil girin: " style
            sed -i "s/ASCII_STYLE=.*/ASCII_STYLE=\"$style\"/" "$CONFIG_FILE"
            echo "Stil güncellendi!"
            ;;
        3)
            read -p "Sistem adı girin: " name
            sed -i "s/SYSTEM_NAME=.*/SYSTEM_NAME=\"$name\"/" "$CONFIG_FILE"
            echo "Sistem adı güncellendi!"
            ;;
        4)
            read -p "Servisleri girin (boşlukla ayırın): " services
            sed -i "s/MONITORED_SERVICES=.*/MONITORED_SERVICES=\"$services\"/" "$CONFIG_FILE"
            echo "Servisler güncellendi!"
            ;;
        5)
            ${EDITOR:-nano} "$CONFIG_FILE"
            ;;
        6)
            /opt/cassmarrow/motd.sh
            ;;
        7)
            exit 0
            ;;
        *)
            echo "Geçersiz seçim"
            ;;
    esac
done
CUSTOMEOF
    
    chmod +x "$install_dir/customize.sh"
    
    # Uninstall script
    cat > "$install_dir/uninstall.sh" << 'UNINSTALLEOF'
#!/bin/bash

echo "CassMarrow kaldırılıyor..."

# Restore backups
if [ -d /etc/update-motd.d.backup ]; then
    rm -f /etc/update-motd.d/*
    cp -r /etc/update-motd.d.backup/* /etc/update-motd.d/
    chmod +x /etc/update-motd.d/*
    rm -rf /etc/update-motd.d.backup
fi

# Remove CassMarrow files
rm -rf /opt/cassmarrow
rm -f /etc/cassmarrow.conf
rm -f /usr/local/bin/cassmarrow

echo "CassMarrow kaldırıldı"
UNINSTALLEOF
    
    chmod +x "$install_dir/uninstall.sh"
    
    echo -e "${GREEN}[✓]${NC} Yardımcı scriptler oluşturuldu"
}

# Show completion message
show_completion() {
    clear
    show_banner
    
    echo -e "${GREEN}${BOLD}╔═══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}${BOLD}║                 Kurulum Başarıyla Tamamlandı!                     ║${NC}"
    echo -e "${GREEN}${BOLD}╚═══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${CYAN}${BOLD}Kurulum Özeti:${NC}"
    echo -e "  ${GREEN}✓${NC} Tema: ${YELLOW}$SELECTED_THEME${NC}"
    echo -e "  ${GREEN}✓${NC} Stil: ${YELLOW}$SELECTED_STYLE${NC}"
    echo -e "  ${GREEN}✓${NC} MOTD: ${YELLOW}$([ "$ENABLE_MOTD" = "true" ] && echo "Aktif" || echo "Devre Dışı")${NC}"
    echo ""
    
    echo -e "${CYAN}${BOLD}Hızlı Komutlar:${NC}"
    echo -e "  ${YELLOW}cassmarrow status${NC}      - Durum bilgisi"
    echo -e "  ${YELLOW}cassmarrow enable${NC}      - Aktifleştir"
    echo -e "  ${YELLOW}cassmarrow disable${NC}     - Devre dışı bırak"
    echo -e "  ${YELLOW}cassmarrow test${NC}        - Test et"
    echo -e "  ${YELLOW}cassmarrow theme${NC}       - Tema değiştir"
    echo -e "  ${YELLOW}cassmarrow config${NC}      - Yapılandırmayı düzenle"
    echo ""
    
    echo -e "${CYAN}${BOLD}Dosya Konumları:${NC}"
    echo -e "  Config:  ${YELLOW}/etc/cassmarrow.conf${NC}"
    echo -e "  Scripts: ${YELLOW}/opt/cassmarrow/${NC}"
    echo ""
    
    if [ "$ENABLE_MOTD" = "true" ]; then
        echo -e "${GREEN}${BOLD}SSH bağlantılarında CassMarrow karşılama ekranı gösterilecek!${NC}"
        echo -e "${CYAN}Şimdi test etmek için: ${YELLOW}cassmarrow test${NC}"
    else
        echo -e "${YELLOW}MOTD devre dışı. Aktifleştirmek için: ${BOLD}cassmarrow enable${NC}"
    fi
    
    echo ""
    echo -e "${DIM}Daha fazla bilgi: https://github.com/ahmetakifcetin/CassMarrow${NC}"
    echo ""
}

# Main installation flow
main() {
    show_banner
    check_root
    detect_os
    
    echo ""
    installation_wizard
    
    echo ""
    create_config
    create_motd_script
    setup_motd
    create_cassmarrow_command
    create_helper_scripts
    
    show_completion
}

# Run main
main
