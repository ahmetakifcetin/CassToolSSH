# Changelog

All notable changes to CassMarrow will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Weather information integration
- Custom plugin system
- Network traffic statistics
- GPU information display
- Multi-language support (Turkish, Spanish, French, etc.)
- Theme marketplace
- Web-based configuration interface

## [1.0.0] - 2025-12-08

### Added
- Initial release of CassMarrow
- Four ASCII art styles (CassMarrow, Minimal, Blocks, Simple)
- Six color themes (Blue, Green, Purple, Cyan, Red, Yellow)
- Real-time system information display:
  - Hostname and kernel version
  - System uptime
  - Load average (1, 5, 15 min)
  - Memory usage with percentage
  - Disk usage for root partition
  - Local and public IP addresses
- Docker integration:
  - Docker daemon status
  - Running container count
- Service monitoring:
  - Systemd service status checking
  - Customizable service list
- Last login information display
- Configuration file support (`/etc/cassmarrow.conf`)
- Interactive customization helper script
- One-line installation script
- Clean uninstallation process
- Automatic backup of original MOTD configuration
- Comprehensive documentation:
  - README.md with full feature list
  - CONTRIBUTING.md with development guidelines
  - Example configuration file
  - Issue templates for GitHub

### Features
- Zero dependencies (pure bash)
- Works on Ubuntu 20.04, 22.04, 24.04
- Compatible with Debian 11, 12
- Highly customizable via configuration file
- Toggle any feature on/off
- Custom header and footer messages
- Professional, production-ready design

### Installation
- Automated installation via curl script
- Manual installation option
- Proper permission handling
- Safe backup and restore mechanism

### Documentation
- Complete README with examples
- Contributing guidelines
- MIT License
- Bug report and feature request templates
- Example configurations for different use cases

## [0.0.1] - 2025-12-08 (Beta)

### Added
- Initial proof of concept
- Basic ASCII art display
- System information gathering
- Configuration file structure

---

## Version History

### Future Releases

#### [1.1.0] - Planned
- Weather information display
- Network statistics
- Customizable widget system
- More ASCII art styles

#### [1.2.0] - Planned
- Plugin architecture
- Community theme repository
- GPU information (NVIDIA, AMD)
- Container orchestration support (Kubernetes, Docker Swarm)

#### [2.0.0] - Planned
- Web-based configuration interface
- Multi-user customization
- Remote server monitoring
- Cloud provider integration (AWS, Azure, GCP)

---

## Upgrade Guide

### From 0.x to 1.0.0
```bash
# Backup your configuration
sudo cp /etc/cassmarrow.conf /etc/cassmarrow.conf.backup

# Run installation script
curl -fsSL https://raw.githubusercontent.com/yourusername/cassmarrow/main/install.sh | sudo bash

# Restore your custom settings if needed
sudo nano /etc/cassmarrow.conf
```

---

## Release Notes

### Version 1.0.0 - Initial Release

This is the first stable release of CassMarrow! 🎉

CassMarrow is a beautiful, customizable server greeting system designed for Linux servers. It transforms the standard SSH login experience into an informative and visually appealing welcome screen.

**Key Highlights:**
- Production-ready and stable
- Extensively tested on Ubuntu and Debian
- Zero configuration required (works out of the box)
- Highly customizable (30+ configuration options)
- Beautiful ASCII art with multiple styles
- Real-time system monitoring
- Professional design suitable for both personal and enterprise use

**Special Thanks:**
Thanks to the open-source community for inspiration and feedback during development.

---

[Unreleased]: https://github.com/yourusername/cassmarrow/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourusername/cassmarrow/releases/tag/v1.0.0
[0.0.1]: https://github.com/yourusername/cassmarrow/releases/tag/v0.0.1
