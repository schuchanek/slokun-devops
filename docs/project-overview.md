# Slökun project overview

This repository is the infrastructure and automation layer for the Slökun platform. It coordinates the local Docker stack and deployment preparation. The product itself is split across three GitHub repositories.

## Repositories

- Backend: `schuchanek/slokun-backend`
  - branch: `schuchanek-nestjs-backend-mvp`
  - purpose: NestJS API, auth, venues, reviews, events
- Frontend: `schuchanek/slokun-frontend`
  - branch: `schuchanek-flutter-mvp`
  - purpose: Flutter web/mobile app UI and client logic
- DevOps: `schuchanek/slokun-devops`
  - branch: `schuchanek-infrastructure-setup`
  - purpose: Docker stack, CI, deployment prep, automation

## Why the project is split

The application is intentionally separated into independent projects so that:
- backend, frontend and infrastructure can evolve separately
- GitHub workflows are easier to reason about
- each team or contributor can work in one repo without hiding the whole stack
- the project remains reviewable and traceable

## Working rules

1. Keep each repo on a named feature branch.
2. Commit after each logical milestone.
3. Push before a handoff or review.
4. Keep documentation in the repo, not only in chat.
5. Do not store secrets in source-controlled files.
6. Prefer GitHub branch state over a local chat discussion as the source of truth.

## Local development order

1. Infrastructure: start the stack with Docker Compose
2. Backend: verify API endpoints and Swagger
3. Frontend: connect to the backend contract
4. Deployment: prepare Hetzner and domain routing

## Current project status

- MVP structure exists in all three repositories
- GitHub workflow files are in place
- backend and frontend repos have their own README files
- each repo is ready for continued work without losing context

## Execution checklist for the next contributor

- Open the backend repo and run its local setup
- Open the frontend repo and run Flutter web app locally
- Open devops repo and validate `docker compose config`
- verify API contract between frontend and backend
- only then move to domain and Hetzner deployment

## Important notes

- The GitHub Actions workflows are intentionally limited to the active branches to avoid notification spam.
- Domain and Hetzner deployment remain a later production phase.
- Keep secrets in environment variables or external secret managers, not in the repository.
