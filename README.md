# OpenWrt / ImmortalWrt 自动化固件编译 (RAX3000M & Redmi AX6000)

基于 GitHub Actions（`ubuntu-24.04`）自动构建适用于联发科 MT798x 平台的 OpenWrt / ImmortalWrt 固件，每日自动同步上游源码与插件源并发布到 Releases。

- 主力源码：`padavanonly/immortalwrt-mt798x-6.6`（分支 `openwrt-24.10-6.6`）
- 插件源与工具链：`kenzok8/small` / `kenzok8/small-package`、`OpenClash`（`dev` 分支，预置 Smart/Meta 内核与 GEO 数据）、`Openwrt-Passwall`、FRP `0.70.1`（`small-package`）及 Go `1.26`（`kenzok8/golang`）

---

## 编译工作流总览

### 主力设备（每日自动构建）

两个主力工作流均在每天 **北京时间 04:00（UTC 20:00）** 从 `main` 自动触发，也支持在 Actions 中手动运行：

| 项目 | CMCC RAX3000M | Redmi AX6000 |
| :--- | :--- | :--- |
| **工作流文件** | `.github/workflows/CMCC-RAX3000M-Lede.yml` | `.github/workflows/redmiax6000.yml` |
| **配置文件** | `Config/RAX3000m.txt` (`cmcc_rax3000m-emmc-mtk`) | `Config/redmiax6000.txt` |
| **插件源** | `kenzok8/small` + `Scripts/Plugins.sh` | `kenzok8/small-package` + `Scripts/Plugins.sh` |
| **默认管理地址** | `192.168.10.1` | `192.168.31.1` |
| **默认主机名** | `CMCC-RAX3000m` | `redmi-ax6000` |
| **Wi-Fi / 登录密码** | 沿用上游默认设置（流程不修改密码） | Wi-Fi: `Redmi_5A21` / 登录密码沿用上游默认设置（未在脚本中修改） |
| **Release 保留策略** | 保留最近 3 天（仅清理本型号标签与运行记录） | 保留最近 3 个 Release，运行记录保留 3 天 |
| **产物与日志** | 固件与构建日志 Artifact 保留 7 天（失败也上传日志） | 构建日志与 `.config` Artifact 保留 7 天（失败也上传） |

> **手动触发说明**：`CMCC-RAX3000M-Lede.yml` 手动触发时提供 `publish` 开关，默认开启发布 Release；关闭后仅在 Actions 页面生成构建产物。

### 其他设备（仅手动触发）

仓库中还保留了以下设备的手动编译工作流，可在 GitHub Actions 页面按需触发：
- `AX6S-5.15`（`.github/workflows/AX6S-5.15.yml`）
- `K2P`（`.github/workflows/k2p.yml`）
- `newifi3-d2`（`.github/workflows/newifi3-d2.yml`）

---

## 主要预置插件与特性

- **网络代理与科学上网**：`luci-app-openclash`（已预置 arm64 `clash_smart` / `clash_meta` 内核及 `Country.mmdb`、`GeoSite.dat`、`GeoIP.dat`）、PassWall（RAX3000M）
- **内网穿透与域名解析**：`luci-app-frpc` / `luci-app-frps`（底层采用 `0.70.1` 新版）、`luci-app-ddns-go`
- **联发科专属加速与无线**：`luci-app-turboacc-mtk` / `luci-app-turboacc`、`luci-app-eqos-mtk`、`luci-app-mtwifi-cfg`、`luci-app-wrtbwmon`（RAX3000M）
- **网盘与磁盘管理**：`luci-app-openlist`（RAX3000M）/ `luci-app-alist`（Redmi AX6000）、`luci-app-diskman`（含 `btrfs-progs`、`lsblk`）
- **日常管理与美化**：`luci-app-ttyd`、`luci-app-upnp`、`luci-app-wol`、`luci-theme-argon` & `luci-app-argon-config`

---

## 使用与刷写说明

- 每次 Release 均保留固件原始文件名，并附带对应的 `.config` 配置文件；`RAX3000M` 同时附带 `source-info.txt` 与 `sha256sums` 校验文件，下载后请先校验完整性。
- 工作流使用缓存及“并行失败后单线程回退”机制保障编译稳定性；构建通过仅代表 CI 编译成功，不代表所有镜像均已过真机实测，刷机前请务必核对设备型号与闪存类型（如 eMMC / NAND）。

---

## 🌟 点赞支持者列表 (Stargazers)

> 感谢所有给本项目点 Star 的小伙伴！❤️  
> **快速直达**：[👉 点击直接打开 GitHub 官方 Stargazers 列表](https://github.com/xkgg/OpenWrt_rax3000m/stargazers)  
> *注：因 GitHub 官方改版限制，请确保在浏览器登录 GitHub 账号后再点击上方链接查看完整列表。*

| 用户头像 | 用户名 | 主页链接 | 点赞日期 |
| :---: | :--- | :--- | :---: |
| <img src="https://avatars.githubusercontent.com/Kylinink?s=40" width="40" height="40" style="border-radius:50%"/> | **Kylinink** | [@Kylinink](https://github.com/Kylinink) | 2025-03-03 |
| <img src="https://avatars.githubusercontent.com/youaokok?s=40" width="40" height="40" style="border-radius:50%"/> | **youaokok** | [@youaokok](https://github.com/youaokok) | 2025-07-15 |
| <img src="https://avatars.githubusercontent.com/AiPaozao?s=40" width="40" height="40" style="border-radius:50%"/> | **AiPaozao** | [@AiPaozao](https://github.com/AiPaozao) | 2026-05-27 |
| <img src="https://avatars.githubusercontent.com/xkgg?s=40" width="40" height="40" style="border-radius:50%"/> | **xkgg** | [@xkgg](https://github.com/xkgg) | 2026-10-01 |
| <img src="https://avatars.githubusercontent.com/wii-me?s=40" width="40" height="40" style="border-radius:50%"/> | **wii-me** | [@wii-me](https://github.com/wii-me) | 2026-10-26 |
| <img src="https://avatars.githubusercontent.com/Gang945?s=40" width="40" height="40" style="border-radius:50%"/> | **Gang945** | [@Gang945](https://github.com/Gang945) | 2026-11-19 |
| <img src="https://avatars.githubusercontent.com/cschengliang?s=40" width="40" height="40" style="border-radius:50%"/> | **cschengliang** | [@cschengliang](https://github.com/cschengliang) | 2026-11-20 |
