FROM quay.io/jupyter/scipy-notebook:2026-10-23@sha256:987bbee395831e8a2b1ee4e989cb41122cc79099ca8052681dc2af5948d64f86

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
