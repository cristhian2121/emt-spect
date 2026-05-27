#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: save_spect_doc.sh <feature name>" >&2
  exit 2
fi

feature_name="$*"

kebab_case() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/-+/-/g; s/^-//; s/-$//'
}

slug="$(kebab_case "$feature_name")"
if [[ -z "$slug" ]]; then
  slug="spect-document"
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
skill_dir="$(cd -- "$script_dir/.." && pwd)"
output_dir="doc"
output_path="$output_dir/$slug.md"

body="$(cat)"
if [[ -z "${body//[[:space:]]/}" ]]; then
  body="$(cat "$skill_dir/assets/spect-template.md")"
  today="$(date +%Y-%m-%d)"
  body="${body//'{{ title }}'/$feature_name}"
  body="${body//'[FEATURE NAME]'/$feature_name}"
  body="${body//'[DATE]'/$today}"
  body="${body//\$ARGUMENTS/$feature_name}"
fi

mkdir -p "$output_dir"
printf '%s\n' "$body" > "$output_path"
printf '%s\n' "$PWD/$output_path"