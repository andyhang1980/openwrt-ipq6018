# OpenWRT for JDCloud AX1800 Pro (IPQ6018)

GitHub Actions 自动编译 OpenWRT 固件，适用于京东云 AX1800 Pro 路由器。

## 硬件规格

| 参数 | 值 |
|------|-----|
| SoC | Qualcomm IPQ6018 (4x Cortex-A53, 1.8GHz) |
| RAM | 512MB / 1GB |
| Flash | 128MB NAND |
| WiFi | QCA6018 (2.4G+5G, 802.11ax) + QCN9000 |
| Ethernet | 5口千兆 (NSS加速) |
| USB | 2x USB3.0 |
| LED | 状态红/绿 |

## 使用方法

### 方法一：Fork 后自动编译

1. Fork 本仓库
2. 修改 `.config` 文件自定义配置
3. 推送代码触发自动编译
4. 在 Actions 页面查看编译进度
5. 编译完成后在 Releases 下载固件

### 方法二：手动触发编译

1. 访问 Actions → Build OpenWRT
2. 点击 "Run workflow"
3. 选择编译源：
   - `openwrt` - 官方 OpenWRT (推荐)
   - `qsdk` - Qualcomm QSDK (含 NSS 支持)
4. 可选择是否开启 SSH 调试
5. 等待编译完成

### 方法三：直接下载 Release

1. 访问 [Releases](../../releases) 页面
2. 下载最新的 `OpenWRT-JDCloud-AX1800Pro-*.zip`
3. 解压得到 `*-sysupgrade.bin` 文件
4. 按照下方刷机步骤操作

## 刷机步骤

### 从原厂固件刷入

1. **备份原厂配置**
   - 进入原厂后台 → 系统管理 → 备份与恢复
   - 导出配置文件和校准数据

2. **进入刷机页面**
   - 原厂后台 → 系统管理 → 固件升级

3. **上传固件**
   - 选择 `*-sysupgrade.bin` 文件
   - 点击"升级"

4. **等待重启**
   - 约 3-5 分钟完成
   - LED 指示灯恢复正常

5. **首次登录**
   - 地址: `192.168.1.1` (默认)
   - 用户名: `root`
   - 密码: 无 (首次登录设置密码)

### 从 Breed 刷入

1. 进入 Breed 控制台 (开机按住 Reset)
2. 固件管理 → 选择固件文件
3. 选择 `*-sysupgrade.bin` 刷入

### 从 SSH 刷入

```bash
# 上传固件到路由器
scp openwrt-*-sysupgrade.bin root@192.168.1.1:/tmp/

# SSH 登录后执行
sysupgrade -n /tmp/openwrt-*-sysupgrade.bin
```

## 恢复原厂固件

1. 从京东云官网下载原厂固件
2. 通过 Web 界面刷入
3. 或使用 Breed 恢复

## 自定义配置

### 修改默认 IP

编辑 `diy-part2.sh`:
```bash
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
```

### 添加插件

编辑 `.config` 文件，添加:
```
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-openvpn=y
CONFIG_PACKAGE_luci-app-wireguard=y
```

### 添加第三方源

编辑 `diy-part1.sh`:
```bash
cat >> feeds.conf.default <<EOF
src-git helloworld https://github.com/fw876/helloworld
src-git passwall https://github.com/xiaorouji/openwrt-passwall
EOF
```

## 编译说明

### 环境要求

- Ubuntu 22.04 LTS
- GitHub Actions 免费额度
- 约 2-3 小时编译时间

### 本地编译

```bash
# 安装依赖
sudo apt-get update
sudo apt-get install -y build-essential flex bison g++ gawk gcc-multilib g++-multilib \
  gettext git libncurses5-dev libssl-dev python3-setuptools rsync swig unzip zlib1g-dev

# 克隆仓库
git clone https://github.com/YOUR_USERNAME/openwrt-ipq6018.git
cd openwrt-ipq6018

# 下载源码
./scripts/feeds update -a
./scripts/feeds install -a

# 配置
cp .config .config.bak
make menuconfig

# 编译
make -j$(nproc)
```

### 编译产物

编译完成后在 `openwrt/bin/targets/` 目录下:
- `*-factory.bin` - 原厂刷机包
- `*-sysupgrade.bin` - Sysupgrade 刷机包
- `*-squashfs.bin` - SquashFS 格式

## 常见问题

### Q: 刷机后无法开机?

A: 可能原因:
1. 固件不匹配 - 确认设备型号
2. 分区表错误 - 检查 flash 布局
3. WiFi 校准数据丢失 - 保留 ART 分区

### Q: WiFi 信号弱?

A: 可能需要:
1. 保留原厂 ART 分区
2. 使用 `iw reg set CN` 设置区域码
3. 检查 `iw phy0 info` 确认识别

### Q: 如何查看编译日志?

A: 
1. GitHub Actions → 点击编译任务 → Logs
2. 或在 Actions 页面下载 Artifacts 中的日志

### Q: NSS 加速不工作?

A: NSS 需要:
1. 对应版本的 NSS 固件
2. 内核模块 nss-dp, qca-nss-drv
3. 检查 `dmesg | grep nss`

## 相关资源

- [OpenWRT IPQ60xx 支持](https://openwrt.org/docs/guide-developer/adding_new_device)
- [社区 JDCloud AX1800 Pro 项目](https://github.com/TRICKSDOWN/openwrt-jdc-ax1800pro)
- [不死 U-Boot](https://github.com/KunYi/uboot-ipq60xx-build)
- [Qualcomm QSDK](https://wiki.codelinaro.org/en/clo/qsdk/overview)

## 致谢

- [OpenWRT](https://openwrt.org/)
- [QWRT](https://github.com/QWRT)
- [Qualcomm QSDK](https://source.codeaurora.org/external/qsdk/)
- JDCloud AX1800 Pro 社区

## License

GPL v3
