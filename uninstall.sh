#!/usr/bin/env bash
set -euo pipefail

read -rp "This will remove all containers, volumes, and images. Continue? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

docker compose down -v

docker rmi -f \
    localhost/gitea-serup/web-server:latest \
    localhost/gitea-serup/gitea:latest \
    localhost/gitea-serup/postgres:latest \
    2>/dev/null || true

echo "Uninstall complete."
