# CassToolSSH Quick Start Guide

Get CassToolSSH up and running in under 5 minutes! ⚡

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
sudo /opt/CassToolSSH/customize.sh
```

### 3. Manual Configuration

Edit the config file directly:

```bash
sudo nano /etc/CassToolSSH.conf
```

## 🎨 Popular Customizations

### Change Color Theme

```bash
# Available: blue, green, purple, cyan, red, yellow
sudo sed -i 's/COLOR_THEME="cyan"/COLOR_THEME="purple"/' /etc/CassToolSSH.conf
```

### Change ASCII Style

```bash
# Available: CassToolSSH, minimal, blocks, simple
sudo sed -i 's/ASCII_STYLE="CassToolSSH"/ASCII_STYLE="minimal"/' /etc/CassToolSSH.conf
```

### Add Custom Message

```bash
echo 'CUSTOM_MESSAGE="Welcome to Production! Handle with care 🚀"' | sudo tee -a /etc/CassToolSSH.conf
```

### Change System Name

```bash
sudo sed -i 's/SYSTEM_NAME="CassToolSSH Infrastructure"/SYSTEM_NAME="My Awesome Server"/' /etc/CassToolSSH.conf
```

### Monitor Different Services

```bash
sudo sed -i 's/MONITORED_SERVICES=".*"/MONITORED_SERVICES="nginx apache2 redis mongodb"/' /etc/CassToolSSH.conf
```

## 🧪 Testing

Test your configuration without logging out:

```bash
/opt/CassToolSSH/motd.sh
```

## 📋 Common Use Cases

### Production Server Setup

```bash
cat << 'EOF' | sudo tee /etc/CassToolSSH.conf
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
ASCII_STYLE="CassToolSSH"
MONITORED_SERVICES="nginx docker postgresql redis"
EOF
```

### Development Environment

```bash
cat << 'EOF' | sudo tee /etc/CassToolSSH.conf
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
cat << 'EOF' | sudo tee /etc/CassToolSSH.conf
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
   ls -la /opt/CassToolSSH/
   ls -la /etc/update-motd.d/00-CassToolSSH   ```

2. **Test manually:**
   ```bash
   /opt/CassToolSSH/motd.sh
   ```

3. **Check permissions:**
   ```bash
   sudo chmod +x /etc/update-motd.d/00-CassToolSSH   sudo chmod +x /opt/CassToolSSH/motd.sh
   ```

### Configuration Not Working?

1. **Validate syntax:**
   ```bash
   bash -n /opt/CassToolSSH/motd.sh
   ```

2. **Check config file:**
   ```bash
   cat /etc/CassToolSSH.conf
   ```

3. **Reset to defaults:**
   ```bash
   sudo /opt/CassToolSSH/uninstall.sh
   curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH/main/install.sh | sudo bash
   ```

### Services Not Showing?

Make sure the service names match your system:

```bash
# List all services
systemctl list-unit-files --type=service | grep -v '@'

# Update monitored services
sudo nano /etc/CassToolSSH.conf
# Change MONITORED_SERVICES line
```

## 🗑️ Uninstallation

```bash
sudo /opt/CassToolSSH/uninstall.sh
```

This will:
- Remove CassToolSSH files
- Restore original MOTD
- Clean up configuration

## 📚 Next Steps

- **Full documentation**: [README.md](README.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Examples**: [CassToolSSH.conf.example](CassToolSSH.conf.example)
- **Report issues**: [GitHub Issues](https://github.com/ahmetakifcetin/CassToolSSH/issues)

## 💡 Pro Tips

1. **Keep it simple**: Start with default settings, customize gradually
2. **Test changes**: Always run `/opt/CassToolSSH/motd.sh` after editing config
3. **Backup config**: `sudo cp /etc/CassToolSSH.conf /etc/CassToolSSH.conf.backup`
4. **Use themes**: Different colors for dev/staging/production servers
5. **Monitor wisely**: Only add services you actually care about

## 🎯 Common Commands Cheat Sheet

```bash
# Edit configuration
sudo nano /etc/CassToolSSH.conf

# Test configuration
/opt/CassToolSSH/motd.sh

# Interactive customization
sudo /opt/CassToolSSH/customize.sh

# View current config
cat /etc/CassToolSSH.conf

# Uninstall
sudo /opt/CassToolSSH/uninstall.sh

# Reinstall
curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH/main/install.sh | sudo bash
```

## 🆘 Getting Help

- **GitHub Issues**: [Report a bug](https://github.com/ahmetakifcetin/CassToolSSH/issues/new?template=bug_report.md)
- **Feature Request**: [Suggest a feature](https://github.com/ahmetakifcetin/CassToolSSH/issues/new?template=feature_request.md)
- **Discussions**: [Ask questions](https://github.com/ahmetakifcetin/CassToolSSH/discussions)

---

**Happy customizing! 🚀**

Made with ❤️ by the CassToolSSH community
