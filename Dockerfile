FROM python:3.13-slim-bullseye@sha256:f0acec66ba3578f142b7efc6a3e5ce62a5f51639ea430df576f9249c7baf6ef2

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:563b73ab264117698521303e361fb781a0b421058661b4055750b6c822262d1e /uv /bin/uv

# Copy the application into the container
COPY . /app

# Install the application dependencies
WORKDIR /app

# Create a virtual environment first and then install the package
RUN uv venv
RUN . .venv/bin/activate && uv pip install --no-cache .

# Run the application
CMD ["/app/.venv/bin/uvicorn", "fastapi_template.main:app", "--host", "0.0.0.0", "--port", "8000"]
