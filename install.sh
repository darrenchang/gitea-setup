#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
    cp .env.sample .env
    echo ".env created from .env.sample — review it before continuing."
    echo "Edit .env and re-run this script."
    exit 0
fi

docker buildx bake
docker compose up -d
