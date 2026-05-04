# gitea-serup

Self-hosted [Gitea](https://gitea.com) instance using Docker Compose, with a PostgreSQL backend and Nginx reverse proxy.

## Services

| Service | Image | Port |
|---------|-------|------|
| Nginx (web-server) | `localhost/gitea-serup/web-server:1.27` | 80 (HTTP→redirect), 443 (HTTPS) |
| Gitea | `localhost/gitea-serup/gitea:1.26.1` | 222 (SSH) |
| PostgreSQL | `localhost/gitea-serup/postgres:14` | — |

Gitea's web UI is only accessible through Nginx — port 3000 is not exposed directly.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Buildx](https://docs.docker.com/buildx/install/) (for building images)

## Build Images

```bash
# Build all images
docker buildx bake

# Build a single image
docker buildx bake gitea
docker buildx bake postgres
docker buildx bake web-server

# Build and push to registry
docker buildx bake --push

# Override versions
GITEA_VERSION=1.27.0 docker buildx bake
```

## Setup

Copy the sample env file and edit it before starting the stack:

```bash
cp .env.sample .env
```

| Variable | Default | Description |
|----------|---------|-------------|
| `USER_UID` | `1000` | UID for the Gitea process |
| `USER_GID` | `1000` | GID for the Gitea process |
| `DB_USER` | `gitea` | Database user (shared by Gitea and PostgreSQL) |
| `DB_PASSWORD` | `gitea` | Database password (shared by Gitea and PostgreSQL) |
| `DB_NAME` | `gitea` | Database name (shared by Gitea and PostgreSQL) |

> **Note:** Change `DB_PASSWORD` before deploying to production.

## Run

```bash
docker compose up -d
```

Gitea will be available at [https://localhost](https://localhost). HTTP on port 80 redirects to HTTPS automatically.

> **Note:** The SSL certificate is self-signed. Your browser will show a security warning — this is expected for local deployments. Update `web-server/certs/openssl.cnf` with your domain details before building.

## Data Persistence

| Volume | Mount | Purpose |
|--------|-------|---------|
| `gitea_data` | `/data` | Gitea repositories and config |
| `postgres_data` | `/var/lib/postgresql/data` | PostgreSQL data |

## Stop

```bash
docker compose down
```

To also remove volumes:

```bash
docker compose down -v
```
