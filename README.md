# Osama-Fathi-company_activity_optimisation-

## Overview
This repo contains proposed optimisations and communication updates for the Company Activity dashboard pipeline.

The current pipeline takes 3+ hours, and analysts sometimes see mismatches between the dashboard and raw API data. This repo contains:

1. SQL optimisations to improve performance.
2. Known risks and suggested fixes.
3. A Slack-style update for stakeholders.

## Files

- `optimisation.sql`: Optimised SQL query with comments.
- `slack_update.md`: Draft Slack message to analytics team.

---

## Optimisation Priorities (30-minute focus)

| Rank | Optimisation | Description | Expected Impact |
|------|--------------|-------------|----------------|
| 1    | Indexing / Partitioning | Add index or partition on `company_id` and `date` | Faster GROUP BY aggregation, reduces full table scans |
| 2    | Filter Recent Data | Only process last 90 days | Cuts down processing time, avoids unnecessary historical scans |
| 3    | Pre-aggregate / Materialized View | Create daily pre-aggregated table | Reduces computation for daily job, easier incremental updates |

---

## SQL Risks & Fixes

| Risk / Flaw | Problem | Suggested Fix |
|-------------|---------|---------------|
| Missing filters / time boundaries | Aggregates all historical data → slow, memory-heavy | Add `WHERE date >= …` clause to limit scope |
| Duplicate or NULL values | Miscounts, mismatches with raw API | Exclude NULLs and deduplicate before aggregation |
| Late-arriving data | Daily summaries may be inaccurate | Use incremental load or staging table with `last_modified_date` |
