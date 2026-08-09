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

# 4. Custom packages - ONLY add packages NOT already in main .config
cat >> .config <<EOF

# Additional LuCI Applications
CONFIG_PACKAGE_luci-app-nlbwmon=y
CONFIG_PACKAGE_luci-app-wol=y
CONFIG_PACKAGE_luci-app-upnp=y

# Additional Network Tools
CONFIG_PACKAGE_mtr=y
CONFIG_PACKAGE_bind-dig=y

# Additional Utilities  
CONFIG_PACKAGE_screen=y
CONFIG_PACKAGE_tmux=y
CONFIG_PACKAGE_git=y
EOF

# 5. Apply patches (if any)
# cd target/linux/qualcommax
# git apply ../../../patches/*.patch
# cd ../../..

echo "=== DIY Part 2 executed ==="
