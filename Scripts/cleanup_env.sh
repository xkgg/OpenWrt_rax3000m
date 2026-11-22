#!/usr/bin/env bash
# 清理系统内置与编译 OpenWrt 无关的软件环境，释放磁盘空间
set -euo pipefail

echo "===> 正在深度清理系统内置无用软件及运行时缓存..."

# 1. 移除无用的大型预装 SDK 与开发工具包目录（释放约 20GB+）
sudo rm -rf \
  /usr/share/dotnet \
  /usr/local/lib/android \
  /opt/ghc \
  /opt/hostedtoolcache \
  /usr/local/share/powershell \
  /usr/local/share/vcpkg \
  /usr/local/share/chromium \
  /usr/local/.ghcup \
  /usr/share/swift \
  /etc/mysql \
  /etc/php

# 2. 清理 Docker 镜像
if command -v docker >/dev/null 2>&1; then
  docker image prune --all --force || true
fi

# 3. 卸载编译 OpenWrt 完全用不到的软件包
sudo apt-get remove --purge -y \
  azure-cli \
  google-chrome-stable \
  firefox \
  microsoft-edge-stable \
  mysql-server \
  mysql-client \
  postgresql \
  php* \
  openjdk* \
  ant* || true

# 4. 自动清理孤立无用依赖与包缓存
sudo apt-get autoremove --purge -y
sudo apt-get clean

echo "===> 系统清理完成！当前磁盘空间如下："
df -h
