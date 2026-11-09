# D2C Revenue, Profitability & Customer Analytics

An end-to-end Retail and E-commerce Analytics project focused on understanding revenue performance, gross profitability, customer behaviour, acquisition channels, product performance and order trends.

This project demonstrates a practical analytics workflow using **Microsoft Excel, SQL Server, Power BI and AI-assisted analysis**.

> **Data note:** This is a synthetic portfolio dataset, not verified data from a real company. The findings describe the supplied dataset and should not be interpreted as claims about an actual retailer.

## 1. Project Overview

| Item | Details |
|---|---|
| Business Domain | D2C Retail / E-commerce |
| Analysis Period | January–December 2025 |
| Customers | 5,000 |
| Products | 100 |
| Orders | 22,000 |
| Order-item Records | 35,932 |
| Product Categories | 5 |
| Customer Cities | 12 |
| Tools | Excel, SQL Server, Power BI, AI Tools |

## 2. Business Problem

A D2C business needs to understand more than just sales volume. It needs to identify which products and categories generate revenue and profit, which acquisition channels bring valuable customers, how customer segments behave, and how sales change over time.

This project analyses these areas to support data-driven business decisions.

## 3. Business Questions

- How much revenue and gross profit did delivered orders generate?
- Which product categories contribute the most revenue and gross profit?
- Which products perform best?
- How do acquisition channels compare on revenue and customer volume?
- Which customer segments generate the strongest revenue?
- What is the order-status distribution?
- How does monthly revenue change throughout the year?
- How do discounts relate to gross profit margins?
- What proportion of customers are repeat purchasers?

## 4. Dataset Description

The Excel workbook contains five worksheets:

| Worksheet | Records | Purpose |
|---|---:|---|
| Customers | 5,000 | Customer profile, city, segment and acquisition channel |
| Products | 100 | Product catalogue, category, price, cost and supplier |
| Orders | 22,000 | Order date, customer, sales channel, payment method and status |
| Order_Items | 35,932 | Product-level quantity, discount, revenue and gross profit |
| Customer_Summary | 5,000 | Customer-level order, revenue, profit and margin summary |

### Important Metrics

- **Revenue_INR:** Revenue recorded at order-item level.
- **Gross_Profit_INR:** Gross profit recorded at order-item level.
- **Discount_Pct:** Discount percentage applied to an order item.
- **Order_Status:** Delivered, Cancelled or Returned.
- **Customer_Segment:** New, Regular, Loyal or VIP.
- **Acquisition_Channel:** Google Ads, Meta Ads, Email, Organic, Referral or Influencer.

## 5. Key Findings

The following results are calculated from the supplied dataset, filtering to delivered orders/items where relevant.

| KPI | Result |
|---|---:|
| Delivered Orders | 19,996 |
| Delivered-item Revenue | ₹16.59 Crore |
| Delivered-item Gross Profit | ₹5.93 Crore |
| Gross Profit Margin | 35.78% |
| Units Sold | 43,582 |
| Average Revenue per Delivered Order | ₹8,294.89 |

### Additional Dataset Observations

- Total order records: 22,000.
- Delivered orders: 19,996.
- Cancelled orders: 1,217.
- Returned orders: 787.
- The dataset covers five product categories: Fashion, Beauty, Electronics, Home & Kitchen and Fitness.
- Customer segments include New, Regular, Loyal and VIP.

These are descriptive findings from the supplied dataset, not verified results from a real business.

## 6. Excel Analysis

Excel was used to work with the multi-sheet retail dataset and review customer, product, order and order-item information.

Key areas:
- Multi-sheet dataset exploration.
- Customer-level summaries.
- Revenue and profitability review.
- Product and category analysis.

## 7. SQL Server Analysis

SQL Server was used to perform structured business analysis.

The SQL script demonstrates:

- Multi-table JOIN operations.
- GROUP BY and aggregate functions.
- COUNT DISTINCT for customer and order analysis.
- CASE statements for business classifications.
- Common Table Expressions (CTEs).
- Window functions, including LAG().
- Monthly revenue and growth analysis.
- Customer segmentation.
- Product and category performance.
- Revenue, gross profit, margin and average order value calculations.

SQL file: `retail_ecommerce_analysis.sql`

## 8. Power BI Dashboard Screenshots

The Power BI report presents the project's major business metrics and analytical findings through visual dashboards.

## Power BI Dashboard Screenshots

### 1. Executive Overview
![Executive Overview](screenshots/01_executive_overview.png)

### 2. Revenue Analysis
![Revenue Analysis](screenshots/02_revenue_analysis.png)

### 3. Customer Analytics
![Customer Analytics](screenshots/03_customer_analytics.png)

### 4. Product Performance
![Product Performance](screenshots/04_product_performance.png)

### 5. Dashboard Overview
![Dashboard Overview](screenshots/05_dashboard_overview.png)

The interactive Power BI report is also available as a `.pbix` file in the repository.

## 9. Technical Skills Demonstrated

**Data Analysis**
- Exploratory Data Analysis.
- Data interpretation.
- KPI development.
- Business problem-solving.

**SQL Server**
- Joins and aggregations.
- CTEs and window functions.
- Analytical queries.
- Business metric calculations.

**Microsoft Excel**
- Multi-sheet dataset handling.
- Data exploration.
- Customer-level analysis.
- Revenue and profitability analysis.

**Power BI**
- Data visualisation.
- KPI cards and business dashboards.
- Interactive reporting.
- Revenue and customer analytics.

**AI-Assisted Analytics**
- Using AI tools to generate and refine analytical questions.
- SQL query development and debugging assistance.
- DAX and Excel formula assistance.
- Understanding datasets and analytical concepts.
- Interpreting analytical outputs.
- Documentation and insight generation.
- Validating AI-generated suggestions against actual data.

AI is used as an analytical productivity tool. Final calculations and findings are checked against the source dataset.

## 10. Repository Structure

```text
retail-ecommerce-analytics/
│
├── README.md
├── .gitignore
├── D2C_Retail_Ecommerce_Dataset.xlsx
├── D2C_Revenue_Profitability_Customer_Analytics.pbix
├── retail_ecommerce_analysis.sql
├── data_dictionary.md
│
├── 01_executive_overview.png
├── 02_revenue_analysis.png
├── 03_customer_analytics.png
├── 04_product_performance.png
└── 05_dashboard_overview.png
```

## 11. Limitations and Interpretation

- The dataset covers one calendar year (2025), so it does not support multi-year seasonality or long-term trend claims.
- Revenue and gross profit are derived from order-item records and filtered to delivered status for delivered-performance analysis.
- Gross profit is not net profit. The dataset does not establish all operating costs.
- Acquisition channel is a descriptive grouping; the project does not establish causal marketing attribution or incremental return on ad spend.
- The dataset is synthetic portfolio data intended to demonstrate analytical methods.

## 12. Author

**Vansh**  
Aspiring Data Analyst | BSc Agriculture Student

**Technical Skills:**  
SQL Server | Microsoft Excel | Power BI | Python | Data Analytics | AI-Assisted Analytics

---

*Built as part of my Data Analytics portfolio to demonstrate practical analytical skills, business understanding and data-driven problem-solving.*

