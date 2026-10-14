#!/bin/bash

#删除冲突插件
find ./feeds/luci/ -type d \( -name '*design*' -o -name '*openclash*' \) -prune -exec rm -rf -- {} +
#删除冲突argon插件附属inas

rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
#CMCC-RAX3000M: 删除原仓库旧版frp(0.51.3)，改用kenzok8/small-package新版(由Plugins.sh添加)
if [[ $OWRT_TARGET == "RAX3000m" ]]; then
  rm -rf feeds/packages/net/frp
fi
#修改默认主题
#sed -i "s/luci-theme-bootstrap/luci-theme-$OWRT_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$OWRT_IP/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='$OWRT_NAME'/g" ./package/base-files/files/bin/config_generate
#修改默认wifi名称ssid为 旧版本修改
#修改默认wifi名称ssid为 hanwckf源码修改  ssid="ImmortalWrt-2.4G"
# Preserve upstream SSIDs unless a caller explicitly supplies a custom value.
if [[ -n ${OWRT_wifi_ssid:-} ]]; then
  ssid_escaped=$(printf '%s' "$OWRT_wifi_ssid" | sed 's/[\\&|]/\\&/g')
  for wifi_script in ./package/kernel/mac80211/files/lib/wifi/mac80211.sh ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh; do
    if [[ -f "$wifi_script" ]]; then
      sed -i -E "s|ssid=('[^']*'|\"[^\"]*\")|ssid=\"$ssid_escaped\"|g" "$wifi_script"
    fi
  done
fi
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


