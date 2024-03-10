FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y zip && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install \
    --platform manylinux2014_x86_64 \
    --target=package \
    --implementation cp \
    --only-binary=:all: --upgrade \
    -r requirements.txt \
    -t /opt/python/

CMD cd /opt && zip -r9 /app/layer.zip .