# SQL Warehouse Project

## Project Overview

This project is an end-to-end **SQL Data Warehouse** built using **Microsoft SQL Server and T-SQL**.

The goal is to demonstrate practical **Junior Data Engineer** skills by integrating CRM and ERP source data, loading it through a layered warehouse architecture, performing data cleaning and transformation, validating data quality, and producing business-ready analytical tables.

**Data flow:** CRM / ERP Source Data → Bronze → Silver → Gold

> **Project type:** Portfolio / learning project  
> **Primary focus:** SQL Data Engineering and Data Warehousing  
> **Database:** Microsoft SQL Server  
> **Version control:** GitHub  
> **Diagramming:** draw.io

---

## Project Objectives

This project demonstrates how to:

- Ingest raw CRM and ERP source data
- Build a layered data warehouse
- Clean and standardize source data
- Integrate data from multiple source systems
- Perform data-quality validation
- Create fact and dimension tables
- Implement ETL using T-SQL
- Use stored procedures to load warehouse layers
- Create an analytical data model
- Document the architecture and data flow

---

## Data Warehouse Architecture

The project follows a **Medallion Architecture** with three layers.

```text
             CRM / ERP Source Files
                      │
                      ▼
              ┌───────────────┐
              │ BRONZE LAYER  │
              │   Raw Data    │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ SILVER LAYER  │
              │ Cleaned &     │
              │ Transformed   │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │  GOLD LAYER   │
              │ Business-Ready│
              │     Data      │
              └───────────────┘
```

### Bronze Layer

Stores source data in its raw form before business transformations are applied.

### Silver Layer

Contains cleaned and standardized data. Transformations include:

- Removing unwanted spaces
- Handling NULL values
- Validating dates
- Validating keys
- Checking invalid values
- Duplicate checks
- Creating derived columns
- Standardizing source attributes

### Gold Layer

Contains business-ready analytical tables:

- `fact_sales`
- `dim_customers`
- `dim_products`

The Gold layer uses a dimensional modelling approach with a central sales fact table and supporting dimensions.

---

##  ETL Pipeline

### 1. Extract

CRM and ERP source files are loaded into the Bronze layer.

Example source entities include:

```text
CRM
├── crm_sales_details
├── crm_cust_info
└── crm_prd_info

ERP
├── erp_cust_az12
├── erp_loc_a101
└── erp_px_cat_g1v2
```

### 2. Transform

The Silver layer applies cleaning, validation and transformation logic.

Examples:

- `TRIM()` for unwanted spaces
- Date validation and conversion
- Key validation
- NULL handling
- Duplicate checks
- Invalid-value checks
- Derived columns
- Source-data standardization

### 3. Load

Cleaned data is loaded into the Gold layer:

```text
Silver
  │
  ├──► dim_customers
  │
  ├──► dim_products
  │
  └──► fact_sales
```

---

##  Gold Layer Data Model

### `fact_sales`

The central fact table containing sales-related transactional information.

### `dim_customers`

Contains customer attributes used for customer-level analysis.

### `dim_products`

Contains product attributes used for product-level analysis.

This dimensional structure makes the data easier to query and use for downstream analytics and reporting.

---

## Data Quality Checks

Data quality was treated as an important part of the ETL process.

The project includes checks for:

### Duplicate Records
Checks for duplicate records and duplicate business keys.

### NULL Values
Checks for missing values that could affect the analytical datasets.

### Invalid Dates
Validates and transforms date fields to prevent invalid dates from reaching the final layer.

### Invalid Keys
Checks keys for invalid or inconsistent relationships.

### Unwanted Spaces
Uses string-cleaning operations such as `TRIM()` to remove leading and trailing spaces.

### Invalid Values
Checks source attributes for unexpected or invalid values.

### Derived Columns
Creates additional analytical attributes from existing source fields where required.

---

## ⚙️ Stored Procedures

The ETL process uses **SQL Server stored procedures** for warehouse loading and transformation.

The procedures contain the logic required to move data through the warehouse layers.

A typical loading process is:

```text
Prepare Target
      ↓
Read Source Data
      ↓
Clean & Transform
      ↓
Validate
      ↓
Insert into Target
      ↓
Validate Loaded Data
```

The stored procedures are included in the GitHub repository so the ETL implementation can be reviewed and reproduced.

---

##  Technologies Used

| Technology | Purpose |
|---|---|
| **Microsoft SQL Server** | Database and Data Warehouse |
| **T-SQL** | ETL, transformations and validation |
| **SQL Stored Procedures** | Warehouse loading and ETL logic |
| **GitHub** | Version control and portfolio |
| **draw.io** | Architecture and data-flow diagrams |

---

##  Project Structure

A suggested repository structure is:

```text
SQL-Warehouse-Project/
│
├── datasets/
│   ├── crm/
│   └── erp/
│
├── scripts/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── docs/
│   └── diagrams/
│
└── README.md
```

> Update the folder names above if your actual GitHub repository uses different names.

---

##  Key SQL Skills Demonstrated

- SELECT and filtering
- JOINs
- GROUP BY and aggregations
- CASE expressions
- CTEs
- Subqueries
- Window functions
- String functions
- Date functions
- `TRIM()`
- Data type conversion
- Duplicate detection
- NULL handling
- Data validation
- Derived columns
- Table creation
- `INSERT`
- `TRUNCATE`
- Stored procedures
- ETL workflows
- Dimensional modelling

---

## 💼Why This Project Is Relevant to Junior Data Engineer Roles

This project demonstrates more than individual SQL queries. It shows an end-to-end data engineering workflow:

**Source Data → Ingestion → Transformation → Data Quality → Data Warehouse → Analytical Model**

The project demonstrates practical understanding of:

- Data warehouse architecture
- ETL development
- Data integration
- Data cleaning
- Data quality
- Fact and dimension tables
- Dimensional modelling
- SQL Server
- T-SQL
- Stored procedures
- Git/GitHub

These are foundational skills for **Junior Data Engineer and Entry-Level Data Engineer** positions.

---

## How to Run the Project

### Prerequisites

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Git
- CRM and ERP source datasets

### Steps

1. Clone this repository.
2. Open the SQL scripts in SQL Server Management Studio.
3. Create/configure the project database.
4. Load the source data into the Bronze layer.
5. Execute the Silver-layer transformation scripts/stored procedures.
6. Execute the Gold-layer loading scripts/stored procedures.
7. Run the data-quality validation scripts.
8. Verify the final Gold tables.

Example:

```sql
SELECT TOP 100 *
FROM gold.fact_sales;

SELECT TOP 100 *
FROM gold.dim_customers;

SELECT TOP 100 *
FROM gold.dim_products;
```

---

## Project Outcome

The final result is a structured SQL data warehouse that integrates CRM and ERP source data and transforms it into clean, analytical datasets.

The Gold layer provides a simplified structure for downstream analytics and reporting.

The project demonstrates the complete process of building a warehouse from raw source data rather than only writing isolated SQL queries.

---

## Learning & Reference

This is a **learning and portfolio project** developed with the help of concepts demonstrated in a YouTube data-engineering tutorial.

It is safe and professional to disclose that openly. A suitable description is:

> This project was developed as a learning project based on concepts demonstrated in a YouTube data engineering tutorial, with hands-on implementation, experimentation, data-quality validation, ETL development, and documentation.

If you know the original tutorial/creator, add the exact video link here and give appropriate credit.

---

## Future Improvements

Possible improvements include:

- Incremental loading instead of full reloads
- ETL logging and error handling
- Audit columns and load timestamps
- More comprehensive automated data-quality tests
- Additional dimensions
- Scheduled ETL execution
- BI dashboard integration
- CI/CD for database deployment
- More detailed business-rule documentation

---

## 👨‍💻 Author

**Sahil Dhotre**

Data Engineering portfolio project demonstrating practical skills in **SQL Server, T-SQL, ETL, Data Warehousing, Data Quality, Dimensional Modelling and GitHub**.
