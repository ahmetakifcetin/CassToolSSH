#!/bin/bash

# CassToolSSH - Beautiful Server Greeting System
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
    echo -e "${PURPLE}${BOLD}"
    cat << "EOF"
 ██████╗ █████╗ ███████╗███████╗████████╗ ██████╗  ██████╗ ██╗     ███████╗███████╗██╗  ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝██╔════╝██║  ██║
██║     ███████║███████╗███████╗   ██║   ██║   ██║██║   ██║██║     ███████╗███████╗███████║
██║     ██╔══██║╚════██║╚════██║   ██║   ██║   ██║██║   ██║██║     ╚════██║╚════██║██╔══██║
╚██████╗██║  ██║███████║███████║   ██║   ╚██████╔╝╚██████╔╝███████╗███████║███████║██║  ██║
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
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
        SELECTED_STYLE="CassToolSSH"
        SYSTEM_NAME="CassToolSSH Infrastructure"
        return
    fi
    
    clear
    show_banner
    
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}${BOLD}              CassToolSSH Kurulum Sihirbazı                ${NC}"
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
        SELECTED_STYLE="CassToolSSH"
        SYSTEM_NAME="CassToolSSH Infrastructure"
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
    echo -e "   ${DIM}(Her SSH bağlantısında CassToolSSH karşılama ekranı gösterilir)${NC}"
    while true; do
        response=$(ask_user "   [E/h]: " "E")
        case $response in
            [EeYy]*|"")
                ENABLE_MOTD="true"
                break
                ;;
            [Hh]*)
                ENABLE_MOTD="false"
                echo -e "   ${DIM}Not: Daha sonra 'casstool enable' komutuyla aktifleştirebilirsiniz${NC}"
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
    echo -e "   ${GREEN}1)${NC} CassToolSSH ${DIM}(Varsayılan - tam logo)${NC}"
    echo -e "   ${GREEN}2)${NC} Minimal ${DIM}(Basit kutu tasarımı)${NC}"
    echo -e "   ${GREEN}3)${NC} Blocks ${DIM}(Modern blok karakterler)${NC}"
    echo -e "   ${GREEN}4)${NC} Simple ${DIM}(Düz metin)${NC}"
    while true; do
        response=$(ask_user "   Seçim [1-4]: " "1")
        case $response in
            1|"") SELECTED_STYLE="CassToolSSH"; break ;;
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
    response=$(ask_user "   [CassToolSSH Infrastructure]: " "CassToolSSH Infrastructure")
    if [ -z "$response" ]; then
        SYSTEM_NAME="CassToolSSH Infrastructure"
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
    local config_file="/etc/CassToolSSH.conf"
    
    echo -e "${BLUE}[→]${NC} Yapılandırma dosyası oluşturuluyor..."
    
    cat > "$config_file" << EOF
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
SYSTEM_NAME="$SYSTEM_NAME"
SYSTEM_VERSION="v1.0"
CUSTOM_MESSAGE=""

# Color Theme (options: blue, green, purple, cyan, red, yellow)
COLOR_THEME="$SELECTED_THEME"

# ASCII Art Style (options: CassToolSSH, minimal, blocks, simple)
ASCII_STYLE="$SELECTED_STYLE"

# Services to monitor (space-separated)
MONITORED_SERVICES="nginx docker postgresql mysql"

# Custom header text (leave empty for default)
CUSTOM_HEADER=""

# MOTD Enabled (true/false)
MOTD_ENABLED="$ENABLE_MOTD"
EOF
    
    echo -e "${GREEN}[✓]${NC} Yapılandırma dosyası oluşturuldu: $config_file"
}

# Create MOTD script
create_motd_script() {
    local install_dir="/opt/CassToolSSH"
    
    echo -e "${BLUE}[→]${NC} Kurulum dizini oluşturuluyor..."
    mkdir -p "$install_dir"
    
    echo -e "${BLUE}[→]${NC} MOTD scripti oluşturuluyor..."
    
    cat > "$install_dir/motd.sh" << 'SCRIPTEOF'
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
    MOTD_ENABLED="true"
fi

# Check if MOTD is enabled
if [ "$MOTD_ENABLED" != "true" ]; then
    exit 0
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
 ██████╗ █████╗ ███████╗███████╗████████╗ ██████╗  ██████╗ ██╗     ███████╗███████╗██╗  ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝██╔════╝██║  ██║
██║     ███████║███████╗███████╗   ██║   ██║   ██║██║   ██║██║     ███████╗███████╗███████║
██║     ██╔══██║╚════██║╚════██║   ██║   ██║   ██║██║   ██║██║     ╚════██║╚════██║██╔══██║
╚██████╗██║  ██║███████║███████║   ██║   ╚██████╔╝╚██████╔╝███████╗███████║███████║██║  ██║
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
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
            CONTAINERS=$(docker ps -q 2>/dev/null | wc -l)
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
    last -n 1 -F 2>/dev/null | head -1
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
    echo -e "${PRIMARY}${BOLD}Host:${NC}           $(hostname -f 2>/dev/null || hostname)"
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
    
    # Create CassToolSSH MOTD hook
    cat > /etc/update-motd.d/00-CassToolSSH << 'MOTDEOF'
#!/bin/bash
/opt/CassToolSSH/motd.sh
MOTDEOF
    
    chmod +x /etc/update-motd.d/00-CassToolSSH
    
    # Ensure SSH is configured to show MOTD
    if [ -f /etc/ssh/sshd_config ]; then
        # Check if PrintMotd is already configured
        if grep -q "^PrintMotd" /etc/ssh/sshd_config; then
            sed -i 's/^PrintMotd.*/PrintMotd yes/' /etc/ssh/sshd_config
        else
            echo "PrintMotd yes" >> /etc/ssh/sshd_config
        fi
    fi
    
    echo -e "${GREEN}[✓]${NC} MOTD sistemi yapılandırıldı"
}

# Create management tool
create_casstool_command() {
    echo -e "${BLUE}[→]${NC} Yönetim komutu oluşturuluyor..."
    
    cat > /usr/local/bin/casstool << 'TOOLEOF'
#!/bin/bash

# CassToolSSH Management Tool

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

CONFIG="/etc/CassToolSSH.conf"

show_usage() {
    echo -e "${CYAN}${BOLD}CassToolSSH Yönetim Aracı${NC}"
    echo ""
    echo "Kullanım: casstool <komut>"
    echo ""
    echo "Komutlar:"
    echo -e "  ${GREEN}enable${NC}      - CassToolSSH'u aktifleştir"
    echo -e "  ${GREEN}disable${NC}     - CassToolSSH'u devre dışı bırak"
    echo -e "  ${GREEN}status${NC}      - Durum bilgisi göster"
    echo -e "  ${GREEN}config${NC}      - Yapılandırmayı düzenle"
    echo -e "  ${GREEN}customize${NC}   - İnteraktif özelleştirme"
    echo -e "  ${GREEN}test${NC}        - Karşılama ekranını test et"
    echo -e "  ${GREEN}theme${NC}       - Hızlı tema değiştir"
    echo -e "  ${GREEN}style${NC}       - Hızlı stil değiştir"
    echo -e "  ${GREEN}uninstall${NC}   - CassToolSSH'u kaldır"
    echo ""
}

enable_motd() {
    if [ ! -f "$CONFIG" ]; then
        echo -e "${RED}Hata: Yapılandırma dosyası bulunamadı${NC}"
        exit 1
    fi
    
    sed -i 's/MOTD_ENABLED="false"/MOTD_ENABLED="true"/' "$CONFIG"
    echo -e "${GREEN}✓ CassToolSSH aktifleştirildi${NC}"
    echo -e "${CYAN}SSH girişlerinde karşılama ekranı gösterilecek${NC}"
}

disable_motd() {
    if [ ! -f "$CONFIG" ]; then
        echo -e "${RED}Hata: Yapılandırma dosyası bulunamadı${NC}"
        exit 1
    fi
    
    sed -i 's/MOTD_ENABLED="true"/MOTD_ENABLED="false"/' "$CONFIG"
    echo -e "${YELLOW}! CassToolSSH devre dışı bırakıldı${NC}"
    echo -e "${CYAN}SSH girişlerinde karşılama ekranı gösterilmeyecek${NC}"
}

show_status() {
    if [ ! -f "$CONFIG" ]; then
        echo -e "${RED}CassToolSSH kurulu değil${NC}"
        exit 1
    fi
    
    source "$CONFIG"
    
    echo -e "${CYAN}${BOLD}CassToolSSH Durum${NC}"
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
    /opt/CassToolSSH/motd.sh
}

change_style() {
    echo -e "${CYAN}Mevcut Stiller:${NC}"
    echo "1) CassToolSSH  2) minimal"
    echo "3) blocks      4) simple"
    echo ""
    read -p "Stil seçin [1-4]: " choice
    
    case $choice in
        1) style="CassToolSSH" ;;
        2) style="minimal" ;;
        3) style="blocks" ;;
        4) style="simple" ;;
        *) echo -e "${RED}Geçersiz seçim${NC}"; exit 1 ;;
    esac
    
    sed -i "s/ASCII_STYLE=\".*\"/ASCII_STYLE=\"$style\"/" "$CONFIG"
    echo -e "${GREEN}✓ Stil değiştirildi: $style${NC}"
    /opt/CassToolSSH/motd.sh
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
        /opt/CassToolSSH/customize.sh
        ;;
    test)
        /opt/CassToolSSH/motd.sh
        ;;
    theme)
        change_theme
        ;;
    style)
        change_style
        ;;
    uninstall)
        /opt/CassToolSSH/uninstall.sh
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
TOOLEOF

    chmod +x /usr/local/bin/casstool
    echo -e "${GREEN}[✓]${NC} 'casstool' komutu oluşturuldu"
}

# Create helper scripts
create_helper_scripts() {
    local install_dir="/opt/CassToolSSH"
    
    # Customize script
    cat > "$install_dir/customize.sh" << 'CUSTOMEOF'
#!/bin/bash

CONFIG_FILE="/etc/CassToolSSH.conf"

echo "CassToolSSH Özelleştirme Yardımcısı"
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
            echo "Mevcut stiller: CassToolSSH, minimal, blocks, simple"
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
            /opt/CassToolSSH/motd.sh
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

echo "CassToolSSH kaldırılıyor..."

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
rm -f /usr/local/bin/casstool

echo "CassToolSSH kaldırıldı"
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
    echo -e "  ${YELLOW}casstool status${NC}      - Durum bilgisi"
    echo -e "  ${YELLOW}casstool enable${NC}      - Aktifleştir"
    echo -e "  ${YELLOW}casstool disable${NC}     - Devre dışı bırak"
    echo -e "  ${YELLOW}casstool test${NC}        - Test et"
    echo -e "  ${YELLOW}casstool theme${NC}       - Tema değiştir"
    echo -e "  ${YELLOW}casstool config${NC}      - Yapılandırmayı düzenle"
    echo ""
    
    echo -e "${CYAN}${BOLD}Dosya Konumları:${NC}"
    echo -e "  Config:  ${YELLOW}/etc/CassToolSSH.conf${NC}"
    echo -e "  Scripts: ${YELLOW}/opt/CassToolSSH/${NC}"
    echo ""
    
    if [ "$ENABLE_MOTD" = "true" ]; then
        echo -e "${GREEN}${BOLD}SSH bağlantılarında CassToolSSH karşılama ekranı gösterilecek!${NC}"
        echo -e "${CYAN}Şimdi test etmek için: ${YELLOW}casstool test${NC}"
    else
        echo -e "${YELLOW}MOTD devre dışı. Aktifleştirmek için: ${BOLD}casstool enable${NC}"
    fi
    
    echo ""
    echo -e "${DIM}Daha fazla bilgi: https://github.com/ahmetakifcetin/CassToolSSH${NC}"
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
    create_casstool_command
    create_helper_scripts
    
    show_completion
}

# Run main
main
