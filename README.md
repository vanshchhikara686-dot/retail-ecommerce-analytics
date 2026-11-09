# D2C Revenue, Profitability & Customer Analytics

An end-to-end retail and e-commerce analytics project focused on understanding revenue performance, gross profitability, customer behaviour, acquisition channels, product performance and order trends.

The project uses a portfolio dataset representing a direct-to-consumer (D2C) business and demonstrates a practical analytics workflow across **Excel, SQL Server, Power BI and AI-assisted analysis**.

> **Data note:** This is a portfolio dataset, not verified data from a real company. The findings describe the supplied dataset and should not be interpreted as claims about an actual retailer.

## Project at a glance

| Item | Details |
|---|---|
| Business domain | D2C retail / e-commerce |
| Analysis period | 1 January–31 December 2025 |
| Customers | 5,000 |
| Products | 100 |
| Orders | 22,000 |
| Order-item records | 35,932 |
| Product categories | 5 |
| Customer cities | 12 |
| Tools | Excel, SQL Server (T-SQL), Power BI, AI tools |

## Business problem

A D2C business needs to understand more than just sales volume. It needs to know which products and categories generate revenue and profit, which acquisition channels bring valuable customers, how customer segments behave, and how sales change over time.

This project explores questions such as:

- How much revenue and gross profit did delivered orders generate?
- Which product categories and products contribute most to revenue and gross profit?
- How do acquisition channels compare on revenue, customer volume and profitability?
- Which customer segments generate the strongest revenue?
- What is the order-status mix across delivered, cancelled and returned orders?
- How do monthly revenue and delivered orders change over the year?
- How do discount bands relate to gross margin?
- What proportion of customers are repeat purchasers?

## Dataset

The Excel workbook is in [`data/`](data/).

| Worksheet | Rows | Purpose |
|---|---:|---|
| `Customers` | 5,000 | Customer profile, city, segment and acquisition channel |
| `Products` | 100 | Product catalogue, category, price, cost and supplier |
| `Orders` | 22,000 | Order date, customer, sales channel, payment method and status |
| `Order_Items` | 35,932 | Product-level quantity, discount, revenue and gross profit |
| `Customer_Summary` | 5,000 | Customer-level order, revenue, profit and margin summary |

### Key fields

- **Revenue_INR:** Revenue recorded at order-item level, in Indian rupees.
- **Gross_Profit_INR:** Gross profit recorded at order-item level, in Indian rupees.
- **Discount_Pct:** Discount percentage applied to the order item.
- **Order_Status:** Delivered, Cancelled or Returned.
- **Customer_Segment:** New, Regular, Loyal or VIP.
- **Acquisition_Channel:** Customer acquisition source, such as Google Ads, Meta Ads, Email, Organic, Referral or Influencer.

## Key results in the supplied dataset

The following figures are calculated from the `Order_Items` and `Orders` worksheets, filtering to **Delivered** orders/items where relevant.

| KPI | Result |
|---|---:|
| Delivered orders | 19,996 |
| Delivered-item revenue | ₹16.59 crore |
| Delivered-item gross profit | ₹5.93 crore |
| Gross profit margin | 35.78% |
| Units sold on delivered items | 43,582 |
| Average revenue per delivered order | ₹8,294.89 |

These are dataset-level descriptive results. They are not adjusted for operating expenses, marketing costs, tax, shipping or other costs not represented in the supplied fields; therefore gross profit should not be treated as net profit.

## Analysis performed

### Excel
- Worked with related customer, product, order and order-item tables.
- Used the customer summary sheet for customer-level analysis.
- Prepared the workbook as a source and reviewable data asset.

### SQL Server
The T-SQL analysis script in [`sql/retail_ecommerce_analysis.sql`](sql/retail_ecommerce_analysis.sql) includes examples of:

- Multi-table joins
- Aggregations and grouped analysis
- `COUNT(DISTINCT ...)` for order/customer counts after line-item joins
- `CASE` expressions for discount and purchase-frequency bands
- CTEs for monthly and customer-level analysis
- Window functions such as `LAG()` for month-over-month revenue growth
- `NULLIF()` to protect ratio calculations from division by zero
- Revenue, gross profit, margin, average order value and customer metrics

### Power BI
The Power BI report file is available in [`powerbi/`](powerbi/).

Open the `.pbix` file with Power BI Desktop. Add screenshots of the report pages to [`screenshots/`](screenshots/) so visitors can preview the dashboard directly on GitHub.

## Skills demonstrated

- **Data analysis:** Translating business questions into measurable KPIs and analytical questions.
- **Excel:** Working with multi-sheet datasets and customer-level summaries.
- **SQL:** Joins, aggregations, CTEs, window functions, conditional logic and KPI calculations.
- **Power BI:** Building a report from structured retail/e-commerce data and communicating findings visually.
- **Business thinking:** Revenue vs. gross profit, product/category performance, customer segmentation, acquisition-channel performance and repeat purchasing.
- **AI-assisted analytics:** Using AI tools and prompt engineering to support analytical question generation, SQL/DAX/formula troubleshooting, explanation of analytical concepts, interpretation of outputs and project documentation. AI-generated suggestions and calculations are reviewed against the source data and validated before being used.
- **Analytical judgement:** Distinguishing gross profit from net profit and documenting the limits of the available fields.

## Repository structure

```text
Retail-Ecommerce-Analytics/
├── data/
│   └── D2C_Retail_Ecommerce_Dataset.xlsx
├── sql/
│   └── retail_ecommerce_analysis.sql
├── powerbi/
│   └── D2C_Revenue_Profitability_Customer_Analytics.pbix
├── screenshots/
│   └── Add dashboard screenshots here
├── documentation/
│   └── data_dictionary.md
├── README.md
└── .gitignore
```

## How to use this project

1. Download or clone this repository.
2. Open the Excel workbook in Microsoft Excel to review the source tables.
3. Import the relevant worksheets into SQL Server and run the T-SQL script in `sql/`.
4. Open the Power BI `.pbix` file in Power BI Desktop to explore the report.
5. Review the screenshots folder for static dashboard previews once added.

### SQL table naming note

The SQL script expects these SQL Server table names: `dbo.Customers`, `dbo.Products`, `dbo.orderrs` and `dbo.OrderItems`. The source SQL database used the spelling `orderrs` for the Orders table. If you import the workbook using different table names, update the references in the script or rename the imported tables accordingly.

## Limitations and interpretation

- The dataset covers one calendar year (2025), so it does not support multi-year seasonality or long-term trend claims.
- Revenue and gross profit are derived from order-item records and filtered to delivered status for delivered-performance analysis.
- Gross profit is not net profit; the dataset does not establish all operating costs.
- Customer acquisition channel is a descriptive grouping in the supplied data. The project does not establish causal marketing attribution or incremental return on ad spend.
- The dataset is synthetic/portfolio data; results are intended to demonstrate analytical methods.

## Author

**Aspiring Data Analyst**  
SQL | Excel | Power BI | Python | AI-assisted Analytics

---

If you find this project useful, feel free to explore the SQL analysis and Power BI report.
