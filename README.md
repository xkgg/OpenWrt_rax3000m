# OpenWrt CMCC-RAX3000M 固件

跟随闭源主线更新。CMCC-RAX3000M极致版，更新频率：跟随源码更新而更新。
- 插件源码默认：kenzok8大神的

## RAX3000M 编译流程

编译入口为 `.github/workflows/CMCC-RAX3000M-Lede.yml`，已合并原
`OWRT-CORE.yml`。每天北京时间 04:00 自动编译，也可在 Actions 中手动运行。
手动运行时关闭 `publish` 可只生成构建产物，不发布 Release。

- 源码：`padavanonly/immortalwrt-mt798x-6.6`，分支 `openwrt-24.10-6.6`。
- 配置：`Config/RAX3000m.txt`，当前选择 `cmcc_rax3000m-emmc-mtk`。
- 管理地址：`192.168.10.1`，主机名：`CMCC-RAX3000m`。
- Wi-Fi 名称和登录密码沿用上游设置，流程不设置密码。
- 固件保留原始文件名，同时提供配置、源码提交信息和 `sha256sums`。
- 下载源码包使用缓存；下载或并行编译失败后单线程重试。
- Actions 固件和日志产物保留 7 天；本型号 Release 保留最近 6 个。
  清理仅匹配本流程的标签，不清理其他设备的 Release 或 Actions 历史。

完整编译需要在 GitHub 的 Ubuntu runner 上执行。合并流程不代表固件已通过
真实设备刷写验证；请选择与设备闪存类型匹配的镜像。

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
