# QA Checklist — [Task ID]

## Universal Checks (Apply to ALL tasks)

| ID | Check | Status | Evidence |
|----|-------|--------|----------|
| U-01 | Project compiles without errors | | |
| U-02 | All tests pass (100%) | | |
| U-03 | Zero regression in existing tests | | |
| U-04 | No TODO/FIXME in new code | | |
| U-05 | No hardcoded values that should be configured | | |
| U-06 | Adequate error handling (no silenced errors) | | |
| U-07 | Correct imports (no unused imports) | | |
| U-08 | Task acceptance criteria covered | | |
| U-09 | New tests are meaningful (not cosmetic) | | |
| U-10 | Changes respect the task's scope | | |

## Conditional Checks (Apply based on change type)

### If there are database schema/migration changes
| ID | Check | Status | Evidence |
|----|-------|--------|----------|
| C-SQL-01 | Backward compatibility preserved | | |
| C-SQL-02 | Indexes recreated if needed | | |
| C-SQL-03 | Existing data preserved | | |

### If there are new code files
| ID | Check | Status | Evidence |
|----|-------|--------|----------|
| C-NEW-01 | Interfaces/contracts satisfied | | |
| C-NEW-02 | Test coverage exists for new code | | |
| C-NEW-03 | Correct package/module | | |

### If there are API endpoint changes
| ID | Check | Status | Evidence |
|----|-------|--------|----------|
| C-API-01 | Backward compatibility preserved | | |
| C-API-02 | Input validation present | | |
| C-API-03 | Error responses with correct codes | | |
| C-API-04 | API documentation updated | | |

### If there are test changes
| ID | Check | Status | Evidence |
|----|-------|--------|----------|
| C-TEST-01 | AAA structure (Arrange-Act-Assert) | | |
| C-TEST-02 | Independent tests (no shared state) | | |
| C-TEST-03 | Negative scenarios covered | | |
| C-TEST-04 | Mocks only at boundaries, not on internal logic | | |

## Finding Severity

| Level | Meaning | Blocks PASS? |
|-------|---------|--------------|
| **blocker** | Fails universal check or acceptance criterion | **Yes** |
| **major** | Fails conditional check, significant risk | No (but report) |
| **minor** | Style or documentation improvement | No |

## Verdict

- **PASS:** All universal checks passed, zero blockers.
- **FAIL:** Any blocker found OR acceptance criterion without evidence.
