-- Optimisation SQL for Company Activity Pipeline
-- ================================================
-- Goal: Reduce runtime and improve data quality for daily aggregation

-- 1. Filter recent data only to reduce scan size
-- 2. Exclude NULL company_id or date to prevent miscounts
-- 3. Use aggregation over properly indexed/partitioned columns

SELECT
    company_id,
    date,
    SUM(events) AS events
FROM fact_events
WHERE date >= DATEADD(day, -90, CURRENT_DATE)  -- Only last 90 days
  AND company_id IS NOT NULL
  AND date IS NOT NULL
GROUP BY company_id, date;

-- Notes:
-- 1. Consider adding indexes or partitioning on (company_id, date)
-- 2. For long-term performance, pre-aggregate daily summaries in a materialized view
-- 3. Late-arriving data may need incremental updates
