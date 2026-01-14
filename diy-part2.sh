#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
#============================================================

# --- 1. 网络与主机名设置 ---

# 修改默认 IP 为 192.168.5.200
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 修改主机名为 R619ac
sed -i 's/OpenWrt/R619ac/g' package/base-files/files/bin/config_generate

# --- 2. 主题管理 ---

# 建议：将 git clone 移至 diy-part1.sh。
# 如果必须在此处下载，请创建一个独立的目录，避免依赖 package/lean 是否存在
mkdir -p package/custom
# 下载 OpenTomcat 主题
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/custom/luci-theme-opentomcat
# 下载 Edge 主题
git clone https://github.com/garypang13/luci-theme-edge.git package/custom/luci-theme-edge

# [重要] 设置默认主题
# 你下载了两个主题，必须指定一个作为默认（这里以 Edge 为例，如果想用 opentomcat 请自行替换名称）
# 逻辑：修改 luci 的 Makefile，把默认的 bootstrap 替换为 luci-theme-edge
sed -i 's/luci-theme-bootstrap/luci-theme-edge/g' feeds/luci/collections/luci/Makefile

# 移除原厂 argon 主题（如果存在），防止冲突
rm -rf package/lean/luci-theme-argon

# --- 3. 版本号与个性化 ---

# 修改版本号 (增加日期标识)
# 增加文件检查，防止非 Lede 源码导致报错
zzz_settings="package/lean/default-settings/files/zzz-default-settings"
if [ -f "$zzz_settings" ]; then
    sed -i "s/OpenWrt /Leopard build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" "$zzz_settings"
fi

# --- 4. 内核编译用户设置 (.config) ---
# 注意：此时 .config 可能尚未完全生成，追加设置是安全的

# 设置编译用户
sed -i '/CONFIG_KERNEL_BUILD_USER/d' .config
echo 'CONFIG_KERNEL_BUILD_USER="Leopard"' >> .config

# 设置编译域名
sed -i '/CONFIG_KERNEL_BUILD_DOMAIN/d' .config
echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >> .config
