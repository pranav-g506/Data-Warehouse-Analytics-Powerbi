# 📊 Data Warehouse Analytics & Business Intelligence Project

## 🔍 Project Overview

This project demonstrates an **end-to-end Data Analytics workflow**, starting from raw data exploration to advanced business analytics and Power BI dashboarding.

The goal of the project is to:
- Design a clean analytical data model
- Perform structured SQL-based analysis
- Generate actionable business insights
- Build an interactive Power BI dashboard for decision-making

This project follows **industry-standard analytics practices** and is suitable for **Data Analyst / BI roles**.

---

## 🧱 Data Model

The project follows a **star-schema-like structure**:

### 🟨 Dimension Tables
- `dim_customers` – Customer demographic information  
- `dim_products` – Product and category details  

### 🟦 Fact Table
- `fact_sales` – Transactional sales data  

---

## ⚙️ Tools & Technologies

- **Database**: MySQL 8+
- **Query Language**: SQL
- **Visualization**: Power BI
- **Version Control**: Git & GitHub

### Analytics Concepts Used
- Exploratory Data Analysis (EDA)
- Change Over Time Analysis
- Cumulative Analysis
- Performance Analysis
- Ranking Analysis
- Data Segmentation
- Part-to-Whole Analysis
- Business Reporting

---

## 📁 Project Structure

```text
├── sql/
│   ├── 03_database_exploration.sql
│   ├── 04_dimensions_exploration.sql
│   ├── 05_date_range_exploration.sql
│   ├── 06_measures_exploration.sql
│   ├── 07_magnitude_analysis.sql
│   ├── 08_ranking_analysis.sql
│   ├── 09_eda.sql
│   ├── 10_analytics.sql
│   ├── 11_change_over_time_analysis.sql
│   ├── 12_cumulative_analysis.sql
│   ├── 13_performance_analysis.sql
│   ├── 14_data_segmentation.sql
│   ├── 15_part_to_whole_analysis.sql
│   ├── 16_customer_report.sql
│   └── 17_product_report.sql
│
├── powerbi/
│   └── Sales_Analytics_Dashboard.pbix
│
├── screenshots/
│   └── (dashboard images)
│
└── README.md

## 🔎 Analysis Workflow

This project follows a **step-by-step analytical workflow**, where each SQL script builds logically on the previous one.

### 1️⃣ Database Initialization
- Create database and base structure
- Prepare environment for analytics

**Script**
- `00_init_database.sql`

---

### 2️⃣ Database Exploration
- Explore database metadata
- Understand tables, columns, and data types

**Script**
- `01_database_exploration.sql`

---

### 3️⃣ Dimensions Exploration
- Analyze dimension tables
- Understand categorical attributes and hierarchies

**Script**
- `02_dimensions_exploration.sql`

---

### 4️⃣ Date Range Exploration
- Inspect date fields across tables
- Understand time coverage and data availability

**Script**
- `03_date_range_exploration.sql`

---

### 5️⃣ Measures Exploration
- Analyze numeric measures (sales, quantity, price)
- Validate ranges and data consistency

**Script**
- `04_measures_exploration.sql`

---

### 6️⃣ Magnitude Analysis
- Measure contribution across customers, products, categories, and regions
- Identify dominant entities

**Script**
- `05_magnitude_analysis.sql`

---

### 7️⃣ Ranking Analysis
- Rank customers, products, and regions by performance
- Identify top and bottom performers

**Script**
- `06_ranking_analysis.sql`

---

### 8️⃣ Exploratory Data Analysis (EDA)
- Explore distributions, relationships, and anomalies
- Understand data behavior before final analytics

**Script**
- `07_exploratory_data_analysis(EDA).sql`

---

### 9️⃣ Final Analytics
- Generate business-ready KPIs and insights
- Prepare datasets for dashboards

**Script**
- `08_final_analytics.sql`

---

### 🔟 Change Over Time Analysis
- Analyze trends, growth, and seasonality
- Perform time-series analysis

**Script**
- `09_change_over_time_analysis.sql`

---

### 1️⃣1️⃣ Cumulative Analysis
- Track running totals of sales, orders, and customers
- Understand long-term growth patterns

**Script**
- `10_cumulative_analysis.sql`

---

### 1️⃣2️⃣ Performance Analysis
- Compare performance across customers, products, categories, and regions

**Script**
- `11_performance_analysis.sql`

---

### 1️⃣3️⃣ Data Segmentation
- Segment customers and products based on value and behavior

**Script**
- `12_data_segmentation.sql`

---

### 1️⃣4️⃣ Part-to-Whole Analysis
- Measure percentage contribution of entities to overall totals

**Script**
- `13_part_to_whole_analysis.sql`

---

### 1️⃣5️⃣ Reporting Layer
- Generate business-ready customer and product reports

**Scripts**
- `14_customer_report.sql`
- `15_product_report.sql`

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

Each page is directly mapped to one or more SQL analysis scripts.

---

## 🖼️ Dashboard Screenshots

> Dashboard screenshots are stored inside the `screenshots/` folder.

```md
![Executive Summary](screenshots/executive_summary.png)
![Sales Trends](screenshots/sales_trends.png)
![Customer Segmentation](screenshots/customer_segmentation.png)


## 📐 Power BI DAX Highlights

The dashboard uses optimized and reusable DAX measures to support business analytics.

### Key Measures
- **Total Sales**
- **Total Orders**
- **Total Customers**
- **Average Order Value (AOV)**
- **Month-over-Month Sales Growth**
- **Cumulative Sales**
- **Revenue Contribution (%)**
- **Customer & Product Ranking**
- **Customer and Product Segmentation**

These measures ensure:
- Consistent calculations across visuals
- Better performance and scalability
- Easy maintenance and extensibility

---

## 🎯 Key Business Insights

Insights derived from the analysis include:

- A small group of customers contributes a significant share of total revenue
- Certain product categories dominate overall sales and quantity
- Sales show clear seasonal patterns over time
- Revenue distribution follows the Pareto (80/20) principle
- Customer segmentation reveals distinct behavioral and value-based groups

These insights help support strategic decision-making and business planning.

---

## 🚀 How to Run This Project

Follow the steps below to reproduce the analysis:

1. Clone the GitHub repository
2. Execute SQL scripts sequentially:
   - Start from `00_init_database.sql`
   - End with `15_product_report.sql`
3. Load the final tables into Power BI
4. Create relationships using a star schema
5. Add the provided DAX measures
6. Build dashboard pages according to the page-wise mapping

---

## 📌 Future Enhancements

Planned improvements for future iterations:

- Add profit and margin analysis
- Implement RFM (Recency, Frequency, Monetary) segmentation
- Automate ETL pipelines
- Enable scheduled data refresh
- Deploy dashboard to Power BI Service

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

This project showcases:
- End-to-end data analytics workflow
- Strong SQL and Power BI integration
- Industry-aligned analytical approach
- Portfolio-ready project structure
