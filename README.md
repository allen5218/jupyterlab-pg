# jupyterlab-pg

Customized Jupyter Lab image for personal homelab use. Based on
[`quay.io/jupyter/scipy-notebook`](https://quay.io/repository/jupyter/scipy-notebook)
with PostgreSQL client tools pre-installed.

Built for deployment behind Cloudflare Tunnel via Portainer stack.

## What's included

- **Base**: `quay.io/jupyter/scipy-notebook` — Python + scipy stack on Miniforge / conda-forge
- **System**: `postgresql-client` (`psql`, `pg_dump`, …)
- **Python**:
  - `psycopg[binary]` — PostgreSQL driver (v3)
  - `sqlalchemy` — ORM / Core
  - `jupysql` — `%sql` and `%%sql` cell magic
  - `pgcli` — better interactive PG client (autocomplete, highlighting)

## Image

```
ghcr.io/USERNAME/jupyterlab-pg:latest
```

Tags produced by CI:

| Tag             | When                          |
| --------------- | ----------------------------- |
| `latest`        | head of `main`                |
| `YYYY-MM-DD`    | daily snapshot of `main`      |
| `<git-sha>`     | exact commit                  |
| `v*`            | manual semver release         |

Pin to a date tag in production; `latest` is for quick testing only.

## Usage

Minimal `docker-compose.yml`:

```yaml
services:
  jupyterlab:
    image: ghcr.io/USERNAME/jupyterlab-pg:2026-05-21
    container_name: jupyterlab
    restart: unless-stopped
    environment:
      - JUPYTER_TOKEN=${JUPYTER_TOKEN}
    volumes:
      - jupyter_data:/home/jovyan/work
    command:
      - start-notebook.py
      - --ServerApp.root_dir=/home/jovyan/work

volumes:
  jupyter_data:
```

Token in the env var doubles as login password on Jupyter's auth screen.

For Cloudflare Tunnel integration, add a `cloudflared` service in the same
stack and point the public hostname at `http://jupyterlab:8888`.

## Inside the notebook

```python
%load_ext sql
%sql postgresql+psycopg://user:pass@host/db

result = %sql SELECT * FROM users LIMIT 10
df = result.DataFrame()
```

Open a terminal in JupyterLab for `pgcli` / `psql` access.

## Build

CI auto-builds on push to `main` that touches `Dockerfile` or the workflow.
See [`.github/workflows/build.yml`](.github/workflows/build.yml).

Local build:

```bash
docker build -t jupyterlab-pg:dev .
```

## Updates

Dependabot watches the base image weekly and opens PRs when a new
`scipy-notebook` tag is released. Merge → CI builds → bump tag in Portainer.

## Notes for future me

- GHCR package must be set to **public** in package settings; default is private even when the repo is public.
- `GITHUB_TOKEN` needs `packages: write` permission (already set in workflow).
- This image runs as `jovyan` (UID 1000). Volume permissions matter.
- Kernels live in `/opt/conda/share/jupyter/kernels`; install extra ones via
  `mamba install` or `pip install` then `python -m ipykernel install --user`.

## License

Personal use. Base image is BSD-3-Clause.
