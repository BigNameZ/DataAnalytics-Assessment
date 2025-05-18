-- Step 1: Find customers with savings plans
WITH SavingsCustomers AS (
    SELECT
        owner_id AS cwc_id, -- Unique identifier for the customer
        COUNT(*) AS savings_count, -- Count of savings plans
        SUM(confirmed_amount) AS savings_deposits -- Total amount in savings
    FROM
        savings_savingsaccount cwsa -- Alias for savings_savingsaccount table
    WHERE
        plan_id IN (SELECT id FROM plans_plan pp WHERE pp.is_regular_savings = 1) -- Only savings plans
    GROUP BY
        owner_id -- Group results by customer
    HAVING
        COUNT(*) >= 1 -- Ensure customer has at least one savings plan
),

-- Step 2: Find customers with investment plans
InvestmentCustomers AS (
    SELECT
        owner_id AS cwc_id, -- Unique identifier for the customer
        COUNT(*) AS investment_count, -- Count of investment plans
        SUM(confirmed_amount) AS investment_deposits -- Total amount in investments
    FROM
        savings_savingsaccount cwsa -- Alias for savings_savingsaccount table
    WHERE
        plan_id IN (SELECT id FROM plans_plan pp WHERE pp.is_a_fund = 1) -- Only investment plans
    GROUP BY
        owner_id -- Group results by customer
    HAVING
        COUNT(*) >= 1 -- Ensure customer has at least one investment plan
)

-- Step 3: Combine results to find customers with both savings and investment plans
SELECT
    uc.id AS cwc_id, -- Customer ID
    CONCAT(uc.first_name, ' ', uc.last_name) AS cust_name, -- Full name of the customer
    sc.savings_count, -- Number of savings plans
    ic.investment_count, -- Number of investment plans
    (sc.savings_deposits + ic.investment_deposits) / 100 AS total_deposits -- Total deposits
FROM
    users_customuser uc -- Alias for users_customuser table
JOIN
    SavingsCustomers sc ON uc.id = sc.cwc_id -- Join with savings customers
JOIN
    InvestmentCustomers ic ON uc.id = ic.cwc_id -- Join with investment customers
ORDER BY
    total_deposits DESC; -- Sort by total deposits in descending order
