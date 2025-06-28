FROM python:3.13-slim-bullseye@sha256:5b9fc0d8ef79cfb5f300e61cb516e0c668067bbf77646762c38c94107e230dbc

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:2363bcbe837b6ca8fda6512a4a68de3bc752035797c159ca0ecb68c27a0d0368 /uv /bin/uv

# Copy the application into the container
COPY . /app

# Install the application dependencies
WORKDIR /app

# Create a virtual environment first and then install the package
RUN uv venv
RUN . .venv/bin/activate && uv pip install --no-cache .

# Run the application
CMD ["/app/.venv/bin/uvicorn", "fastapi_template.main:app", "--host", "0.0.0.0", "--port", "8000"]
