#!/bin/bash

# -e: Exit immediately if a command exits with a non-zero status, -v: Print shell input lines as they are read.
set -evx

# Setting venv name for Jupyterlab as parent directory name
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$(  dirname "$(  dirname "${SCRIPT_DIR}" )" )"

# References
TAG="latest"
PROJECT_NAME={{cookiecutter.project_slug}}
CONTEXT="${ROOT_DIR}"
DOCKERFILE_LOCATION="${ROOT_DIR}"/docker/containers/Dockerfile

# Building image
docker build  -f "${DOCKERFILE_LOCATION}" \
              --rm \
              -t "${PROJECT_NAME}":${TAG} \
              "${CONTEXT}"
