# weibo-fresh-posts-skill

OpenClaw skill for Weibo monitoring with a strict timeline-first workflow:

- force click `最新微博`
- use post timestamp (not crawl timestamp)
- deduplicate by permalink
- write daily markdown digest

## Skill folder

This repo itself is the skill folder root and includes `SKILL.md`.

## Install locally

```bash
mkdir -p ~/.openclaw/workspace/skills
cp -R . ~/.openclaw/workspace/skills/weibo-fresh-posts
```

## Create recurring cron

```bash
./scripts/install_cron.sh 10m 20 weibo-fresh-posts
```

## Publish to ClawHub

```bash
clawhub login
clawhub publish "$PWD" \
  --slug weibo-fresh-posts \
  --name "Weibo Fresh Posts" \
  --version 0.1.0 \
  --tags latest,weibo,automation
```

Notes:

- On some `clawhub` CLI versions, `clawhub publish .` may incorrectly report `SKILL.md required`.
- Use `"$PWD"` (absolute path) to avoid that path-resolution issue.
