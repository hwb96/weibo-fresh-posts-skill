#!/usr/bin/env bash
set -euo pipefail

INTERVAL="${1:-10m}"
WINDOW="${2:-20}"
NAME="${3:-weibo-fresh-posts}"

PROMPT_DIR="${HOME}/.openclaw/prompts"
PROMPT_FILE="${PROMPT_DIR}/${NAME}.prompt"

mkdir -p "${PROMPT_DIR}"

cat > "${PROMPT_FILE}" <<PROMPT
Use weibo-fresh-posts skill.
Requirements:
1) Open https://weibo.com with browser profile=openclaw target=host.
2) Click left-nav 最新微博 before extraction.
3) Parse post time text to local YYYY-MM-DD HH:mm; never use crawl time.
4) 发帖内容必须是原始贴文正文，不允许改写成总结句；内容总结单独写在“内容总结”列。
5) If card body is truncated, open permalink detail and extract full original body text first.
6) Capture window: recent ${WINDOW} minutes.
7) Append deduplicated rows by 原始链接 to ~/weibo-digest/YYYY-MM-DD.md.
PROMPT

openclaw cron add \
  --name "${NAME}" \
  --every "${INTERVAL}" \
  --session isolated \
  --message "$(cat "${PROMPT_FILE}")" \
  --timeout-seconds 240 \
  --no-deliver

echo "Created cron job '${NAME}' with interval ${INTERVAL}."
echo "Prompt file: ${PROMPT_FILE}"
