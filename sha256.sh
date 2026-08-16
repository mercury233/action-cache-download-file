#!/usr/bin/env bash

set -euo pipefail

if command -v sha256sum >/dev/null 2>&1; then
  output=$(sha256sum -)
  digest=${output%%[[:space:]]*}
elif command -v shasum >/dev/null 2>&1; then
  output=$(shasum -a 256 -)
  digest=${output%%[[:space:]]*}
elif command -v openssl >/dev/null 2>&1; then
  output=$(openssl dgst -sha256)
  digest=${output##*[[:space:]]}
else
  echo "No supported SHA256 tool found: expected sha256sum, shasum, or openssl" >&2
  exit 1
fi

digest=$(printf '%s' "$digest" | tr '[:upper:]' '[:lower:]')
if [[ ! "$digest" =~ ^[[:xdigit:]]{64}$ ]]; then
  printf 'Invalid SHA256 output: %s\n' "$output" >&2
  exit 1
fi

printf '%s\n' "$digest"
