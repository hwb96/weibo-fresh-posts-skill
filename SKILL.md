---
name: weibo-fresh-posts
description: Use when monitoring followed Weibo accounts for new posts, extracting post timestamps from the 最新微博 timeline, and appending deduplicated rows to daily local markdown digests.
homepage: https://github.com/hwb96/weibo-fresh-posts-skill
metadata:
  {
    "openclaw":
      {
        "emoji": "🧭",
        "requires": { "config": ["browser.enabled"] },
      },
  }
---

# Weibo Fresh Posts

Monitor Weibo's 最新微博 timeline and keep a daily markdown digest that is timestamp-accurate, link-deduplicated, and easy to review.

## What this skill enforces

- Always switch to the left-nav `最新微博` timeline before collecting posts.
- Use the post's own publish time (not crawl time) in output rows.
- Parse relative and absolute time text into local `YYYY-MM-DD HH:mm`.
- Deduplicate strictly by original post link across the whole daily file.
- Keep scrolling while the oldest in-window post is still inside the capture window.

## References

- `references/workflow.md`: end-to-end extraction + parsing workflow.
- `references/markdown-schema.md`: markdown table schema and upgrade rules.
- `references/cron-setup.md`: how to bind this skill to a cron job.

## Quick start

1. Ensure browser profile has a logged-in Weibo session.
2. Read `references/workflow.md` and follow the extraction sequence.
3. Write rows to daily digest using `references/markdown-schema.md`.
4. Use `scripts/install_cron.sh` to create a 10-minute recurring cron task.

## Safety notes

- Do not store credentials in prompts, repo files, or markdown output.
- If time text cannot be parsed, skip the post and log skip count in summary.
- If 最新微博 entry cannot be activated after retries, return a clear failure message.
