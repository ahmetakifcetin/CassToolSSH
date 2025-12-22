
#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASSED=0
FAILED=0

test_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}: $2"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAIL${NC}: $2"
        ((FAILED++))
    fi
}

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              casstool Test Suite                                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}[1/10]${NC} Testing script syntax..."
bash -n ../install.sh
test_result $? "Installation script syntax"

echo -e "${YELLOW}[2/10]${NC} Testing installation..."
if [ ! -f /opt/casstool/motd.sh ]; then
    echo "Installing casstool for testing..."
    sudo ../install.sh <<< $'y\n' > /dev/null 2>&1
fi
test -f /opt/casstool/motd.sh
test_result $? "casstool installation"

echo -e "${YELLOW}[3/10]${NC} Testing configuration file..."
test -f /etc/casstool.conf
test_result $? "Configuration file exists"

echo -e "${YELLOW}[4/10]${NC} Testing configuration validity..."
source /etc/casstool.conf 2>/dev/null
test_result $? "Configuration file is valid"

echo -e "${YELLOW}[5/10]${NC} Testing MOTD script execution..."
/opt/casstool/motd.sh > /tmp/motd_output.txt 2>&1
test_result $? "MOTD script executes without errors"

echo -e "${YELLOW}[6/10]${NC} Testing MOTD output content..."
grep -q "casstool" /tmp/motd_output.txt
test_result $? "MOTD contains expected content"

echo -e "${YELLOW}[7/10]${NC} Testing customization script..."
test -x /opt/casstool/customize.sh
test_result $? "Customization script is executable"

echo -e "${YELLOW}[8/10]${NC} Testing uninstall script..."
test -x /opt/casstool/uninstall.sh
test_result $? "Uninstall script is executable"

echo -e "${YELLOW}[9/10]${NC} Testing color themes..."
ALL_THEMES="blue green purple cyan red yellow"
THEME_TEST_PASSED=true
for theme in $ALL_THEMES; do
    sudo sed -i "s/COLOR_THEME=.*/COLOR_THEME=\"$theme\"/" /etc/casstool.conf
    /opt/casstool/motd.sh > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        THEME_TEST_PASSED=false
        break
    fi
done
[ "$THEME_TEST_PASSED" = true ]
test_result $? "All color themes work"

echo -e "${YELLOW}[10/10]${NC} Testing ASCII styles..."
ALL_STYLES="casstool minimal blocks simple"
STYLE_TEST_PASSED=true
for style in $ALL_STYLES; do
    sudo sed -i "s/ASCII_STYLE=.*/ASCII_STYLE=\"$style\"/" /etc/casstool.conf
    /opt/casstool/motd.sh > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        STYLE_TEST_PASSED=false
        break
    fi
done
[ "$STYLE_TEST_PASSED" = true ]
test_result $? "All ASCII styles work"

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                      Test Results                                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GREEN}Passed:${NC} $PASSED"
echo -e "  ${RED}Failed:${NC} $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed!${NC}"
    exit 1
fi
