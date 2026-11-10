#!/bin/bash
# sync.sh: copy every Markdown page that https://www.usesequential.com/llms.txt lists into docs/, as published.
# The pages are public already; this repository only mirrors them so tools that index GitHub (Context7) can read them.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -f docs/*.md
list=$(mktemp)
trap 'rm -f "$list"' EXIT
curl -fsS https://www.usesequential.com/llms.txt -o "$list"
grep -oE 'https://www\.usesequential\.com/docs/[a-z0-9-]+\.md' "$list" | sort -u | while read -r u; do
  curl -fsS "$u" -o "docs/$(basename "$u")"
done
ls docs | wc -l
