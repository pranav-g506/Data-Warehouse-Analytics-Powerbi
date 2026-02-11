# 📊 Data Warehouse Analytics & Business Intelligence Project

## 🔍 Project Overview

This project demonstrates an **end-to-end Data Analytics workflow**, starting from database initialization and exploration to advanced analytics and Power BI dashboarding.

The objective of this project is to:
- Design a structured analytical data model
- Perform systematic SQL-based analysis
- Generate meaningful business insights
- Build an interactive Power BI dashboard for decision-making

This project follows **industry-standard analytics practices** and is suitable for **Data Analyst / Business Intelligence roles**.

---

## 🧱 Data Model

The project uses a **star-schema-like structure** consisting of:

### 🟨 Dimension Tables
- `dim_customers` – customer demographics and attributes  
- `dim_products` – product, category, and cost information  

### 🟦 Fact Table
- `fact_sales` – transactional sales data (orders, quantity, revenue)

---

## ⚙️ Tools & Technologies

- **Database**: MySQL 8+
- **Query Language**: SQL
- **Visualization Tool**: Power BI
- **Analytics Concepts**:
  - Exploratory Data Analysis (EDA)
  - Time-Series Analysis
  - Cumulative Analysis
  - Ranking & Performance Analysis
  - Segmentation & Contribution Analysis
- **Version Control**: Git & GitHub

---

## 📁 Project Structure

```text
scripts/
├── 00_init_database.sql
├── 01_database_exploration.sql
├── 02_dimensions_exploration.sql
├── 03_date_range_exploration.sql
├── 04_measures_exploration.sql
├── 05_magnitude_analysis.sql
├── 06_ranking_analysis.sql
├── 07_exploratory_data_analysis(EDA).sql
├── 08_final_analytics.sql
├── 09_change_over_time_analysis.sql
├── 10_cumulative_analysis.sql
├── 11_performance_analysis.sql
├── 12_data_segmentation.sql
├── 13_part_to_whole_analysis.sql
├── 14_customer_report.sql
└── 15_product_report.sql
````

---

## 🔎 Analysis Workflow

This project follows a **step-by-step analytical pipeline**, where each script builds logically on the previous one.

### 1️⃣ Database Initialization

* Create database and base schema
  **Script**: `00_init_database.sql`

### 2️⃣ Database Exploration

* Explore tables, columns, and metadata
  **Script**: `01_database_exploration.sql`

### 3️⃣ Dimensions Exploration

* Analyze dimension attributes and hierarchies
  **Script**: `02_dimensions_exploration.sql`

### 4️⃣ Date Range Exploration

* Understand time coverage of the dataset
  **Script**: `03_date_range_exploration.sql`

### 5️⃣ Measures Exploration

* Validate numeric measures (sales, quantity, price)
  **Script**: `04_measures_exploration.sql`

### 6️⃣ Magnitude Analysis

* Measure contribution across entities
  **Script**: `05_magnitude_analysis.sql`

### 7️⃣ Ranking Analysis

* Identify top and bottom performers
  **Script**: `06_ranking_analysis.sql`

### 8️⃣ Exploratory Data Analysis (EDA)

* Explore distributions, relationships, and anomalies
  **Script**: `07_exploratory_data_analysis(EDA).sql`

### 9️⃣ Final Analytics

* Generate business-ready KPIs
  **Script**: `08_final_analytics.sql`

### 🔟 Change Over Time Analysis

* Analyze trends and seasonality
  **Script**: `09_change_over_time_analysis.sql`

### 1️⃣1️⃣ Cumulative Analysis

* Track running totals and long-term growth
  **Script**: `10_cumulative_analysis.sql`

### 1️⃣2️⃣ Performance Analysis

* Compare customers, products, and regions
  **Script**: `11_performance_analysis.sql`

### 1️⃣3️⃣ Data Segmentation

* Segment customers and products by behavior and value
  **Script**: `12_data_segmentation.sql`

### 1️⃣4️⃣ Part-to-Whole Analysis

* Measure percentage contribution
  **Script**: `13_part_to_whole_analysis.sql`

### 1️⃣5️⃣ Reporting Layer

* Generate customer and product reports
  **Scripts**:
* `14_customer_report.sql`
* `15_product_report.sql`

---

## 📊 Power BI Dashboard

The Power BI dashboard is designed **page-wise**, with each page answering a specific business question.

### Dashboard Pages

1. Executive Summary
2. Sales Trend Analysis
3. Cumulative Growth
4. Product Performance
5. Customer Performance
6. Ranking Analysis
7. Customer Segmentation
8. Product Segmentation
9. Part-to-Whole Analysis
10. Detailed Customer & Product Reports

---

## 🖼️ Dashboard Screenshots

Screenshots are stored inside the `screenshots/` folder.
<img width="1437" height="810" alt="Screenshot 2026-02-11 193431" src="https://github.com/user-attachments/assets/e33b596e-f7cd-4bdb-9bd3-f8fa2910867c" />

<img width="1432" height="800" alt="Screenshot 2026-02-11 193512" src="https://github.com/user-attachments/assets/a6fb52a4-a66e-43e5-8af5-79e244e75e0a" />

---

## 📐 Power BI DAX Highlights

The dashboard uses optimized and reusable DAX measures, including:

* Total Sales
* Total Orders
* Total Customers
* Average Order Value (AOV)
* Month-over-Month Sales Growth
* Cumulative Sales
* Revenue Contribution (%)
* Customer & Product Ranking
* Customer and Product Segmentation

These measures ensure consistency, performance, and scalability.

---

## 🎯 Key Business Insights

Key insights derived from the analysis include:

* A small group of customers contributes a large portion of total revenue
* Certain product categories dominate sales and quantity
* Sales exhibit seasonal trends over time
* Revenue distribution follows the Pareto (80/20) principle
* Clear customer and product segments emerge based on behavior and value

---

## 🚀 How to Run This Project

1. Clone the GitHub repository
2. Execute SQL scripts sequentially from:

   * `00_init_database.sql`
   * to `15_product_report.sql`
3. Load tables into Power BI
4. Create relationships using a star schema
5. Add DAX measures
6. Build dashboard pages as per the mapping

---

## 📌 Future Enhancements

Potential future improvements include:

* Profit and margin analysis
* RFM (Recency, Frequency, Monetary) segmentation
* Automated ETL pipelines
* Scheduled data refresh
* Deployment to Power BI Service

---

## 🤝 Connect With Me

**Pranav**
🎓 BE (Electronics & Telecommunication)
📊 Aspiring Data Analyst

🔗 LinkedIn: *add link*
🔗 GitHub: *add link*
🔗 Portfolio: *add link*

---

## ✅ Final Note

This project demonstrates:

* A complete data analytics lifecycle
* Strong SQL and Power BI integration
* Industry-aligned analytical thinking
* A portfolio-ready project structure

```


Just tell me 👍
```
