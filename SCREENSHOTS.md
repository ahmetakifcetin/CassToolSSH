# Screenshot Guide

## How to Create Screenshots for CassToolSSH
This guide helps you create beautiful screenshots for the README and documentation.

## Quick Screenshots

### Terminal Setup
1. Use a terminal with good font rendering (iTerm2, Alacritty, or GNOME Terminal)
2. Set terminal size: 120 columns × 40 rows
3. Use a dark theme for better contrast
4. Font: Monospace, 12-14pt

### Taking Screenshots

#### Method 1: Using demo.sh
```bash
# Run the demo script
./demo.sh

# Take screenshots at each pause
# Use your OS screenshot tool:
# - macOS: Cmd+Shift+4
# - Linux: gnome-screenshot or flameshot
# - Windows: Snipping Tool
```

#### Method 2: Manual Testing
```bash
# SSH into your server
ssh user@server

# It will automatically display CassToolSSH greeting
# Take screenshot

# Or test manually:
/opt/CassToolSSH/motd.sh
```

## Screenshot Checklist

### Main Screenshot (README hero)
- [ ] Full CassToolSSH ASCII art
- [ ] All system information visible
- [ ] Clean terminal background
- [ ] No personal/sensitive information
- [ ] Good contrast and readability

### Theme Screenshots
For each theme (blue, green, purple, cyan, red, yellow):
- [ ] Same layout for comparison
- [ ] Clear color differences
- [ ] Readable text

### Style Screenshots
For each style (CassToolSSH, minimal, blocks, simple):
- [ ] Full view of ASCII art
- [ ] System info section
- [ ] Consistent terminal size

## Automated Screenshot Generation

```bash
#!/bin/bash
# screenshot-automation.sh

STYLES="CassToolSSH minimal blocks simple"
THEMES="cyan purple green blue red yellow"

for style in $STYLES; do
    for theme in $THEMES; do
        sudo sed -i "s/ASCII_STYLE=.*/ASCII_STYLE=\"$style\"/" /etc/CassToolSSH.conf
        sudo sed -i "s/COLOR_THEME=.*/COLOR_THEME=\"$theme\"/" /etc/CassToolSSH.conf
        
        clear
        /opt/CassToolSSH/motd.sh
        
        # Manual: Take screenshot here
        # Or use automated screenshot tool:
        # gnome-screenshot -f "screenshots/${style}-${theme}.png"
        
        read -p "Press Enter for next..."
    done
done
```

## Post-Processing

### Image Optimization
```bash
# Install optimization tools
sudo apt-get install optipng

# Optimize PNG files
optipng -o7 screenshot.png

# Or use online tools:
# - TinyPNG: https://tinypng.com/
# - Squoosh: https://squoosh.app/
```

### Adding to Repository

1. Create `screenshots/` directory:
```bash
mkdir -p screenshots
```

2. Organize screenshots:
```
screenshots/
├── main-demo.png           # Hero screenshot
├── themes/
│   ├── blue.png
│   ├── green.png
│   ├── purple.png
│   ├── cyan.png
│   ├── red.png
│   └── yellow.png
└── styles/
    ├── CassToolSSH.png
    ├── minimal.png
    ├── blocks.png
    └── simple.png
```

3. Reference in README:
```markdown
![CassToolSSH Demo](screenshots/main-demo.png)

### Available Themes
![Cyan Theme](screenshots/themes/cyan.png)
![Purple Theme](screenshots/themes/purple.png)
```

## Tips for Great Screenshots

1. **Clean Terminal**
   - Clear previous commands: `clear`
   - No distracting background
   - Solid color background works best

2. **Good Lighting**
   - Increase terminal brightness if needed
   - Ensure text is readable

3. **Proper Size**
   - Not too large (file size)
   - Not too small (readability)
   - Target: 1200-1600px wide

4. **Consistency**
   - Same terminal size for all screenshots
   - Same font and font size
   - Same color scheme for background

5. **Privacy**
   - Hide real IP addresses
   - Hide sensitive hostnames
   - Hide personal information
   - Use demo configuration if needed

## Demo Server Setup

For consistent screenshots, set up a demo configuration:

```bash
# Create demo config
cat > /etc/CassToolSSH.conf << 'EOF'
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
SYSTEM_NAME="CassToolSSH Demo Infrastructure"
SYSTEM_VERSION="v1.0"
COLOR_THEME="cyan"
ASCII_STYLE="CassToolSSH"
MONITORED_SERVICES="nginx docker postgresql"
CUSTOM_MESSAGE="Beautiful server greeting for the self-hosting community"
CUSTOM_HEADER=""
EOF

# Override hostname display
sudo sed -i 's/$(hostname -f)/demo.CassToolSSH.local/' /opt/CassToolSSH/motd.sh

# Override IP display  
sudo sed -i 's/$(get_ip)/192.168.1.100/' /opt/CassToolSSH/motd.sh
sudo sed -i 's/$(get_public_ip)/203.0.113.42/' /opt/CassToolSSH/motd.sh
```

## Recording GIFs

For animated demonstrations:

### Using asciinema
```bash
# Install
sudo apt-get install asciinema

# Record
asciinema rec CassToolSSH-demo.cast

# Convert to GIF
# Use: https://github.com/asciinema/agg
agg CassToolSSH-demo.cast CassToolSSH-demo.gif
```

### Using terminalizer
```bash
# Install
npm install -g terminalizer

# Record
terminalizer record CassToolSSH-demo

# Render
terminalizer render CassToolSSH-demo
```

## Sample Screenshot Commands

```bash
# Take full screen
gnome-screenshot -f screenshots/main-demo.png

# Take window only
gnome-screenshot -w -f screenshots/window.png

# Take with delay (5 seconds)
gnome-screenshot -d 5 -f screenshots/delayed.png

# Interactive selection
gnome-screenshot -a -f screenshots/selection.png
```

## Final Checklist

Before committing screenshots:

- [ ] No personal/sensitive information
- [ ] Consistent terminal size
- [ ] Good image quality
- [ ] Optimized file size (<500KB per image)
- [ ] Descriptive filenames
- [ ] Referenced in documentation
- [ ] Demonstrates key features
- [ ] Shows different configurations

---

Need help? Open an issue on GitHub!
