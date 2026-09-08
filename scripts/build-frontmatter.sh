#!/usr/bin/env bash
# Converts frontmatter/*.qmd (pretoc pages) into a single LaTeX snippet
# that gets included before the table of contents via `include-before-body`.
# Runs automatically as a Quarto project pre-render hook.
set -euo pipefail
cd "$(dirname "$0")/.."

out="frontmatter/_frontmatter.tex"
: > "$out"

shopt -s nullglob
files=(frontmatter/[0-9]*.qmd)
shopt -u nullglob

first=1
for f in "${files[@]}"; do
  if [ "$first" -eq 0 ]; then
    printf '\n\\clearpage\n\n' >> "$out"
  fi
  first=0
  quarto pandoc "$f" -f markdown -t latex --top-level-division=chapter >> "$out"
done
