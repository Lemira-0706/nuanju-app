# 暖居收纳 · 手机端适配版

一款治愈系、手机优先（Mobile-First）的**家庭物品收纳管理 Web 应用**。数据仅存于本机浏览器（localStorage），支持 Excel 备份/迁移、条码扫码识别、DeepSeek AI 小兜助手、5 套主题切换。

## ✨ 功能亮点

- 🏠 **场景式收纳**：按房间/家具组织物品，未归位自动进入「📥 待整理」。
- 📦 **物品清单**：搜索 + 多维筛选（房间/分类/标签/状态），多图（最多 6 张，自动压缩）、单价、购买/到期/开封日期、单件日均成本自动计算。
- 📊 **资产统计**：按分类实时汇总资产分布（送人/出售/耗尽/破损不计入资产）。
- ⏰ **到期提醒**：临期/已过期提醒，支持标已读、删除、浏览器桌面通知。
- 🏷️ **标签 / 分类 / 字段自定义**：全局标签 chip 多选，分类增删，卡片显示字段开关。
- 📷 **条码扫码**：ZXing 识别商品条码自动填入名称/备注。
- 🧸 **小兜 AI**：接入 DeepSeek（deepseek-chat，支持 vision），分析资产、识别物品照片辅助录入。
- 📊 **Excel 导入/导出**：导出含「物品清单/房间/标签」三工作表的 `.xlsx` 备份；导入支持模板或备份整库替换。
- 🎨 **5 套主题**：樱粉/鹅黄/天蓝/淡绿/浅紫，实时切换持久保存。
- 📱 **手机优先 UI**：底部 5-Tab 导航、底部上滑动画弹窗、安全区适配、触控反馈；≥760px 自动恢复桌面侧栏布局。

## 🚀 部署到 GitHub Pages（免费静态托管）

本项目为纯静态单页应用（仅 `index.html`），可一键部署到 GitHub Pages。

### 方式 A：一键脚本（推荐，需本地已装 git + [gh](https://cli.github.com/)）

```bash
# 1. 首次使用：登录 GitHub（按提示选浏览器/Token 登录）
gh auth login

# 2. 在本目录执行部署脚本
bash deploy-to-github-pages.sh
```

脚本会：初始化 git → 创建公开仓库 `nuanju-storage` → 推送 `main` 分支 → 开启 GitHub Pages。
执行完即可通过 `https://<你的用户名>.github.io/nuanju-storage/` 访问。

> 可通过环境变量指定仓库名：`REPO_NAME=my-home-storage bash deploy-to-github-pages.sh`

### 方式 B：手动操作（无需 gh）

1. 在 https://github.com/new 新建一个**公开**仓库（如 `nuanju-storage`），**不要**勾选初始化 README。
2. 在本目录依次执行：
   ```bash
   git init -b main
   git add index.html README.md deploy-to-github-pages.sh .gitignore
   git commit -m "feat: 暖居收纳 手机端适配优化版 初始部署"
   git remote add origin https://github.com/<你的用户名>/nuanju-storage.git
   git push -u origin main
   ```
3. 仓库页面 → **Settings → Pages** → Branch 选 `main`、目录选 `/ (root)` → **Save**。
4. 等待约 30 秒，访问 `https://<你的用户名>.github.io/nuanju-storage/`。

## 🔑 关于 AI 功能

小兜 AI 使用 [DeepSeek 开放平台](https://platform.deepseek.com/) 的 API Key（`sk-` 开头）。Key 仅保存在你本机浏览器 localStorage，所有请求由本机直连 DeepSeek，服务端不留存。在应用内点击「🧸 小兜 AI → 设置 Key」粘贴即可。

## 📱 使用提示

- 建议用手机浏览器访问 Pages 地址后，通过「添加到主屏幕」获得类原生 App 体验。
- 数据保存在当前浏览器，换机/换浏览器时请先用侧栏「⬇️ 导出 Excel」备份，再到新设备「⬆️ 导入 Excel」恢复。

## 📄 License

MIT
