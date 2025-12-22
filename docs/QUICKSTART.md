# casstool Quick Start Guide

Get casstool up and running in under 5 minutes! ⚡

## 🚀 Installation (30 seconds)

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH/main/install.sh | sudo bash
```

That's it! Log out and log back in to see your new greeting.

### Manual Installation

```bash
# Download the installer
wget https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH/main/install.sh

# Make it executable
chmod +x install.sh

# Run installation
sudo ./install.sh
```

## ✨ First Steps

### 1. See It In Action

Log out and log back in via SSH:

```bash
logout
# Then SSH back in
ssh user@your-server
```

### 2. Quick Customization

Run the interactive customizer:

```bash
sudo /opt/casstool/customize.sh
```

### 3. Manual Configuration

Edit the config file directly:

```bash
sudo nano /etc/casstool.conf
```

## 🎨 Popular Customizations

### Change Color Theme

```bash
# Available: blue, green, purple, cyan, red, yellow
sudo sed -i 's/COLOR_THEME="cyan"/COLOR_THEME="purple"/' /etc/casstool.conf
```

### Change ASCII Style

```bash
# Available: casstool, minimal, blocks, simple
sudo sed -i 's/ASCII_STYLE="casstool"/ASCII_STYLE="minimal"/' /etc/casstool.conf
```

### Add Custom Message

```bash
echo 'CUSTOM_MESSAGE="Welcome to Production! Handle with care 🚀"' | sudo tee -a /etc/casstool.conf
```

### Change System Name

```bash
sudo sed -i 's/SYSTEM_NAME="casstool Infrastructure"/SYSTEM_NAME="My Awesome Server"/' /etc/casstool.conf
```

### Monitor Different Services

```bash
sudo sed -i 's/MONITORED_SERVICES=".*"/MONITORED_SERVICES="nginx apache2 redis mongodb"/' /etc/casstool.conf
```

## 🧪 Testing

Test your configuration without logging out:

```bash
/opt/casstool/motd.sh
```

## 📋 Common Use Cases

### Production Server Setup

```bash
cat << 'EOF' | sudo tee /etc/casstool.conf
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
SYSTEM_NAME="Production API Server"
SYSTEM_VERSION="v2.0"
CUSTOM_MESSAGE="⚠️  PRODUCTION - All changes require approval"
COLOR_THEME="red"
ASCII_STYLE="casstool"
MONITORED_SERVICES="nginx docker postgresql redis"
EOF
```

### Development Environment

```bash
cat << 'EOF' | sudo tee /etc/casstool.conf
SHOW_HOSTNAME=true
SHOW_KERNEL=true
SHOW_UPTIME=true
SHOW_LOAD=true
SHOW_MEMORY=true
SHOW_DISK=true
SHOW_IP=true
SHOW_DOCKER=true
SHOW_SERVICES=true
SHOW_LAST_LOGIN=false
SYSTEM_NAME="Development Environment"
SYSTEM_VERSION="dev-latest"
CUSTOM_MESSAGE="🚀 Happy coding! Break things, learn, repeat."
COLOR_THEME="green"
ASCII_STYLE="blocks"
MONITORED_SERVICES="docker postgresql"
EOF
```

### Minimal Setup

```bash
cat << 'EOF' | sudo tee /etc/casstool.conf
SHOW_HOSTNAME=true
SHOW_KERNEL=true
SHOW_UPTIME=true
SHOW_LOAD=true
SHOW_MEMORY=true
SHOW_DISK=true
SHOW_IP=true
SHOW_DOCKER=false
SHOW_SERVICES=false
SHOW_LAST_LOGIN=false
SYSTEM_NAME="Server"
SYSTEM_VERSION=""
CUSTOM_MESSAGE=""
COLOR_THEME="cyan"
ASCII_STYLE="simple"
MONITORED_SERVICES=""
EOF
```

## 🔧 Troubleshooting

### Not Seeing the Greeting?

1. **Check installation:**
   ```bash
   ls -la /opt/casstool/
   ls -la /etc/update-motd.d/00-casstool   ```

2. **Test manually:**
   ```bash
   /opt/casstool/motd.sh
   ```

3. **Check permissions:**
   ```bash
   sudo chmod +x /etc/update-motd.d/00-casstool   sudo chmod +x /opt/casstool/motd.sh
   ```

### Configuration Not Working?

1. **Validate syntax:**
   ```bash
   bash -n /opt/casstool/motd.sh
   ```

2. **Check config file:**
   ```bash
   cat /etc/casstool.conf
   ```

3. **Reset to defaults:**
   ```bash
   sudo /opt/casstool/uninstall.sh
   curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH//Hmain/install.sh | sudo bash
   ```

### Services Not Showing?

Make sure the service names match your system:

```bash
# List all services
systemctl list-unit-files --type=service | grep -v '@'

# Update monitored services
sudo nano /etc/casstool.conf
# Change MONITORED_SERVICES line
```

## 🗑️ Uninstallation

```bash
sudo /opt/casstool/uninstall.sh
```

This will:
- Remove casstool files
- Restore original MOTD
- Clean up configuration

## 📚 Next Steps

- **Full documentation**: [README.md](README.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Examples**: [casstool.conf.example](casstool.conf.example)
- **Report issues**: [GitHub Issues](https://github.com/ahmetakifcetin/CassToolSSH//H/issues)

## 💡 Pro Tips

1. **Keep it simple**: Start with default settings, customize gradually
2. **Test changes**: Always run `/opt/casstool/motd.sh` after editing config
3. **Backup config**: `sudo cp /etc/casstool.conf /etc/casstool.conf.backup`
4. **Use themes**: Different colors for dev/staging/production servers
5. **Monitor wisely**: Only add services you actually care about

## 🎯 Common Commands Cheat Sheet

```bash
# Edit configuration
sudo nano /etc/casstool.conf

# Test configuration
/opt/casstool/motd.sh

# Interactive customization
sudo /opt/casstool/customize.sh

# View current config
cat /etc/casstool.conf

# Uninstall
sudo /opt/casstool/uninstall.sh

# Reinstall
curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH//Hmain/install.sh | sudo bash
```

## 🆘 Getting Help

- **GitHub Issues**: [Report a bug](https://github.com/ahmetakifcetin/CassToolSSH//H/issues/new?template=bug_report.md)
- **Feature Request**: [Suggest a feature](https://github.com/ahmetakifcetin/CassToolSSH//H/issues/new?template=feature_request.md)
- **Discussions**: [Ask questions](https://github.com/ahmetakifcetin/CassToolSSH//H/discussions)

---

**Happy customizing! 🚀**

Made with ❤️ by the casstool community
