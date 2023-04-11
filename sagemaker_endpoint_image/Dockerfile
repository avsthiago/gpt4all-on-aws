# Stage 1: Install build tools and build dependencies
FROM python:3.8-slim-buster AS build

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        build-essential \
        cmake \
        libboost-all-dev \
        libomp-dev \
        libpq-dev \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target=/build/python-packages

# Stage 2: Copy installed packages from the build stage and add application code
FROM python:3.8-slim-buster

WORKDIR /app

COPY --from=build /build/python-packages /usr/local/lib/python3.8/site-packages

COPY app.py .

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
