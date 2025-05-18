-- Step 1: Calculate transactions per customer per month
WITH MonthlyTransactions AS (
    SELECT
        owner_id AS cwc_id, -- Unique identifier for the customer
        DATE_FORMAT(transaction_date, '%Y-%m') AS month, -- Format the transaction date to year-month
        COUNT(*) AS transaction_count -- Number of transactions
    FROM
        savings_savingsaccount cwsa -- Alias for savings_savingsaccount table
    GROUP BY
        owner_id, DATE_FORMAT(transaction_date, '%Y-%m') -- Group by customer and formatted month
),

-- Step 2: Categorize customers based on transaction frequency
CustomerFrequency AS (
    SELECT
        cwc_id, -- Unique identifier for the customer
        AVG(transaction_count) AS avg_transactions_per_month, -- Average transactions per month
        CASE
            WHEN AVG(transaction_count) >= 10 THEN 'High Frequency' -- High frequency category
            WHEN AVG(transaction_count) BETWEEN 3 AND 9 THEN 'Medium Frequency' -- Medium frequency category
            ELSE 'Low Frequency' -- Low frequency category
        END AS frequency_category -- Categorize the frequency
    FROM
        MonthlyTransactions mt -- Alias for MonthlyTransactions CTE
    GROUP BY
        cwc_id -- Group by customer
)

-- Step 3: Count customers in each frequency category
SELECT
    frequency_category, -- Frequency category
    COUNT(*) AS customer_count, -- Number of customers
    AVG(avg_transactions_per_month) AS avg_transactions_per_month -- Average transactions per month
FROM
    CustomerFrequency cf -- Alias for CustomerFrequency CTE
GROUP BY
    frequency_category -- Group by frequency category
ORDER BY
    customer_count DESC; -- Sort by customer count in descending order
