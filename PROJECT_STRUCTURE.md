# CassMarrow Project Structure

## Repository Layout

```
cassmarrow/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md           # Bug report template
│   │   └── feature_request.md      # Feature request template
│   └── workflows/
│       └── ci.yml                  # GitHub Actions CI/CD
├── .gitignore                      # Git ignore rules
├── CHANGELOG.md                    # Version history
├── CONTRIBUTING.md                 # Contribution guidelines
├── LICENSE                         # MIT License
├── README.md                       # Main documentation
├── QUICKSTART.md                   # Quick start guide
├── SCREENSHOTS.md                  # Screenshot guide
├── cassmarrow.conf.example         # Example configuration
├── demo.sh                         # Interactive demo script
├── install.sh                      # Main installation script
└── test.sh                         # Test suite
```

## Installation Layout (After Running install.sh)

```
Server filesystem after installation:

/opt/cassmarrow/
├── motd.sh                         # Main MOTD script
├── customize.sh                    # Interactive customization
└── uninstall.sh                    # Uninstallation script

/etc/
├── cassmarrow.conf                 # User configuration
└── update-motd.d/
    ├── 00-cassmarrow              # MOTD hook (active)
    ├── 10-help-text               # Disabled
    ├── 50-motd-news               # Disabled
    └── ...                        # Other default scripts (disabled)

/etc/update-motd.d.backup/          # Backup of original MOTD scripts
```

## File Descriptions

### Core Files

#### install.sh
- **Purpose**: Main installation script
- **Features**:
  - System detection
  - Backup creation
  - File installation
  - Configuration setup
  - Permission management
- **Usage**: `sudo ./install.sh`

#### /opt/cassmarrow/motd.sh
- **Purpose**: Main greeting script
- **Features**:
  - ASCII art rendering
  - System information gathering
  - Service monitoring
  - Color theme application
  - Configuration loading
- **Usage**: `/opt/cassmarrow/motd.sh` (automatic on login)

#### /etc/cassmarrow.conf
- **Purpose**: User configuration file
- **Contents**:
  - Display toggles
  - Theme settings
  - Custom messages
  - Service list
- **Usage**: Edit with `nano /etc/cassmarrow.conf`

### Helper Scripts

#### /opt/cassmarrow/customize.sh
- **Purpose**: Interactive customization tool
- **Features**:
  - Theme switching
  - Style selection
  - Service configuration
  - Live preview
- **Usage**: `sudo /opt/cassmarrow/customize.sh`

#### /opt/cassmarrow/uninstall.sh
- **Purpose**: Clean removal
- **Features**:
  - Restore original MOTD
  - Remove all files
  - Clean configuration
- **Usage**: `sudo /opt/cassmarrow/uninstall.sh`

### Documentation

#### README.md
- Installation instructions
- Feature overview
- Configuration examples
- Troubleshooting
- Contributing information

#### QUICKSTART.md
- 5-minute setup guide
- Common use cases
- Quick commands
- Troubleshooting tips

#### CONTRIBUTING.md
- Development guidelines
- Code style rules
- PR process
- Testing requirements

#### CHANGELOG.md
- Version history
- Feature additions
- Bug fixes
- Breaking changes

#### SCREENSHOTS.md
- Screenshot guide
- Demo setup
- Image optimization
- Privacy tips

### Configuration

#### cassmarrow.conf.example
- Example configurations
- All available options
- Use case templates
- Quick copy-paste setups

### Testing

#### demo.sh
- Interactive demonstration
- All styles and themes
- Live preview
- Feature showcase

#### test.sh
- Automated test suite
- Syntax validation
- Installation testing
- Configuration testing
- Uninstallation testing

### CI/CD

#### .github/workflows/ci.yml
- Automated testing
- Multiple Ubuntu versions
- ShellCheck validation
- Documentation checks

#### .github/ISSUE_TEMPLATE/
- Standardized bug reports
- Feature request template
- Consistent issue tracking

## Key Directories

### Development
```
.github/                    # GitHub-specific files
├── ISSUE_TEMPLATE/        # Issue templates
└── workflows/             # CI/CD workflows
```

### Installation Target
```
/opt/cassmarrow/           # Application directory
/etc/                      # Configuration directory
/etc/update-motd.d/        # MOTD hooks
```

### Backup Location
```
/etc/update-motd.d.backup/ # Original MOTD backup
```

## File Permissions

### Executable Files
```
755 (rwxr-xr-x)
├── install.sh
├── demo.sh
├── test.sh
├── /opt/cassmarrow/motd.sh
├── /opt/cassmarrow/customize.sh
├── /opt/cassmarrow/uninstall.sh
└── /etc/update-motd.d/00-CassToolSSH```

### Configuration Files
```
644 (rw-r--r--)
├── /etc/cassmarrow.conf
├── cassmarrow.conf.example
└── All documentation files
```

### Root-Only Files
```
600 (rw-------)
└── Sensitive configurations (if any)
```

## Development Workflow

### Local Development
1. Clone repository
2. Make changes
3. Run `test.sh`
4. Test manually in VM/container
5. Update documentation
6. Commit and push

### Testing
1. Run shellcheck: `shellcheck install.sh`
2. Run test suite: `sudo ./test.sh`
3. Test on multiple Ubuntu versions
4. Test fresh installation
5. Test uninstallation

### Release Process
1. Update CHANGELOG.md
2. Update version numbers
3. Test thoroughly
4. Create GitHub release
5. Tag version
6. Update documentation

## Deployment

### Via GitHub
```bash
curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/cassmarrow/main/install.sh | sudo bash
```

### Manual
```bash
git clone https://github.com/ahmetakifcetin/cassmarrow.git
cd CassToolSSHsudo ./install.sh
```

### Docker
```dockerfile
FROM ubuntu:24.04
RUN curl -fsSL https://cassmarrow-url/install.sh | bash
```

## Backup Strategy

### User Data
- Configuration: `/etc/cassmarrow.conf`
- Backup location: `~/.cassmarrow.conf.backup` (user created)

### System Data
- Original MOTD: `/etc/update-motd.d.backup/`
- Automatic backup during installation

### Recovery
```bash
# Restore original MOTD
sudo /opt/cassmarrow/uninstall.sh

# Restore from manual backup
sudo cp ~/.cassmarrow.conf.backup /etc/cassmarrow.conf
```

## Size Information

### Repository Size
- Total: ~100KB (without screenshots)
- With screenshots: ~2-5MB

### Installation Size
- On disk: ~50KB
- Memory: Negligible (bash script)
- Runtime: <1 second

## Dependencies

### Required
- bash (4.0+)
- systemd (for service monitoring)
- standard Unix utilities (awk, sed, grep, df, free, uptime)

### Optional
- docker (for Docker integration)
- curl (for public IP detection)

### Development
- shellcheck (for linting)
- git (for version control)

## Maintenance

### Regular Tasks
- Update documentation
- Fix reported bugs
- Add requested features
- Update screenshots
- Test on new Ubuntu releases

### Version Updates
1. Update version in scripts
2. Update CHANGELOG.md
3. Update documentation
4. Test thoroughly
5. Create release

---

**Last Updated**: December 8, 2025
**Version**: 1.0.0
