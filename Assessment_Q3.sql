-- Step 1: Find the last transaction date for each account
WITH LastTransaction AS (
    SELECT
        plan_id AS plan_id, -- Unique identifier for the plan
        owner_id AS cwc_id, -- Unique identifier for the customer
        MAX(transaction_date) AS last_transaction_date -- Last transaction date
    FROM
        savings_savingsaccount cwsa -- Alias for savings_savingsaccount table
    GROUP BY
        plan_id, owner_id -- Group by plan and customer
)

-- Step 2: Find inactive accounts
SELECT
    pp.id AS plan_id, -- Plan ID
    pp.owner_id AS cwc_id, -- Customer ID
    CASE
        WHEN pp.is_regular_savings = 1 THEN 'Savings' -- Categorize as Savings
        WHEN pp.is_a_fund = 1 THEN 'Investment' -- Categorize as Investment
    END AS type, -- Type of plan
    lt.last_transaction_date, -- Last transaction date
    DATEDIFF(CURRENT_DATE, lt.last_transaction_date) AS inactivity_days -- Days since last transaction
FROM
    plans_plan pp -- Alias for plans_plan table
JOIN
    LastTransaction lt ON pp.id = lt.plan_id -- Join with last transaction data
WHERE
    lt.last_transaction_date <= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) -- Inactive for 365 days
ORDER BY
    inactivity_days DESC; -- Sort by inactivity days in descending order
