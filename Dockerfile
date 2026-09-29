FROM quay.io/jupyter/scipy-notebook:2026-09-29@sha256:1220239dc7ad223ebab9f28ae6e44f1b5861f21145f449dc7b1773b6e27a6c11

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
