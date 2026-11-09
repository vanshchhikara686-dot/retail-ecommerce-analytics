# Data Dictionary

This dictionary summarises the worksheets and fields in `D2C_Retail_Ecommerce_Dataset.xlsx`.

## Customers

| Field | Description |
|---|---|
| Customer_ID | Unique customer identifier |
| Acquisition_Channel | Customer acquisition source |
| Acquisition_Date | Date the customer was acquired |
| Age | Customer age in years |
| Gender | Gender value in the supplied dataset |
| City | Customer city |
| Customer_Segment | New, Regular, Loyal or VIP segment |

## Products

| Field | Description |
|---|---|
| Product_ID | Unique product identifier |
| Product_Name | Product name |
| Category | Product category |
| Unit_Price_INR | Listed unit price in INR |
| Unit_Cost_INR | Unit cost in INR |
| Supplier | Supplier label |

## Orders

| Field | Description |
|---|---|
| Order_ID | Unique order identifier |
| Order_Date | Order date |
| Customer_ID | Customer who placed the order |
| Channel | Order channel |
| Payment_Method | Payment method |
| Order_Status | Delivered, Cancelled or Returned |

## Order_Items

| Field | Description |
|---|---|
| Order_ID | Parent order identifier |
| Order_Date | Order date |
| Customer_ID | Customer identifier |
| Channel | Order channel |
| Product_ID | Product identifier |
| Quantity | Units in the line item |
| Discount_Pct | Discount percentage |
| Unit_Price_INR | Unit price in INR |
| Unit_Cost_INR | Unit cost in INR |
| Revenue_INR | Line-item revenue in INR |
| Gross_Profit_INR | Line-item gross profit in INR |
| Order_Status | Line-item order status |

## Customer_Summary

| Field | Description |
|---|---|
| Customer_ID | Unique customer identifier |
| Total_Orders | Customer's total order count |
| Total_Revenue | Customer-level revenue total |
| Total_Gross_Profit | Customer-level gross profit total |
| Total_Units | Customer-level unit count |
| Customer_Segment | Customer segment |
| City | Customer city |
| Acquisition_Channel | Acquisition source |
| Average_Order_Value | Average order value as supplied in the summary |
| Profit_Margin | Customer-level gross profit margin as supplied |

**Note:** Currency fields are in Indian rupees (INR). Check the worksheet's grain before joining tables or aggregating: `Order_Items` contains multiple rows per order, while `Orders` contains one row per order.
