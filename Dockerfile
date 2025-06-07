FROM python:3.13-slim-bullseye@sha256:de0e7494b82e073b7586bfb2b081428ca2c8d1db2f6a6c94bc2e4c9bd4e71276

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:4faec156e35a5f345d57804d8858c6ba1cf6352ce5f4bffc11b7fdebdef46a38 /uv /bin/uv

# Copy the application into the container
COPY . /app

# Install the application dependencies
WORKDIR /app

# Create a virtual environment first and then install the package
RUN uv venv
RUN . .venv/bin/activate && uv pip install --no-cache .

# Run the application
CMD ["/app/.venv/bin/uvicorn", "fastapi_template.main:app", "--host", "0.0.0.0", "--port", "8000"]
