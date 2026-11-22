#!/usr/bin/env bash
set -euo pipefail
source scripts/deployment/env/00-config.sh
docker pull "$IMG"
docker image inspect --format '{{json .RepoDigests}}' "$IMG"
