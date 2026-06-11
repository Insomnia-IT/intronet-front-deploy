#!/bin/bash
set -euo pipefail

REPO="https://github.com/Insomnia-IT/intronet-front"
BRANCH="develop"
ENV_FILE=".env"

# Получаем последний SHA ветки
GITHUB_SHA=$(git ls-remote "$REPO" "refs/heads/$BRANCH" | awk '{print $1}')

echo "Remote SHA: $GITHUB_SHA"

if [ -z "$GITHUB_SHA" ]; then
  echo "ERROR: failed to fetch SHA"
  exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "ERROR: .env not found"
  exit 1
fi

# Берём текущий SHA строго по ключу
CURRENT=$(grep '^GITHUB_SHA=' "$ENV_FILE" | cut -d '=' -f2- || true)

echo "Current SHA: ${CURRENT:-<none>}"

if [ "$CURRENT" = "$GITHUB_SHA" ]; then
  echo "no changes"
  exit 0
fi

# Безопасное обновление через temp файл
TMP_FILE=$(mktemp)

awk -v sha="$GITHUB_SHA" '
BEGIN { updated=0 }
{
  if ($0 ~ /^GITHUB_SHA=/) {
    print "GITHUB_SHA=" sha
    updated=1
  } else {
    print $0
  }
}
END {
  if (updated == 0) {
    print "GITHUB_SHA=" sha
  }
}
' "$ENV_FILE" > "$TMP_FILE"

mv "$TMP_FILE" "$ENV_FILE"

echo "Updated .env"

docker compose up -d
