#!/bin/bash
#=================================================
# Description: OpenWRT DIY script (Part 1)
# License: GPL v3
#=================================================

# Add third-party feeds
# cat >> feeds.conf.default <<EOF
# src-git helloworld https://github.com/fw876/helloworld
# src-git passwall https://github.com/xiaorouji/openwrt-passwall
# src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages
# EOF

# Update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# Add custom packages
# mkdir -p package/custom
# cp -r ../custom-package/* package/custom/ 2>/dev/null || true

echo "=== DIY Part 1 executed ==="
