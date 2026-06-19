FROM quay.io/jupyter/scipy-notebook:2026-06-15@sha256:635835fcda6bfdb342b3ac7042e0a38a6b7764857d4b40406d2b89eb07cd19e6

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
