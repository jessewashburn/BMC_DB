-- ===========================================================
-- Baltimore Metal Crafters Database (Postgres)
-- Showcase Queries adapted for Postgres
-- ===========================================================

-- 1. JOBS DUE SOON (Next 7 days)
SELECT j.job_id, c.name AS customer, j.due_date, j.status
FROM job j
JOIN customer c ON c.customer_id = j.customer_id
WHERE j.status IN ('Planned','InProgress')
  AND j.due_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '7 days')
ORDER BY j.due_date;

-- 2. MATERIAL SHORTAGES (Below reorder level)
SELECT material_id, name, category, stock_quantity, reorder_level,
       (reorder_level - stock_quantity) AS shortage_amount
FROM material
WHERE stock_quantity <= reorder_level
ORDER BY shortage_amount DESC;

-- 3. EMPLOYEE WORKLOAD SUMMARY
SELECT e.employee_id, e.name, e.role, SUM(w.hours_worked) AS total_hours
FROM employee e
JOIN worklog w ON w.employee_id = e.employee_id
GROUP BY e.employee_id, e.name, e.role
ORDER BY total_hours DESC;

-- 4. REVENUE REPORT (Monthly)
SELECT 
    EXTRACT(YEAR FROM i.invoice_date) AS year,
    EXTRACT(MONTH FROM i.invoice_date) AS month,
    COUNT(*) AS invoices_count,
    SUM(i.total_amount) AS total_revenue
FROM invoice i
WHERE i.paid = TRUE
GROUP BY EXTRACT(YEAR FROM i.invoice_date), EXTRACT(MONTH FROM i.invoice_date)
ORDER BY year DESC, month DESC;

-- 5. REPEAT CUSTOMERS
SELECT c.customer_id, c.name, COUNT(j.job_id) AS job_count,
       COALESCE(SUM(i.total_amount), 0) AS total_value
FROM customer c
JOIN job j ON c.customer_id = j.customer_id
LEFT JOIN invoice i ON j.job_id = i.job_id
GROUP BY c.customer_id, c.name
HAVING COUNT(j.job_id) > 1
ORDER BY job_count DESC, total_value DESC;

-- 6. ACTIVE PROJECTS STATUS
SELECT j.job_id, c.name AS customer, j.description, j.status,
       j.start_date, j.due_date,
       (j.due_date - CURRENT_DATE) AS days_until_due
FROM job j
JOIN customer c ON j.customer_id = c.customer_id
WHERE j.status IN ('Planned', 'InProgress')
ORDER BY j.due_date;

-- 7. PENDING QUOTES
SELECT q.quote_id, c.name AS customer, q.date_created, q.total_estimate,
       (CURRENT_DATE - q.date_created) AS days_pending
FROM quote q
JOIN customer c ON q.customer_id = c.customer_id
WHERE q.approved = FALSE
ORDER BY q.date_created;

-- 8. OUTSTANDING INVOICES (Aging Report)
SELECT i.invoice_id, c.name AS customer, j.description AS job,
       i.invoice_date, i.total_amount,
       (CURRENT_DATE - i.invoice_date) AS days_outstanding
FROM invoice i
JOIN job j ON i.job_id = j.job_id
JOIN customer c ON j.customer_id = c.customer_id
WHERE i.paid = FALSE
ORDER BY days_outstanding DESC;
