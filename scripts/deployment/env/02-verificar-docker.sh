#!/usr/bin/env bash
set -euo pipefail
docker version
docker info --format 'Motor {{.ServerVersion}}, CPU {{.NCPU}}, RAM {{.MemTotal}} bytes'
docker run --rm hello-world
