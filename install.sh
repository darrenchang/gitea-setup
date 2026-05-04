#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
    cp .env.sample .env
    sed -i "s/^GITEA_SECRET_KEY=.*/GITEA_SECRET_KEY=$(openssl rand -hex 32)/" .env
    echo ".env created — review and update credentials before continuing."
    echo "Re-run this script when ready."
    exit 0
fi

docker buildx bake
docker compose up -d

echo "Waiting for Gitea to be ready..."
until curl -sf --insecure https://localhost/api/healthz > /dev/null 2>&1; do
    sleep 2
done

set -a; source .env; set +a

if ! docker exec --user git gitea gitea admin user list | grep -q "${GITEA_ADMIN_USERNAME}"; then
    docker exec --user git gitea gitea admin user create \
        --admin \
        --username "${GITEA_ADMIN_USERNAME}" \
        --password "${GITEA_ADMIN_PASSWORD}" \
        --email "${GITEA_ADMIN_EMAIL}" \
        --must-change-password=false
    echo "Admin user '${GITEA_ADMIN_USERNAME}' created."
else
    echo "Admin user '${GITEA_ADMIN_USERNAME}' already exists."
fi
