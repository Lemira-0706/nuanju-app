#!/bin/bash
# ============================================================
#  暖居收纳 · 一键部署到 GitHub Pages
#  用法：在本地终端 cd 到本目录，执行  bash deploy-to-github-pages.sh
#  前置：已安装 git 与 gh (https://cli.github.com/)，并已  gh auth login
# ============================================================
set -e
REPO_NAME="${REPO_NAME:-nuanju-storage}"
cd "$(dirname "$0")"

echo "==> 检查 gh 登录态"
gh auth status || { echo "请先执行 'gh auth login'（推荐浏览器登录）"; exit 1; }
GH_USER="$(gh api user | jq -r .login)"
echo "==> GitHub 账号：${GH_USER}   仓库名：${REPO_NAME}"

# 初始化 git（如尚未）
if [ ! -d .git ]; then git init -b main; fi
if [ ! -f .gitignore ]; then printf '*.zip\n__pycache__/\n' > .gitignore; fi

git add index.html .gitignore README.md deploy-to-github-pages.sh 2>/dev/null || git add index.html .gitignore
git diff --cached --quiet || \
  git -c user.name="${GH_USER}" -c user.email="${GH_USER}@users.noreply.github.com" \
      commit -m "feat: 暖居收纳 手机端适配优化版 初始部署"

echo "==> 创建 GitHub 仓库（已存在则跳过）"
gh repo create "${REPO_NAME}" --public \
  --description "暖居收纳 · 手机端适配版（GitHub Pages 托管）" \
  --source . --push 2>/dev/null || {
    git remote remove origin 2>/dev/null || true
    git remote add origin "https://github.com/${GH_USER}/${REPO_NAME}.git"
    git push -u origin main
}
git push -u origin main 2>/dev/null || true

echo "==> 开启 GitHub Pages（main 分支根目录）"
gh api -X POST "/repos/${GH_USER}/${REPO_NAME}/pages" \
  -f source='{"branch":"main","path":"/"}' >/dev/null 2>&1 || \
gh api -X PUT  "/repos/${GH_USER}/${REPO_NAME}/pages" \
  -f source='{"branch":"main","path":"/"}' >/dev/null

echo
echo "✅ 部署完成！"
echo "   仓库地址  : https://github.com/${GH_USER}/${REPO_NAME}"
echo "   Pages 地址: https://${GH_USER}.github.io/${REPO_NAME}/"
echo "   （首次开启 Pages 后约 30 秒内可访问；可在仓库 Settings → Pages 查看状态）"
