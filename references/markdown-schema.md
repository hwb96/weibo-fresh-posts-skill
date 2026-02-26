# Markdown Schema

Daily file path:

- `~/weibo-digest/YYYY-MM-DD.md`

Header:

```markdown
# YYYY-MM-DD 微博关注摘要
| 发帖时间 | 发帖人 | 发帖内容 | 内容总结 | 原始链接 |
|---|---|---|---|---|
```

Row rules:

- `发帖时间`: parsed local post time, `YYYY-MM-DD HH:mm`.
- `发帖人`: display name only.
- `发帖内容`: original post body text in single-line plain text. No paraphrase, no rewriting, no summarizing.
- `内容总结`: <= 30 Chinese characters, neutral wording.
- `原始链接`: canonical permalink URL.

Content separation rule:

- `发帖内容` and `内容总结` must not be identical except when the original post body itself is very short.
- If extracted `发帖内容` is suspiciously short while post has longer body, reopen permalink and re-extract original text.

Sanitization:

- Replace line breaks with spaces.
- Escape table separator `|` as `\|`.
- Collapse repeated whitespace.

Deduplication:

- Full-file dedup on `原始链接`.
- If existing file uses `记录时间` header, upgrade to `发帖时间` while preserving rows.
