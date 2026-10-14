#!/bin/bash
set -eo pipefail

download() {
  curl --fail --location --retry 5 --retry-delay 3 --connect-timeout 30 --max-time 600 --output "$1" "$2"
}

#Design Theme
#git clone --depth=1 --single-branch --branch $(echo $OWRT_URL | grep -iq "lede" && echo "main" || echo "js") https://github.com/gngpp/luci-theme-design.git
#git clone --depth=1 --single-branch https://github.com/gngpp/luci-app-design-config.git
#sed -i 's/dark/light/g' luci-app-design-config/root/etc/config/design
#Argon Theme
#git clone --depth=1 --single-branch --branch $(echo $OWRT_URL | grep -iq "lede" && echo "18.06" || echo "master") https://github.com/jerrykuku/luci-theme-argon.git
#git clone --depth=1 --single-branch --branch $(echo $OWRT_URL | grep -iq "lede" && echo "18.06" || echo "master") https://github.com/jerrykuku/luci-app-argon-config.git
#Linkease
git clone --depth=1 --single-branch https://github.com/linkease/istore.git
git clone --depth=1 --single-branch https://github.com/linkease/nas-packages.git
git clone --depth=1 --single-branch https://github.com/linkease/nas-packages-luci.git
#Open Clash
git clone --depth=1 --single-branch --branch "dev" https://github.com/vernesong/OpenClash.git
#Pass Wall
git clone --depth=1 --single-branch --branch "main" https://github.com/xiaorouji/openwrt-passwall.git ./pw_luci
git clone --depth=1 --single-branch --branch "main" https://github.com/xiaorouji/openwrt-passwall-packages.git ./pw_packages
#FRP (kenzok8/small-package新版0.70.1，替换原仓库旧版；仅CMCC-RAX3000M)
if [[ $OWRT_TARGET == "RAX3000m" ]]; then
  git clone --depth=1 --filter=blob:none --sparse https://github.com/kenzok8/small-package.git ./spkg-frp
  git -C ./spkg-frp sparse-checkout set frp
  cp -r ./spkg-frp/frp ./frp
  rm -rf ./spkg-frp
fi

#预置OpenClash内核和GEO数据
export CORE_smart=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/smart/clash-linux
export CORE_MATE=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/meta/clash-linux

export CORE_TYPE=$(echo $OWRT_TARGET | grep -Eiq "64|86" && echo "amd64" || echo "arm64")

export GEO_MMDB=https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
export GEO_SITE=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
export GEO_IP=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat

cd ./OpenClash/luci-app-openclash/root/etc/openclash

download ./Country.mmdb "$GEO_MMDB"
download ./GeoSite.dat "$GEO_SITE"
download ./GeoIP.dat "$GEO_IP"

mkdir -p ./core
cd ./core

download ./smart.tar.gz "${CORE_smart}-${CORE_TYPE}.tar.gz"
tar -zxf ./smart.tar.gz
mv ./clash ./clash_smart

download ./meta.tar.gz "${CORE_MATE}-${CORE_TYPE}.tar.gz"
tar -zxf ./meta.tar.gz
mv ./clash ./clash_meta



chmod +x ./clash* ; rm -rf ./*.gz
