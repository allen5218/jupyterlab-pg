FROM quay.io/jupyter/scipy-notebook:2026-09-07@sha256:9591aef57604dbf50a1ea7903196eec760ac493db3fe0d866f8312ba872e119d

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        tmux \
    && rm -rf /var/lib/apt/lists/*
USER ${NB_UID}

RUN pip install --no-cache-dir \
    "psycopg[binary]" \
    sqlalchemy \
    jupysql \
    pgcli
