# gitea-serup

Self-hosted [Gitea](https://gitea.com) instance using Docker Compose, with a PostgreSQL backend.

## Services

| Service | Image | Port |
|---------|-------|------|
| Gitea | `localhost/gitea-serup/gitea:1.26.1` | 3000 (web), 222 (SSH) |
| PostgreSQL | `localhost/gitea-serup/postgres:14` | — |

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

# Build and push to registry
docker buildx bake --push

# Override versions
GITEA_VERSION=1.27.0 docker buildx bake
```

## Run

```bash
docker compose up -d
```

Gitea will be available at [http://localhost:3000](http://localhost:3000).

## Configuration

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
