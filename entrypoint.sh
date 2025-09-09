#!/usr/bin/env bash
set -euo pipefail

echo "PORT is: $PORT"

PORT="${PORT:-8080}"
exec ./App --hostname 0.0.0.0 --port "${PORT}"
