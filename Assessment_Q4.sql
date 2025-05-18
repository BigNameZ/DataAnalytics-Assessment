-- Step 1: Calculate customer tenure and total transactions
WITH CustomerTenure AS (
    SELECT
        owner_id AS cwc_id, -- Unique identifier for the customer
        TIMESTAMPDIFF(MONTH, MIN(transaction_date), CURRENT_DATE) AS tenure_months, -- Tenure in months
        COUNT(*) AS total_transactions, -- Number of transactions
        SUM(confirmed_amount) AS total_transaction_value -- Total transaction value
    FROM
        savings_savingsaccount cwsa -- Alias for savings_savingsaccount table
    GROUP BY
        owner_id -- Group by customer
)

-- Step 2: Calculate estimated CLV
SELECT
    uc.id AS cwc_id, -- Customer ID
    CONCAT(uc.first_name, ' ', uc.last_name) AS cust_name, -- Full name of the customer
    ct.tenure_months, -- Tenure in months
    ct.total_transactions, -- Number of transactions
    (ct.total_transactions / NULLIF(ct.tenure_months, 0)) * 12 * (ct.total_transaction_value * 0.001 / NULLIF(ct.total_transactions, 0)) AS estimated_clv -- Estimated CLV
FROM
    users_customuser uc -- Alias for users_customuser table
JOIN
    CustomerTenure ct ON uc.id = ct.cwc_id -- Join with customer tenure data
ORDER BY
    estimated_clv DESC; -- Sort by estimated CLV in descending order
