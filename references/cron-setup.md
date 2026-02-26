# Cron Setup

This skill does not define schedule semantics itself.
Scheduling is handled by OpenClaw cron.

## Recommended setup

1. Keep a prompt template in your home directory.
2. Create an isolated cron job that runs every 10 minutes.
3. Use a 20-minute capture window in extraction logic for overlap.

## Example

```bash
openclaw cron add \
  --name "weibo-fresh-posts" \
  --every 10m \
  --session isolated \
  --message "Use weibo-fresh-posts skill to collect 最新微博 posts and append digest rows." \
  --timeout-seconds 240 \
  --no-deliver
```
