#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# 注意：kenzok8 的库包含了大量插件，可能会覆盖官方源。
# 如果只想用里面的某些插件，建议下载后删除冲突的包。

# 1. 克隆 kenzok8 的软件包库
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
# git clone https://github.com/kenzok8/small.git package/small

# 【关键修复步骤】
# 删除第三方库中的 smartdns，解决 "rust-bindgen" 缺失和版本冲突问题
# 让编译系统使用 OpenWrt/Lede 自带的 smartdns
# rm -rf package/openwrt-packages/smartdns

# 建议：删除其他可能的高风险冲突包（可选，视情况而定）
# rm -rf package/openwrt-packages/luci-app-smartdns
# rm -rf package/openwrt-packages/v2ray-geodata

# 2. 其他插件
git clone https://github.com/open-mesh-mirror/batman-adv.git package/batman-adv

# 3. 增加 luci-app-unblockneteasemusic，来源 immortalwrt
git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic

# 4. 增加 filebrowser
git clone https://github.com/immortalwrt/openwrt-filebrowser.git package/luci-app-filebrowser

# 5. 修改 feeds 源 (原脚本注释掉的部分，如果不需要可以保持现状)
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
