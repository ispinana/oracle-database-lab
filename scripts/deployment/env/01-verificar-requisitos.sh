#!/usr/bin/env bash
set -euo pipefail
cat /etc/os-release
uname -rm
free -h
nproc
df -h .
for tool in git gh curl wget unzip zip tree rsync ncdu jq htop lsof ss dig ping tmux vim nano shellcheck; do command -v "$tool"; done
git branch --show-current
git rev-parse --show-toplevel
