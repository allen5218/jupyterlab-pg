FROM quay.io/jupyter/scipy-notebook:2026-10-12@sha256:8f8a5763d9a01e7f488eff8d9379654788e9cc08286dbcbc6bcda129c1b0edcd

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
