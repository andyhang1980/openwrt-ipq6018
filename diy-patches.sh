#!/bin/bash
#=================================================
# Description: DIY patches and customization script
# License: GPL v3
#=================================================

# 1. Add third-party feeds (if needed)
# cat >> feeds.conf.default <<EOF
# src-git helloworld https://github.com/fw876/helloworld
# src-git passwall https://github.com/xiaorouji/openwrt-passwall
# src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages
# EOF

# 2. Update feeds
# ./scripts/feeds update -a
# ./scripts/feeds install -a

# 3. Apply custom patches
# Example: patch a package
# cd package/boot/uboot-ipq40xx
# git apply ../../custom/uboot.patch
# cd ../../..

# 4. Customize default settings
# 默认LAN IP
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 5. Add custom packages to .config
# cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-ssr-plus=y
# CONFIG_PACKAGE_luci-app-passwall=y
# CONFIG_PACKAGE_luci-theme-bootstrap=y
# EOF

echo "DIY script executed successfully!"
