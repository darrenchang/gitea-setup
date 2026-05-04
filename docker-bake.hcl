variable "GITEA_VERSION" {
  default = "1.26.1"
}

variable "POSTGRES_VERSION" {
  default = "14"
}

variable "REGISTRY" {
  default = "localhost/gitea-serup"
}

group "default" {
  targets = ["gitea", "postgres"]
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
