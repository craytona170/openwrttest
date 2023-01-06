#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
sed -i 's/ssid=OpenWrt/ssid=WiFi_R4AGv2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i "s/OpenWrt /HI build $(TZ=UTC-8 date "+%Y.%m.%d") @ R4AGV2 /g" package/lean/default-settings/files/zzz-default-settings
sed -i '/uci commit system/i\uci set system.@system[0].hostname='XiaoMiRouter'' package/lean/default-settings/files/zzz-default-settings
sed -i 's/encryption=none/encryption=sae-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set wireless.default_radio${devidx}.encryption=sae-mixed/a\set wireless.default_radio${devidx}.key=19991014' package/kernel/mac80211/files/lib/wifi/mac80211.sh
rm -rf package/lean/luci-theme-bootstrap
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
curl -fsSL https://raw.githubusercontent.com/craytona170/openwrttest/main/banner > package/base-files/files/etc/banner
sed -i "/exit 0/i\sed -i '/coremark/d' /etc/crontabs/root" "${FIN_PATH}"
