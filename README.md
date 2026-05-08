#  End-to-End Sales Analytics Project

A comprehensive Data Analytics project that transforms raw transactional data into a professional **Business Intelligence (BI) solution**. This project demonstrates a complete data pipeline using **Excel, SQL, and Power BI**.

---

## 🎯 Project Objective
The goal is to analyze transactional data to extract actionable insights regarding sales performance, customer behavior, and regional growth to support data-driven decision-making.

## 🛠️ Technology Stack
* **Excel:** Data Cleaning & ETL (Extract, Transform, Load) operations.
* **SQL:** Database Management, Table Joins, and Data Validation.
* **Power BI:** Data Modeling, DAX Measures, and Interactive Dashboarding.

---

## ⚙️ Project Phases

### 1. Data Cleaning (Excel)
Extensive pre-processing was performed in Excel to ensure data integrity:
* **Date Standardization:** Fixed inconsistent formats (MM/DD/YYYY vs DD/MM/YYYY) using `Text to Columns` and the `DATEVALUE` function.
* **Data Validation:** Removed duplicate records and handled missing values in Sales/Profit columns to prevent calculation errors.
* **Standardization:** Cleaned category and city names to eliminate redundancies caused by spelling inconsistencies.

### 2. Backend Data Management (SQL)
SQL served as the engine for structured data storage and optimization:
* **Schema Design:** Created a database with optimized data types (`DECIMAL`, `DATE`, `VARCHAR`).
* **Data Transformation:** Performed `LEFT JOIN` operations to consolidate Sales, Customers, and Products tables.
* **Performance Optimization:** Developed **SQL Views** and **Indexes** to provide Power BI with pre-processed, high-speed data.
* **Verification:** Used `GROUP BY` and `SUM` queries to validate KPI totals against raw data.

---

## 📊 Dashboard Breakdown (Power BI)

The solution consists of 4 specialized dashboards:

### 📑 Dashboard 1: Executive Sales Overview
* **Purpose:** Provides a high-level summary for stakeholders.
* **Key Metrics:** KPI cards for Total Sales ($457K), Total Profit, and Quantity.
* **Visuals:** Monthly sales trend line chart to monitor growth patterns.

### 👥 Dashboard 2: Customer Analytics
* **Purpose:** Analyzes buyer behavior and market segmentation.
* **Insights:** Sales breakdown by segment (Consumer, Corporate, Home Office) and a "Top 10 Customers" list by revenue.

### 🌍 Dashboard 3: Geographic Deep-Dive
* **Visuals:** Filled Heatmap using a **Teal-Orange gradient** and a State-City Hierarchical Matrix.
* **Feature:** Applied **Conditional Formatting** (Red backgrounds) to identify loss-making cities instantly.

### 📦 Dashboard 4: Product Performance
* **Analysis:** Detailed comparison between Furniture, Technology, and Office Supplies.
* **Interactivity:** Integrated regional and category slicers for dynamic filtering.

---

## 🧪 Technical Implementation
* **Data Modeling:** Established a robust Star Schema relationship between tables for seamless filtering.
* **DAX Measures:** Authored custom DAX for `Total Sales`, `Total Profit`, and `Profit Margin %`.
* **Visual Aesthetics:** Used a professional **Orange & Teal** color palette for a consistent UI/UX experience.
* **Formatting:** Standardized large currency values into **"K" (Thousands)** for better readability.

---

## 💡 Final Conclusion
This project showcases a full-scale data pipeline—from raw data cleaning to advanced visualization. It enables businesses to identify profitable regions and optimize underperforming product categories efficiently.
