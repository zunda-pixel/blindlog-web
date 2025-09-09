#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-8080}"
exec ./App --hostname 0.0.0.0 --port "${PORT}"
