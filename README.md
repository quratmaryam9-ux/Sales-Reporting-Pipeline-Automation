# Sales Reporting Pipeline Automation & Data Warehousing

## Executive Summary
This project re-engineers a manual, Excel-dependent weekly reporting process into an automated, scalable ETL pipeline. By replacing manual copy-pasting and formula lookups with Power Query transformations and a Snowflake star-schema model, the reporting process moves from static Friday emails to near-real-time dashboard availability.

---

## Process Architecture (BPMN Workflow)

### 1. AS-IS Process (Current Manual State)
The legacy process required manual CSV exports, Excel copy-pasting, custom VLOOKUPs, and ad-hoc data fixes—leading to delays and operational risk.

![AS-IS Process Flow](as_is_process.png)

### 2. TO-BE Process (Automated ETL Pipeline)
The modernized pipeline automates file ingestion from the landing folder, applies data cleaning rules via Power Query, maps fields into a Star Schema, and executes scheduled auto-refreshes in Power BI.

![TO-BE Process Flow](to_be_process.png)

---

## Technical Implementation
- **Data Ingestion & ETL:** Power Query (M Language) for automated file pickup, cleaning, and schema mapping.
- **Data Warehouse:** Snowflake dimensional modeling (`FactSales`, `DimCustomer`, `DimStores`, `DimDistrict`).
- **Reporting Layer:** Power BI with DAX aggregations and automated scheduled refresh.
- **BI & Analytics:** Power BI
