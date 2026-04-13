# Database Migration Checklist

## Before Writing the Migration

- [ ] Understand the current schema: run `\d {table}` or equivalent
- [ ] Check if the table has > 1M rows (large table migrations need special care)
- [ ] Check for foreign keys that reference the table being altered
- [ ] Decide: additive change (safe) or destructive change (needs migration strategy)

## Writing the Migration

### Safe Operations (no downtime)
- ADD COLUMN with NULL default
- ADD INDEX CONCURRENTLY (Postgres) or without lock (MySQL 8+)
- CREATE TABLE

### Dangerous Operations (need strategy)
- DROP COLUMN — ensure no code references it first
- RENAME COLUMN — use a transition period (add new, copy, drop old)
- ADD NOT NULL constraint — backfill first, then add constraint
- ALTER COLUMN type — may lock table on large datasets

## Dry Run Procedure

1. **Backup**: take a snapshot or dump before any migration
2. **Run on local**: apply migration against local database with production-like data
3. **Run on staging**: apply migration against staging database
4. **Verify staging**: check that the application works correctly after migration
5. **Measure duration**: time the migration on staging to estimate production duration
6. **Check reversibility**: verify the rollback migration works on staging

## Executing in Production

1. Put application in maintenance mode (if migration is destructive)
2. Take production backup: `pg_dump` / `mysqldump` / snapshot
3. Run migration: `npm run migrate` / `go migrate up` / `alembic upgrade head`
4. Verify: check schema matches expected state
5. Run application health check
6. Remove maintenance mode

## Rollback Procedure

If migration fails or breaks the application:

1. **Stop the application** if errors are occurring
2. **Run rollback migration**: `npm run migrate:rollback` / `go migrate down`
3. **Verify rollback**: check schema reverted correctly
4. **Restart application** on previous code version
5. **Document**: what failed and why

## Decision Matrix

| Change Type | Rows < 100K | Rows 100K-10M | Rows > 10M |
|------------|-------------|---------------|------------|
| ADD COLUMN NULL | Direct | Direct | Direct |
| ADD COLUMN NOT NULL | Backfill + constraint | Batched backfill | Online migration tool |
| DROP COLUMN | Direct after code cleanup | Direct after code cleanup | Direct after code cleanup |
| ADD INDEX | Direct | CONCURRENTLY | CONCURRENTLY + monitor |
| ALTER TYPE | Direct | Test lock duration | Online migration tool |
