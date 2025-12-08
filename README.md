# CassMarrow 🚀

**Beautiful, customizable server greeting system for Linux servers**

Transform your boring SSH login into a stunning, informative welcome screen with real-time system statistics, service monitoring, and beautiful ASCII art.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-green.svg)
![Shell](https://img.shields.io/badge/shell-bash-yellow.svg)

## ✨ Features

- 🎨 **Beautiful ASCII Art** - Multiple styles to choose from
- 📊 **Real-time System Stats** - CPU, Memory, Disk, Network
- 🐳 **Docker Integration** - Container count and status
- 🔧 **Service Monitoring** - Track your critical services
- 🎭 **Customizable Themes** - 6 color themes included
- ⚡ **Zero Dependencies** - Pure bash, works everywhere
- 🔌 **Easy Installation** - One command setup
- 🎯 **Highly Configurable** - Toggle any feature on/off

## 📸 Screenshots

### CassMarrow Style (Default)
```
 ██████╗ █████╗ ███████╗███████╗███╗   ███╗ █████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║
██║     ███████║███████╗███████╗██╔████╔██║███████║██████╔╝██████╔╝██║   ██║██║ █╗ ██║
██║     ██╔══██║╚════██║╚════██║██║╚██╔╝██║██╔══██║██╔══██╗██╔══██╗██║   ██║██║███╗██║
╚██████╗██║  ██║███████║███████║██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║╚██████╔╝╚███╔███╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝

CassMarrow Infrastructure
Version: v1.0
Status: [ ONLINE ]

═══════════════════════════════════════════════════════════════════
Host:           server.example.com
Kernel:         6.8.0-88-generic
Uptime:         1 week, 2 hours, 47 minutes
Load Average:   0.08, 0.15, 0.20
Memory:         2602MB used / 7941MB total (32.8%)
Disk /:         118G used / 145G total (81%)
Local IP:       192.168.1.100
Public IP:      203.0.113.42

Docker:         ● Running (12 containers)

Services:
● nginx
● docker
● postgresql
● mysql

Last Login:
root     pts/0        Mon Dec  8 14:03 - 14:03  (00:00)

═══════════════════════════════════════════════════════════════════
```

### Other Styles Available
- **Minimal** - Clean and simple
- **Blocks** - Modern block characters
- **Simple** - Classic text-based

## 🚀 Quick Start

### One-Line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/cassmarrow/main/install.sh | sudo bash
```

Or download and run manually:

```bash
wget https://raw.githubusercontent.com/yourusername/cassmarrow/main/install.sh
chmod +x install.sh
sudo ./install.sh
```

### What it does
1. Backs up your existing MOTD configuration
2. Installs CassMarrow to `/opt/cassmarrow`
3. Creates configuration file at `/etc/cassmarrow.conf`
4. Sets up automatic greeting on login
5. Provides customization tools

## ⚙️ Configuration

### Quick Customization

Use the built-in customization helper:

```bash
sudo /opt/cassmarrow/customize.sh
```

### Manual Configuration

Edit the configuration file:

```bash
sudo nano /etc/cassmarrow.conf
```

### Configuration Options

```bash
# Display Settings
SHOW_HOSTNAME=true      # Show server hostname
SHOW_KERNEL=true        # Show kernel version
SHOW_UPTIME=true        # Show system uptime
SHOW_LOAD=true          # Show load average
SHOW_MEMORY=true        # Show memory usage
SHOW_DISK=true          # Show disk usage
SHOW_IP=true            # Show IP addresses
SHOW_DOCKER=true        # Show Docker status
SHOW_SERVICES=true      # Show monitored services
SHOW_LAST_LOGIN=true    # Show last login info

# Custom Text
SYSTEM_NAME="CassMarrow Infrastructure"
SYSTEM_VERSION="v1.0"
CUSTOM_MESSAGE=""       # Optional footer message

# Color Theme
COLOR_THEME="cyan"      # Options: blue, green, purple, cyan, red, yellow

# ASCII Art Style
ASCII_STYLE="cassmarrow" # Options: cassmarrow, minimal, blocks, simple

# Services to Monitor
MONITORED_SERVICES="nginx docker postgresql mysql redis"
```

## 🎨 Customization Examples

### Change Color Theme

```bash
sudo sed -i 's/COLOR_THEME="cyan"/COLOR_THEME="purple"/' /etc/cassmarrow.conf
```

### Change ASCII Style

```bash
sudo sed -i 's/ASCII_STYLE="cassmarrow"/ASCII_STYLE="minimal"/' /etc/cassmarrow.conf
```

### Add Custom Message

```bash
echo 'CUSTOM_MESSAGE="Welcome to Production Server - Handle with care!"' | sudo tee -a /etc/cassmarrow.conf
```

### Monitor Different Services

```bash
sudo sed -i 's/MONITORED_SERVICES=".*"/MONITORED_SERVICES="nginx apache2 mongodb redis"/' /etc/cassmarrow.conf
```

## 🔧 Advanced Usage

### Test Your Configuration

```bash
/opt/cassmarrow/motd.sh
```

### Disable Specific Features

Edit `/etc/cassmarrow.conf` and set any `SHOW_*` option to `false`:

```bash
SHOW_DOCKER=false
SHOW_LAST_LOGIN=false
```

### Create Custom ASCII Art

You can create your own ASCII art and modify the `print_ascii_art()` function in `/opt/cassmarrow/motd.sh`.

Tools for creating ASCII art:
- [ASCII Art Generator](http://patorjk.com/software/taag/)
- [Text to ASCII](https://www.ascii-art-generator.org/)

## 🗑️ Uninstallation

```bash
sudo /opt/cassmarrow/uninstall.sh
```

This will:
- Restore your original MOTD configuration
- Remove all CassMarrow files
- Clean up configuration files

## 🐳 Docker Container Usage

You can also use CassMarrow in Docker containers:

```dockerfile
FROM ubuntu:24.04

# Install CassMarrow
RUN apt-get update && apt-get install -y curl sudo
RUN curl -fsSL https://raw.githubusercontent.com/yourusername/cassmarrow/main/install.sh | bash

# Your container setup here
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit your changes** (`git commit -m 'Add some AmazingFeature'`)
4. **Push to the branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request**

### Ideas for Contributions

- [ ] New ASCII art styles
- [ ] Additional color themes
- [ ] More system information displays
- [ ] Support for other Linux distributions (CentOS, Arch, etc.)
- [ ] Integration with monitoring tools (Prometheus, Grafana)
- [ ] Weather information display
- [ ] Custom plugin system
- [ ] Multi-language support

## 📋 Requirements

- Linux-based operating system (Ubuntu, Debian, CentOS, etc.)
- Bash 4.0 or higher
- Root or sudo access for installation

## 🛠️ Compatibility

Tested on:
- ✅ Ubuntu 24.04 LTS
- ✅ Ubuntu 22.04 LTS
- ✅ Ubuntu 20.04 LTS
- ✅ Debian 12
- ✅ Debian 11
- ⚠️ CentOS/RHEL (should work, but not extensively tested)
- ⚠️ Arch Linux (should work, but not extensively tested)

## 📝 Changelog

### Version 1.0.0 (Current)
- Initial release
- Multiple ASCII art styles
- 6 color themes
- Docker integration
- Service monitoring
- Customization helper
- Easy installation/uninstallation

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Created by [Joel](https://github.com/yourusername) and the open-source community
- Inspired by the need for beautiful, informative server greetings
- Special thanks to all contributors

## 📞 Support

- 🐛 [Report a Bug](https://github.com/yourusername/cassmarrow/issues)
- 💡 [Request a Feature](https://github.com/yourusername/cassmarrow/issues)
- 💬 [Discussions](https://github.com/yourusername/cassmarrow/discussions)

## 🌟 Show Your Support

If you find CassMarrow useful, please consider:
- ⭐ Starring the repository
- 🐦 Sharing on social media
- 🤝 Contributing to the project

---

**Made with ❤️ for the self-hosting community**

[GitHub](https://github.com/yourusername/cassmarrow) • [Issues](https://github.com/yourusername/cassmarrow/issues) • [Discussions](https://github.com/yourusername/cassmarrow/discussions)
