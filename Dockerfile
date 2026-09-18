FROM quay.io/jupyter/scipy-notebook:2026-09-18@sha256:5468d3aa14437e53bfe2fe29e3b5dd241c67052adba82f9ae5f84423b1056229

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
