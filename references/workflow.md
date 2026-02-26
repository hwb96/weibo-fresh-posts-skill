# Workflow

## 1) Open Weibo and force 最新微博 timeline

1. Open `https://weibo.com` with browser tool options: `profile=openclaw`, `target=host`.
2. Take a snapshot and locate the left-nav entry labeled `最新微博`.
3. Click `最新微博`.
4. Verify success:
   - URL contains `/mygroups?gid=`.
   - Left navigation still includes `最新微博`.
5. If verification fails, retry up to 3 times.

## 2) Extract candidate post cards

From visible timeline cards, extract:

- Author name
- Post text original body (plain text, no paraphrase)
- Original permalink URL
- Post time text (examples: `刚刚`, `8分钟前`, `3小时前`, `今天 09:12`, `02-26 17:30`, `2026-02-26 17:30`)

Skip cards without permalink URL or parseable post time.

### Post text quality rule (critical)

- `发帖内容` must be original post body text, not a summary sentence.
- If a card is truncated (`展开`), open the permalink detail and extract full body text first.
- Only use visible card text when full text cannot be loaded; in that case keep as much original text as available.

## 3) Parse post time to local datetime

Output format: `YYYY-MM-DD HH:mm`.

Rules:

- `刚刚` => current local minute
- `N分钟前` => now - N minutes
- `N小时前` => now - N hours
- `今天 HH:mm` => today local date + HH:mm
- `MM-DD HH:mm` => current year + MM-DD + HH:mm (local timezone)
- `YYYY-MM-DD HH:mm` => direct local datetime

## 4) Capture window and scroll strategy

Default interval is 10 minutes; use a 20-minute capture window.

- Minimum 3 scroll rounds.
- Maximum 8 scroll rounds.
- After each round, extract newly appeared cards.
- Continue scrolling while oldest matched post is still within 20 minutes.
- Stop when 2 consecutive rounds yield no in-window new posts.

## 5) Record and report

Write only deduplicated rows (by permalink).
Return:

- Added row count
- Output file path
- Earliest and latest post times among newly added rows
- Count of skipped cards due to missing/invalid time
