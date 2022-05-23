#!/bin/bash

# -e: Exit immediately if a command exits with a non-zero status, -v: Print shell input lines as they are read.
set -evx

# Setting venv name for Jupyterlab as parent directory name
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$(  dirname "$(  dirname "${SCRIPT_DIR}" )" )"

# References
TAG="latest"
PROJECT_NAME={{cookiecutter.project_slug}}

# Running image
{%- if cookiecutter.use_nvidia_docker == 'yes' -%}

docker run  -p 8080:8080 \
            --gpus all \
            --runtime nvidia \
            -e NVIDIA_DRIVER_CAPABILITIES=all \
            ${PROJECT_NAME}:${TAG}
{%- else -%}
docker run  -p 8080:8080 \
            ${PROJECT_NAME}:${TAG}
{%- endif %}
