#!/bin/bash

#删除冲突插件
rm -rf $(find ./feeds/luci/ -type d -regex ".*\(design\|openclash\).*")
#删除冲突argon插件附属inas

rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
#修改默认主题
#sed -i "s/luci-theme-bootstrap/luci-theme-$OWRT_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$OWRT_IP/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='$OWRT_NAME'/g" ./package/base-files/files/bin/config_generate
#修改默认wifi名称ssid为 旧版本修改
sed -i 's/ssid='.*'/ssid='$OWRT_wifi_ssid'/g' ./package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改默认wifi名称ssid为 hanwckf源码修改  ssid="ImmortalWrt-2.4G"
sed -i 's/ssid='.*'/ssid='$OWRT_wifi_ssid'/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
#修改WIFI地区
#sed -i "s/country='.*'/country='CN'/g" $WIFI_UC
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

#根据源码来修改
if [[ $OWRT_URL == *"lede"* ]] ; then
  #修改默认时间格式
  sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' $(find ./package/*/autocore/files/ -type f -name "index.htm")
fi

#8. 修复rust报错
MAKEFILE_PATH="openwrt/feeds/packages/lang/rust/Makefile"
sed -i 's|	--set=llvm.download-ci-llvm=true |	--set=llvm.download-ci-llvm=false |g' "$MAKEFILE_PATH"
