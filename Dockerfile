FROM quay.io/jupyter/scipy-notebook:2026-11-16@sha256:9d1087eda0dadd6e98763b346fcaa34aa10153067092fac39380669265c3c268

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
