# GitHub Actions CI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the broken CI workflow with two focused pipelines — a light branch pipeline (lint + pytest + docker build) and a full master pipeline (Docker stack + Sqitch deploy for both projects + pgTAP tests).

**Architecture:** Two separate workflow files under `.github/workflows/`. `branch.yml` runs three parallel jobs on every non-master push. `master.yml` runs a single sequential job on master push, reusing the proven health-check polling pattern from the original CI.

**Tech Stack:** GitHub Actions, Docker Compose, ruff (linting), pytest (unit tests), Sqitch (schema migrations), pg_prove (pgTAP integration tests), Python 3.11.

**Status: ✅ COMPLETE — both pipelines passing as of 2026-04-18**

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

- [x] **Step 1: Delete the old CI file and draft directory**
- [x] **Step 2: Verify removals**
- [x] **Step 3: Commit**

---

## Task 2: Create the branch (light) pipeline

**Files:**
- Create: `.github/workflows/branch.yml`

- [x] **Step 1: Create the workflow file**
- [x] **Step 2: Validate the YAML syntax**
- [x] **Step 3: Commit**

**Post-review fixes applied:**
- Added `actions/setup-python@v5` with Python 3.11 to lint job for consistency
- Added `apt-get update` before `libpq-dev` install
- Added `cache: "pip"` to test job's setup-python step
- Added top-level `permissions: contents: read`

---

## Task 3: Create the master (full) pipeline

**Files:**
- Create: `.github/workflows/master.yml`

- [x] **Step 1: Create the workflow file**
- [x] **Step 2: Validate the YAML syntax**
- [x] **Step 3: Commit**

**Post-review fixes applied:**
- Added top-level `permissions: contents: read`
- Added `concurrency: group: master-ci, cancel-in-progress: false`
- Removed dead `.pgpass` setup step (PGPASSWORD env var is the actual auth mechanism)
- Reverted `chmod 775` → `chmod 777` (container UID 1000 vs runner UID 1001 prevented writes)

---

## Task 4: Verify and push

- [x] **Step 1: Confirm final file state**
- [x] **Step 2: Branch CI passed** — lint (ruff), pytest, docker build all green
- [x] **Step 3: Master CI passed** — full Docker stack, dual Sqitch deploy, pgTAP tests, teardown all green

---

## Post-implementation lint fixes

Ruff caught 9 real bugs in the existing codebase during the first CI run:

| File | Rule | Fix |
|------|------|-----|
| `code/pgtapme.py:31` | F841 | `except Exception as e:` → `except Exception:` |
| `code/src/helpers.py:263` | F541 | `f"(0)"` → `"(0)"` |
| `code/src/module_types/acl.py:15,24` | F821 | `test_type` → `module_type` |
| `code/src/module_types/extension.py:8` | F401 | Remove unused `write_extension_schema_is` import |
| `code/src/module_types/index.py:14` | F401 | Remove unused `write_has_index` import |
| `code/src/writers/write_pgtap_tests.py:56,57,1545,1546` | F541 | Remove spurious `f` prefixes from string literals |
