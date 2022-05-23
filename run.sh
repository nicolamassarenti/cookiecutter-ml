#!/bin/bash
# -e: Exit immediately if a command exits with a non-zero status, -v: Print shell input lines as they are read.
set -evx

# Locations
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$(  dirname "${SCRIPT_DIR}" )"

# Building images

# Running docker-compose
docker-compose --env .env up
