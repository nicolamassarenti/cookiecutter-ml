########################################################################################################################
# Base ################################################################################################################
########################################################################################################################
{% if cookiecutter.use_nvidia_docker == 'yes' %}
FROM nvidia/cuda:11.6.0-runtime-ubuntu20.04 as base
{% else %}
FROM python:3.10.4-slim-buster as base
{% endif %}

# Disable bytecode generation
ENV PYTHONDONTWRITEBYTECODE 1

# Send the Python output directly to the terminal without first buffering it
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Install project dependencies
RUN apt update && \
    apt upgrade -y

########################################################################################################################
# Build ################################################################################################################
########################################################################################################################
FROM base as build

# Install poetry
RUN pip install poetry

# Install project dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry config virtualenvs.in-project true && \
    poetry install  --no-dev \
                    --no-interaction \
                    --no-ansi

# Copy sources
COPY {{cookiecutter.project_slug}} {{cookiecutter.project_slug}}

# Build package
RUN poetry build

# Install package
RUN ./.venv/bin/pip install --no-deps dist/*.gz

########################################################################################################################
# Release ##############################################################################################################
########################################################################################################################
FROM base as release

# Copy installed packages from build stage
COPY --from=build /app/.venv /app/.venv

# Fix path
ENV PATH="/app/.venv/bin:$PATH"

# Exposing PORT
EXPOSE 8080

# Run the program
CMD ["uvicorn", "{{cookiecutter.project_slug}}.__webserver__:app", "--host", "0.0.0.0", "--port", "8080"]
