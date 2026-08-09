#!/bin/bash
#=================================================
# Description: OpenWRT DIY script (Part 2)
# License: GPL v3
#=================================================

# 1. Customize default settings
# Default LAN IP
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 2. Set hostname
# sed -i 's/OpenWrt/JDC-AX1800Pro/g' package/base-files/files/bin/config_generate

# 3. Enable LuCI by default
# sed -i 's/# CONFIG_PACKAGE_luci is not set/CONFIG_PACKAGE_luci=y/' .config

# 4. Add custom packages to .config
cat >> .config <<EOF
# LuCI Applications
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-base=y
CONFIG_PACKAGE_luci-compat=y
CONFIG_PACKAGE_luci-lib-ipkg=y
CONFIG_PACKAGE_luci-app-firewall=y
CONFIG_PACKAGE_luci-i18n-base-en=y
CONFIG_PACKAGE_luci-i18n-firewall-en=y

# LuCI Theme
CONFIG_PACKAGE_luci-theme-bootstrap=y

# Network
CONFIG_PACKAGE_dnsmasq-full=y
CONFIG_PACKAGE_ip-full=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_wget-ssl=y

# Utilities
CONFIG_PACKAGE_bash=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_usbutils=y
CONFIG_PACKAGE_pciutils=y
EOF

# 5. Apply patches
# cd target/linux/qualcommax
# git apply ../../../patches/*.patch
# cd ../../..

echo "=== DIY Part 2 executed ==="
