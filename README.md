# 🛒 Retail Sales Analysis — SQL Project

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue?style=flat&logo=postgresql)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Data](https://img.shields.io/badge/Records-1000-orange)

## 📌 Project Overview

This is my first end-to-end SQL data analytics project where I analyzed a retail sales dataset containing **1,000 transactions** across 3 product categories. The goal was to extract meaningful business insights using SQL queries — from basic aggregations to advanced window functions.

---

## 🗂️ Dataset Description

| Column | Type | Description |
|---|---|---|
| transaction_id | INTEGER | Unique transaction ID |
| date | DATE | Purchase date |
| customer_id | VARCHAR | Unique customer identifier |
| gender | VARCHAR | Male / Female |
| age | INTEGER | Customer age |
| product_category | VARCHAR | Beauty / Clothing / Electronics |
| quantity | INTEGER | Units purchased |
| price_per_unit | NUMERIC | Price per item |
| total_amount | NUMERIC | Total transaction value |

**Source:** Synthetic retail dataset — cleaned and imported into PostgreSQL

---

## 🔧 Tools Used

- **PostgreSQL 18** — Database
- **pgAdmin 4** — Query execution & import
- **Excel** — Initial data exploration & cleaning
- **Python (pandas)** — Data validation

---

## 📊 Key Insights

| Metric | Value |
|---|---|
| 💰 Total Revenue | ₹4,56,000 |
| 👥 Unique Customers | 1,000 |
| 🧾 Total Orders | 1,000 |
| 📅 Best Month | May 2023 (₹53,150) |
| 🏆 Top Category by Revenue | Electronics (₹1,56,905) |
| 🏆 Top Category by Quantity | Clothing (894 units) |
| 👩 Top Gender by Spend | Female (₹2,32,840) |
| 📈 Highest Spending Age Group | 45–54 (₹97,235) |

---

## 🔍 Analysis Questions & SQL Queries

### 🔰 Basic Analysis

**1. Total Revenue**
```sql
SELECT SUM(total_amount) AS total_revenue
FROM retail_sales;
```

**2. Unique Customers**
```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;
```

**3. Most Expensive Product Category**
```sql
SELECT product_category, MAX(price_per_unit) AS max_price
FROM retail_sales
GROUP BY product_category
ORDER BY max_price DESC
LIMIT 1;
```

**4. Total Orders**
```sql
SELECT COUNT(*) AS total_orders
FROM retail_sales;
```

**5. Average Order Value per Category**
```sql
SELECT product_category, 
       ROUND(AVG(total_amount), 2) AS avg_order_value
FROM retail_sales
GROUP BY product_category
ORDER BY avg_order_value DESC;
```

---

### 📊 Intermediate Analysis

**6. Total Sales per Category**
```sql
SELECT product_category, SUM(total_amount) AS total_sales
FROM retail_sales
GROUP BY product_category;
```

**7. Male vs Female — Who Spends More?**
```sql
SELECT gender, SUM(total_amount) AS total_purchase
FROM retail_sales
GROUP BY gender
ORDER BY total_purchase DESC;
```

**8. Top 5 Highest Spending Customers**
```sql
SELECT customer_id, SUM(total_amount) AS total_purchase
FROM retail_sales
GROUP BY customer_id
ORDER BY total_purchase DESC
LIMIT 5;
```

**9. Which Month Generated the Most Revenue?**
```sql
SELECT TO_CHAR(date, 'YYYY-MM') AS month,
       SUM(total_amount) AS total_sales
FROM retail_sales
GROUP BY month
ORDER BY total_sales DESC;
```

**10. Best Category by Quantity Sold**
```sql
SELECT product_category, SUM(quantity) AS total_qty
FROM retail_sales
GROUP BY product_category
ORDER BY total_qty DESC
LIMIT 1;
```

---

### 🚀 Advanced Analysis

**11. Revenue Breakdown by Age Group**
```sql
SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    SUM(total_amount) AS revenue
FROM retail_sales
GROUP BY age_group
ORDER BY revenue DESC;
```

**12. Monthly Revenue with MoM Comparison (Window Function)**
```sql
WITH monthly_data AS (
    SELECT 
        TO_CHAR(date, 'YYYY-MM') AS month,
        SUM(total_amount) AS revenue
    FROM retail_sales
    GROUP BY TO_CHAR(date, 'YYYY-MM')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS difference
FROM monthly_data
ORDER BY month;
```

**13. Gender × Category Cross Analysis**
```sql
SELECT gender, product_category,
       SUM(total_amount) AS total_purchase
FROM retail_sales
GROUP BY gender, product_category
ORDER BY gender, total_purchase DESC;
```

**14. Best Day of the Week for Sales**
```sql
SELECT TO_CHAR(date, 'Day') AS day_name,
       SUM(total_amount) AS total_sales
FROM retail_sales
GROUP BY day_name
ORDER BY total_sales DESC;
```

**15. Customers Who Purchased Only Once**
```sql
SELECT customer_id, COUNT(*) AS order_count
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(*) = 1
ORDER BY customer_id;
```

---

## 💡 Business Insights Summary

- **Electronics** leads in revenue but **Clothing** wins in quantity — suggests lower-priced clothing items sell more units
- **Female customers** outspend male customers by ~₹9,000 — could target premium products toward female segment
- **May 2023** was the best month — worth investigating seasonal trends
- **45–54 age group** spends the most — high-value customer segment
- Used **LAG() window function** for month-over-month revenue comparison

---

## 🚀 How to Run

1. Clone this repository
2. Import `data/retail_sales_cleaned.csv` into PostgreSQL
3. Create table with correct schema (see below)
4. Run queries from `queries/analysis.sql`

```sql
CREATE TABLE retail_sales (
    transaction_id   INTEGER,
    date             DATE,
    customer_id      VARCHAR(20),
    gender           VARCHAR(10),
    age              INTEGER,
    product_category VARCHAR(50),
    quantity         INTEGER,
    price_per_unit   NUMERIC(10,2),
    total_amount     NUMERIC(10,2)
);
```

---

## 👨‍💻 Author

**Suchit Kumar Maurya (Sammy)**
BSc IT Graduate | Aspiring Data Analyst
📍 Mumbai, India

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://linkedin.com/in/your-profile)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat&logo=github)](https://github.com/your-username)
