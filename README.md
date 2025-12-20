# casstool 🚀

**Professional Server Greeting System for Linux**

Transform your SSH login into a beautiful, informative welcome screen with real-time system stats, gradient themes, and customizable styles.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-green.svg)
![Shell](https://img.shields.io/badge/shell-bash-yellow.svg)
![Version](https://img.shields.io/badge/version-2.0.0-cyan.svg)

---

## ✨ Features

- 🎨 **10+ Gradient Themes** - Matrix, Ocean, Sunset, Fire, Ice, Neon, and more
- 🖼️ **3 ASCII Art Styles** - Professional, Minimal, Retro
- 📊 **Real-time System Stats** - CPU, Memory, Disk, Network with smart warnings
- 🐳 **Docker Integration** - Container count and status monitoring
- 🔧 **Service Monitoring** - Track your critical services
- 🚦 **Smart Status Indicators** - Optimal, Moderate, Heavy Load detection
- ⚡ **Zero Dependencies** - Pure bash, works everywhere
- 🎯 **Easy Management** - Simple `casstool` command for all operations

---

## 🎨 Styles & Themes

### Style 1: casstool (Professional)

<details>
<summary>🔵 Ice Theme (Default)</summary>

```
 ██████╗ █████╗ ███████╗███████╗███╗   ███╗ █████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║
██║     ███████║███████╗███████╗██╔████╔██║███████║██████╔╝██████╔╝██║   ██║██║ █╗ ██║
██║     ██╔══██║╚════██║╚════██║██║╚██╔╝██║██╔══██║██╔══██╗██╔══██╗██║   ██║██║███╗██║
╚██████╗██║  ██║███████║███████║██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║╚██████╔╝╚███╔███╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝

Production Infrastructure  │  v1.0  │  ● OPTIMAL
────────────────────────────────────────────────────────────────────────────────

System               app.mycar724.com                      Kernel 6.8.0-87-generic
Uptime               7 days, 14 hours, 32 minutes          Load   0.45, 0.38, 0.32
Memory               3854 MB / 7941 MB (48.5%)
Disk (/)             118G / 145G (81%)
Local IP             192.168.1.100                         Public 203.0.113.42

Docker               ● Running (8 containers)

Services
  ● nginx
  ● docker
  ● postgresql
  ● redis

Last Login
  joel from 212.252.140.19 on Dec 21 00:20 at 00:20

────────────────────────────────────────────────────────────────────────────────
```
</details>

<details>
<summary>🟢 Matrix Theme</summary>

![Matrix Theme](screenshots/casstool-matrix.png)
</details>

<details>
<summary>🌅 Sunset Theme</summary>

![Sunset Theme](screenshots/casstool-sunset.png)
</details>

<details>
<summary>🔥 Fire Theme</summary>

![Fire Theme](screenshots/casstool-fire.png)
</details>

<details>
<summary>🟣 Neon Theme</summary>

![Neon Theme](screenshots/casstool-neon.png)
</details>

### Style 2: Minimal (Clean & Simple)

<details>
<summary>💼 Corporate Theme</summary>

```
╔════════════════════════════════════════════════════════════════════════════════╗
║                              C A S S M A R R O W                               ║
╠════════════════════════════════════════════════════════════════════════════════╣

Production Infrastructure  │  v1.0  │  ● OPTIMAL
╠════════════════════════════════════════════════════════════════════════════════╣

System               app.mycar724.com                      Kernel 6.8.0-87-generic
Uptime               7 days, 14 hours, 32 minutes          Load   0.45, 0.38, 0.32
Memory               3854 MB / 7941 MB (48.5%)
Disk (/)             118G / 145G (81%)

╚════════════════════════════════════════════════════════════════════════════════╝
```
</details>

### Style 3: Retro (Classic Terminal)

<details>
<summary>🟩 Hacker Theme</summary>

```
  ___   _   ___ ___ __  __   _   ___ ___  _____      __
 / __| /_\ / __/ __|  \/  | /_\ | _ \ _ \/ _ \ \    / /
| (__ / _ \\__ \__ \ |\/| |/ _ \|   /   / (_) \ \/\/ / 
 \___/_/ \_\___/___/_|  |_/_/ \_\_|_\_|_\\___/ \_/\_/  

Production Infrastructure  │  v1.0  │  ● OPTIMAL
────────────────────────────────────────────────────────────────────────────────

System               app.mycar724.com                      Kernel 6.8.0-87-generic
Uptime               7 days, 14 hours, 32 minutes          Load   0.45, 0.38, 0.32
Memory               3854 MB / 7941 MB (48.5%)

────────────────────────────────────────────────────────────────────────────────
```
</details>

---

## 🌈 All Available Themes

| Theme | Description | Best For |
|-------|-------------|----------|
| **ice** 🧊 | Cyan-blue gradient (default) | Modern tech servers |
| **matrix** 💚 | Green matrix style | Security/dev servers |
| **ocean** 🌊 | Deep blue gradient | Production databases |
| **sunset** 🌅 | Orange-pink gradient | Creative projects |
| **fire** 🔥 | Red-orange gradient | Critical systems |
| **neon** 💜 | Purple-pink gradient | Gaming/media servers |
| **hacker** 👾 | Dark green terminal | Pentesting/security |
| **corporate** 💼 | Gray-blue professional | Enterprise servers |
| **gold** 🏆 | Yellow-gold gradient | Premium services |
| **dracula** 🧛 | Purple dark theme | Developer workstations |
| **blue** 🔵 | Classic blue | Professional use |
| **green** 🟢 | Classic green | Production success |
| **purple** 🟣 | Classic purple | Creative work |
| **cyan** 🔷 | Classic cyan | Tech focused |
| **red** 🔴 | Classic red | Warning/critical |
| **yellow** 🟡 | Classic yellow | Staging/test |

---

## 🚀 Quick Start

### One-Line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/casstool/main/install.sh | sudo bash
```

### Manual Installation

```bash
# Download installer
wget https://raw.githubusercontent.com/ahmetakifcetin/casstool/main/install.sh

# Make executable
chmod +x install.sh

# Run installation
sudo ./install.sh
```

### First Steps

```bash
# Test your setup
casstool test

# Check status
casstool status

# Change theme
casstool theme

# Change style
casstool style
```

---

## 🎮 Usage

### Management Commands

```bash
casstool status      # Show current configuration
casstool enable      # Enable MOTD on SSH login
casstool disable     # Disable MOTD on SSH login
casstool test        # Preview current setup
casstool theme       # Quick theme switcher
casstool style       # Quick style switcher
casstool config      # Edit configuration file
casstool customize   # Interactive customization
casstool uninstall   # Remove casstool
```

### Quick Theme Switch

```bash
# Interactive menu
casstool theme

# Or edit config directly
sudo nano /etc/casstool.conf
# Change: COLOR_THEME="ice"
```

### Quick Style Switch

```bash
# Available styles: casstool, minimal, retro
casstool style
```

---

## ⚙️ Configuration

Configuration file: `/etc/casstool.conf`

```bash
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

# System Info
SYSTEM_NAME="Production Infrastructure"
SYSTEM_VERSION="v1.0"
CUSTOM_MESSAGE="Welcome to Production - Handle with care!"

# Theme & Style
COLOR_THEME="ice"        # See theme table above
ASCII_STYLE="casstool" # casstool, minimal, retro

# Services to Monitor
MONITORED_SERVICES="nginx docker postgresql mysql redis"

# MOTD Control
MOTD_ENABLED="true"
```

---

## 🎯 Use Cases

### Production Server (Fire Theme)

```bash
SYSTEM_NAME="Production API Server"
COLOR_THEME="fire"
ASCII_STYLE="casstool"
CUSTOM_MESSAGE="⚠️  PRODUCTION - All changes require approval"
MONITORED_SERVICES="nginx docker postgresql redis"
```

### Development Server (Matrix Theme)

```bash
SYSTEM_NAME="Development Environment"
COLOR_THEME="matrix"
ASCII_STYLE="retro"
CUSTOM_MESSAGE="🚀 Happy coding! Break things, learn, repeat."
MONITORED_SERVICES="docker postgresql"
```

### Database Server (Ocean Theme)

```bash
SYSTEM_NAME="PostgreSQL Cluster"
COLOR_THEME="ocean"
ASCII_STYLE="minimal"
CUSTOM_MESSAGE="🗄️  Database cluster - Read replicas active"
MONITORED_SERVICES="postgresql pgbouncer redis"
```

### Security Server (Hacker Theme)

```bash
SYSTEM_NAME="Security Gateway"
COLOR_THEME="hacker"
ASCII_STYLE="retro"
CUSTOM_MESSAGE="🔒 Authorized access only - All actions logged"
MONITORED_SERVICES="ssh fail2ban ufw iptables"
```

---

## 🚦 Smart Features

### Status Indicators

- **● OPTIMAL** (Green) - Load < 70% - System running smoothly
- **● MODERATE** (Yellow) - Load 70-90% - Attention may be needed
- **● HEAVY LOAD** (Red) - Load > 90% - Immediate action required

### Memory & Disk Warnings

- **Normal**: `3854 MB / 7941 MB (48.5%)`
- **Warning** (75%+): `6120 MB / 7941 MB (77.1%)`
- **Critical** (90%+): `7200 MB / 7941 MB (⚠ 90.7%)`

### Docker Integration

- Shows running container count
- Indicates Docker daemon status
- Graceful handling when Docker is not installed

---

## 🛠️ Advanced Customization

### Custom ASCII Art

Edit `/opt/casstool/motd.sh` and add your own ASCII art in the `print_ascii_art()` function.

### Custom Themes

Create your own gradient theme by editing the color definitions in the MOTD script.

### Service Monitoring

Add any systemd service to the monitoring list:

```bash
MONITORED_SERVICES="nginx apache2 mysql postgresql redis mongodb docker gitlab-runner jenkins"
```

---

## 📋 Requirements

- **OS**: Ubuntu 20.04+, Debian 11+, or compatible Linux distribution
- **Shell**: Bash 4.0+
- **Privileges**: Root/sudo access for installation
- **Optional**: Docker (for Docker status display)

---

## 🔧 Troubleshooting

### MOTD Not Showing

```bash
# Check if enabled
casstool status

# Enable MOTD
casstool enable

# Test manually
casstool test

# Verify SSH config
grep PrintMotd /etc/ssh/sshd_config

# Should show: PrintMotd yes
```

### Theme Not Applying

```bash
# Verify config
cat /etc/casstool.conf | grep COLOR_THEME

# Test with different theme
sudo sed -i 's/COLOR_THEME=.*/COLOR_THEME="matrix"/' /etc/casstool.conf
casstool test
```

### Services Not Showing

```bash
# List available services
systemctl list-units --type=service | grep -v '@'

# Update monitored services
sudo nano /etc/casstool.conf
# Edit: MONITORED_SERVICES="nginx docker"
```

---

## 🗑️ Uninstallation

```bash
# Quick uninstall
casstool uninstall

# Or manually
sudo /opt/casstool/uninstall.sh
```

This will:
- Remove all casstool files
- Restore original MOTD configuration
- Clean up configuration files

---

## 🤝 Contributing

Contributions are welcome! Here's how:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Ideas for Contributions

- [ ] New ASCII art styles
- [ ] Additional gradient themes
- [ ] GPU information display
- [ ] Network traffic statistics
- [ ] Multi-language support
- [ ] Weather integration
- [ ] Custom widget system

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Created by [Joel](https://github.com/ahmetakifcetin)
- Inspired by the need for beautiful, professional server greetings
- Special thanks to the open-source community

---

## 📞 Support

- 🐛 [Report Bug](https://github.com/ahmetakifcetin/CassToolSSH/issues/new?template=bug_report.md)
- 💡 [Request Feature](https://github.com/ahmetakifcetin/CassToolSSH/issues/new?template=feature_request.md)
- 💬 [Discussions](https://github.com/ahmetakifcetin/CassToolSSH/discussions)

---

## 🌟 Show Your Support

If you find casstool useful:
- ⭐ Star the repository
- 🐦 Share on social media
- 🤝 Contribute to the project

---

**Made with ❤️ for the self-hosting community**

[GitHub](https://github.com/ahmetakifcetin/CassToolSSH) • [Issues](https://github.com/ahmetakifcetin/CassToolSSH/issues) • [Discussions](https://github.com/ahmetakifcetin/CassToolSSH/discussions)
