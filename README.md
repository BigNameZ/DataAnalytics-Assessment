# DataAnalytics-Assessment

This repository contains SQL queries for a data analytics assessment tailored for Cowrywise.

## Per-Question Explanations

### Question 1: High-Value Customers with Multiple Products
- **Approach:** Identify customers with both savings and investment plans.
- **Steps:**
  1. Find customers with savings plans.
  2. Find customers with investment plans.
  3. Combine results to find customers with both types of plans.
  4. Calculate total deposits and sort results.

### Question 2: Transaction Frequency Analysis
- **Approach:** Analyze transaction frequency to categorize customers.
- **Steps:**
  1. Calculate transactions per customer per month.
  2. Categorize customers based on transaction frequency.
  3. Count customers in each frequency category.

### Question 3: Account Inactivity Alert
- **Approach:** Flag accounts with no transactions in the last year.
- **Steps:**
  1. Find the last transaction date for each account.
  2. Filter accounts with no transactions in the last 365 days.
  3. Calculate inactivity days.

### Question 4: Customer Lifetime Value (CLV) Estimation
- **Approach:** Estimate CLV based on account tenure and transaction volume.
- **Steps:**
  1. Calculate customer tenure and total transactions.
  2. Estimate CLV using the provided formula.
  3. Sort results by estimated CLV.

## Challenges
- **Challenge 1:** Understanding the relationships between tables.
  - **Resolution:** Used aliases and comments to clarify table relationships.
- **Challenge 2:** Writing efficient SQL queries.
  - **Resolution:** Broke down each query into smaller, manageable steps.
