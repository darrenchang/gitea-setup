variable "GITEA_VERSION" {
  default = "1.26.1"
}

variable "POSTGRES_VERSION" {
  default = "14"
}

variable "NGINX_VERSION" {
  default = "1.27"
}

variable "REGISTRY" {
  default = "localhost/gitea-serup"
}

group "default" {
  targets = ["gitea", "postgres", "web-server"]
}

target "gitea" {
  context    = "./gitea"
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/gitea:${GITEA_VERSION}",
    "${REGISTRY}/gitea:latest",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "postgres" {
  context    = "./postgres"
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/postgres:${POSTGRES_VERSION}",
    "${REGISTRY}/postgres:latest",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "web-server" {
  context    = "./web-server"
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/web-server:${NGINX_VERSION}",
    "${REGISTRY}/web-server:latest",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}
