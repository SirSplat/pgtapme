# GitHub Actions CI Design

**Date:** 2026-04-18
**Status:** Approved

## Overview

Two workflow files replace the existing `.github/workflows/ci.yml`. One runs a light pipeline on branch pushes; the other runs the full integration test suite on master pushes. The `dont-.github/` draft directory is deleted.

## File Structure

```
.github/workflows/
  branch.yml    ← light pipeline (lint, test, build)
  master.yml    ← full integration pipeline
```

## Triggers

**`branch.yml`** fires on push to any branch except `master`:
```yaml
on:
  push:
    branches-ignore:
      - master
```

**`master.yml`** fires on push to `master` only:
```yaml
on:
  push:
    branches:
      - master
```

No pull request triggers — avoids duplicate runs when a branch PR is open.

## Branch Pipeline (`branch.yml`)

Three jobs run in parallel on `ubuntu-latest`. Expected runtime: under 2 minutes.

| Job | Steps |
|-----|-------|
| `lint` | checkout → install ruff → `ruff check code/` |
| `test` | checkout → setup Python → install `app/requirements.txt` + pytest → `pytest code/tests/` |
| `build` | checkout → setup Docker Buildx → `docker compose build` |

## Master Pipeline (`master.yml`)

Single job `build-and-test` on `ubuntu-latest`, timeout 45 minutes.

| # | Step | Condition |
|---|------|-----------|
| 1 | Checkout repo | always |
| 2 | Setup Docker Buildx | always |
| 3 | Write `.pgpass` (double-quoted, variables expand correctly) | always |
| 4 | Prepare `code/pgtapme_generated_files/` directory | always |
| 5 | `docker compose build` | always |
| 6 | `docker compose up -d` | always |
| 7 | Wait for all services healthy/running (poll loop) | always |
| 8 | Deploy Sqitch `pgtapme` via `sqitch` container | always |
| 9 | Deploy Sqitch `fdw_source` via `sqitch_fdw_source` container | always |
| 10 | Generate pgTAP tests via `app` container | always |
| 11 | Run pg_prove via `pg_prove` container | always |
| 12 | Verify Sqitch `pgtapme` via `sqitch` container | always |
| 13 | Verify Sqitch `fdw_source` via `sqitch_fdw_source` container | always |
| 14 | Collect Docker logs | on failure |
| 15 | Upload logs artifact | on failure |
| 16 | Archive & upload generated pgTAP files | always |
| 17 | `docker compose down --volumes --remove-orphans` | always |

## Secrets & Environment

- `PGTAPME_DB_PASSWORD` — GitHub secret; falls back to `mysecretpassword` if unset (matches `docker-compose.yml` default)
- `PGTAPME_DB_USER` — hardcoded as `dbo` in env (matches existing convention)

## Bugs Fixed from Existing `ci.yml`

1. **Branch trigger** — was `main`, corrected to `master`
2. **`.pgpass` heredoc** — single-quoted heredoc (`<<'PGPASS'`) blocked variable expansion; replaced with correct expansion

## Files Changed

| Action | Path |
|--------|------|
| Delete | `.github/workflows/ci.yml` |
| Delete | `dont-.github/` (entire directory) |
| Create | `.github/workflows/branch.yml` |
| Create | `.github/workflows/master.yml` |
