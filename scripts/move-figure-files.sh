#!/usr/bin/env bash
# Quarto/pandoc always writes generated figure caches (e.g. rendered Mermaid
# diagrams) as "<source-file>_files/" next to the source .qmd. This moves
# those into images/ after each render so they don't clutter chapters/.
# Runs automatically as a Quarto project post-render hook.
set -euo pipefail
cd "$(dirname "$0")/.."

mkdir -p images

find . -maxdepth 2 -type d -name "*_files" -not -path "./images/*" | while read -r dir; do
  base="$(basename "$dir")"
  rsync -a --remove-source-files "$dir"/ "images/$base"/
  find "$dir" -type d -empty -delete
done
