FROM quay.io/jupyter/scipy-notebook:2026-10-05@sha256:2479174ae36ec84373f3c352cb6d5801382c0aa6642e739f04bea409f6cedae1

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
