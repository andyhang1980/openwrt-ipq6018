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

# Fix bash package Makefile - Remove invalid dependency concatenation
echo "=== Fixing bash package Makefile ==="
if [ -f "feeds/packages/utils/bash/Makefile" ]; then
  # Replace the invalid 'libreadlinelibncursesw' with proper dependencies
  sed -i 's/libreadlinelibncursesw/readline ncursesw/g' feeds/packages/utils/bash/Makefile
  sed -i 's/ncursesw\/host/ncurses/g' feeds/packages/utils/bash/Makefile
  echo "✓ bash Makefile fixed"
else
  echo "✗ bash Makefile not found at feeds/packages/utils/bash/Makefile"
fi

# Add custom packages
# mkdir -p package/custom
# cp -r ../custom-package/* package/custom/ 2>/dev/null || true

echo "=== DIY Part 1 executed ==="
