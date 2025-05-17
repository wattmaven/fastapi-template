FROM python:3.13-slim-bullseye@sha256:9e3f9243e06fd68eb9519074b49878eda20ad39a855fac51aaffb741de20726e

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest@sha256:69e13c7ae3a7649cbe0c912ca8afe00656966622a13f2db2d7eef7bb01118ccf /uv /bin/uv

# Copy the application into the container
COPY . /app

# Install the application dependencies
WORKDIR /app

# Create a virtual environment first and then install the package
RUN uv venv
RUN . .venv/bin/activate && uv pip install --no-cache .

# Run the application
CMD ["/app/.venv/bin/uvicorn", "fastapi_template.main:app", "--host", "0.0.0.0", "--port", "8000"]
