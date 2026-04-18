# GitHub Actions CI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the broken CI workflow with two focused pipelines — a light branch pipeline (lint + pytest + docker build) and a full master pipeline (Docker stack + Sqitch deploy for both projects + pgTAP tests).

**Architecture:** Two separate workflow files under `.github/workflows/`. `branch.yml` runs three parallel jobs on every non-master push. `master.yml` runs a single sequential job on master push, reusing the proven health-check polling pattern from the original CI.

**Tech Stack:** GitHub Actions, Docker Compose, ruff (linting), pytest (unit tests), Sqitch (schema migrations), pg_prove (pgTAP integration tests), Python 3.11.

---

## File Map

| Action | Path |
|--------|------|
| Delete | `.github/workflows/ci.yml` |
| Delete | `dont-.github/` (entire directory) |
| Create | `.github/workflows/branch.yml` |
| Create | `.github/workflows/master.yml` |

---

## Task 1: Remove old workflow files

**Files:**
- Delete: `.github/workflows/ci.yml`
- Delete: `dont-.github/` (entire directory)

- [ ] **Step 1: Delete the old CI file and draft directory**

```bash
git rm .github/workflows/ci.yml
git rm -r dont-.github/
```

- [ ] **Step 2: Verify removals**

```bash
git status
```

Expected output includes:
```
deleted:    .github/workflows/ci.yml
deleted:    dont-.github/workflows/test.yml
```

- [ ] **Step 3: Commit**

```bash
git commit -m "chore: remove old CI workflow and dont-.github draft"
```

---

## Task 2: Create the branch (light) pipeline

**Files:**
- Create: `.github/workflows/branch.yml`

- [ ] **Step 1: Create the workflow file**

Create `.github/workflows/branch.yml` with this exact content:

```yaml
name: Branch CI

on:
  push:
    branches-ignore:
      - master

jobs:
  lint:
    name: Lint (ruff)
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install ruff
        run: pip install ruff

      - name: Run ruff
        run: ruff check code/

  test:
    name: Unit tests (pytest)
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.11"

      - name: Install system dependencies
        run: sudo apt-get install -y libpq-dev

      - name: Install dependencies
        run: pip install -r app/requirements.txt pytest

      - name: Run pytest
        run: pytest code/tests/

  build:
    name: Docker build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Build containers
        run: docker compose build
```

- [ ] **Step 2: Validate the YAML syntax**

```bash
python -c "import yaml; yaml.safe_load(open('.github/workflows/branch.yml'))" && echo "YAML valid"
```

Expected: `YAML valid`

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/branch.yml
git commit -m "ci: add branch pipeline (lint, pytest, docker build)"
```

---

## Task 3: Create the master (full) pipeline

**Files:**
- Create: `.github/workflows/master.yml`

- [ ] **Step 1: Create the workflow file**

Create `.github/workflows/master.yml` with this exact content:

```yaml
name: Master CI

on:
  push:
    branches:
      - master

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    timeout-minutes: 45
    env:
      PGTAPME_DB_USER: dbo
      PGTAPME_DB_PASSWORD: ${{ secrets.PGTAPME_DB_PASSWORD || 'mysecretpassword' }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Configure pgpass credentials
        run: |
          printf '*:*:*:%s:%s\n' "${PGTAPME_DB_USER}" "${PGTAPME_DB_PASSWORD}" > .pgpass
          chmod 600 .pgpass

      - name: Prepare generated tests directory
        run: |
          mkdir -p code/pgtapme_generated_files
          chmod 777 code/pgtapme_generated_files

      - name: Build containers
        run: docker compose build

      - name: Start services
        run: docker compose up -d

      - name: Wait for Docker services to become ready
        run: |
          set -euo pipefail
          services=$(docker compose ps --services)
          for attempt in $(seq 1 30); do
            not_ready=0
            echo "--- compose status (attempt ${attempt}) ---"
            for service in $services; do
              container_id=$(docker compose ps -q "$service")
              if [ -z "$container_id" ]; then
                echo "Service $service container ID not available yet"
                not_ready=1
                continue
              fi
              status=$(docker inspect -f '{{.State.Status}}' "$container_id")
              health=$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{end}}' "$container_id")
              if [ -n "$health" ]; then
                echo "Service $service state=$status health=$health"
                if [ "$health" != "healthy" ]; then
                  not_ready=1
                fi
              else
                echo "Service $service state=$status"
                if [ "$status" != "running" ]; then
                  not_ready=1
                fi
              fi
            done
            if [ "$not_ready" -eq 0 ]; then
              exit 0
            fi
            sleep 10
          done
          echo "Services did not become ready in time"
          docker compose ps
          exit 1

      - name: Deploy Sqitch pgtapme
        run: docker compose exec -T sqitch env PGUSER=${PGTAPME_DB_USER} PGPASSWORD=${PGTAPME_DB_PASSWORD} sqitch deploy pgtapme --chdir /mnt/migrations

      - name: Deploy Sqitch fdw_source
        run: docker compose exec -T sqitch_fdw_source env PGUSER=${PGTAPME_DB_USER} PGPASSWORD=${PGTAPME_DB_PASSWORD} sqitch deploy fdw_source --chdir /mnt/migrations

      - name: Generate pgTAP tests
        run: docker compose exec -T app python pgtapme.py --db-name pgtapme --db-user ${PGTAPME_DB_USER} --db-password ${PGTAPME_DB_PASSWORD} --db-host pgtapme_db --db-port 5432

      - name: Run pgTAP suite with pg_prove
        run: docker compose exec -T pg_prove env PGPASSWORD=${PGTAPME_DB_PASSWORD} pg_prove --ext .sql -r -U ${PGTAPME_DB_USER} -h pgtapme_db -d pgtapme -p 5432 -f /mnt/tests/pgtapme

      - name: Verify Sqitch pgtapme
        run: docker compose exec -T sqitch env PGUSER=${PGTAPME_DB_USER} PGPASSWORD=${PGTAPME_DB_PASSWORD} sqitch verify pgtapme --chdir /mnt/migrations

      - name: Verify Sqitch fdw_source
        run: docker compose exec -T sqitch_fdw_source env PGUSER=${PGTAPME_DB_USER} PGPASSWORD=${PGTAPME_DB_PASSWORD} sqitch verify fdw_source --chdir /mnt/migrations

      - name: Collect Docker logs
        if: failure()
        run: docker compose logs --no-color > docker-compose.log

      - name: Upload Docker logs
        if: failure()
        uses: actions/upload-artifact@v4
        with:
          name: docker-compose-logs
          path: docker-compose.log

      - name: Archive generated pgTAP files
        if: always()
        run: |
          if [ -d code/pgtapme_generated_files ] && [ "$(find code/pgtapme_generated_files -type f | head -n1)" ]; then
            tar -czf pgtapme-generated-tests.tar.gz -C code pgtapme_generated_files
          else
            echo "No generated pgTAP files found; uploading empty archive"
            tar -czf pgtapme-generated-tests.tar.gz --files-from /dev/null
          fi

      - name: Upload generated pgTAP files
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: pgtapme-generated-tests
          path: pgtapme-generated-tests.tar.gz
          if-no-files-found: warn

      - name: Tear down services
        if: always()
        run: docker compose down --volumes --remove-orphans
```

- [ ] **Step 2: Validate the YAML syntax**

```bash
python -c "import yaml; yaml.safe_load(open('.github/workflows/master.yml'))" && echo "YAML valid"
```

Expected: `YAML valid`

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/master.yml
git commit -m "ci: add master pipeline (full Docker stack + dual Sqitch deploy + pgTAP)"
```

---

## Task 4: Verify and push

- [ ] **Step 1: Confirm final file state**

```bash
ls .github/workflows/
```

Expected:
```
branch.yml
master.yml
```

```bash
ls dont-.github/ 2>/dev/null && echo "STILL EXISTS - recheck Task 1" || echo "dont-.github removed OK"
```

Expected: `dont-.github removed OK`

- [ ] **Step 2: Push to a feature branch to trigger branch.yml**

```bash
git push origin master
```

Watch the GitHub Actions tab — `Branch CI` should NOT fire (this is master). Then create or push to any non-master branch and confirm `Branch CI` fires with all three jobs (lint, test, build) running in parallel.

- [ ] **Step 3: Push to master to trigger master.yml**

After merging your feature branch (or pushing directly to master):

```bash
git push origin master
```

Watch the GitHub Actions tab — `Master CI` should fire. The job completes in under 45 minutes with all steps green.
