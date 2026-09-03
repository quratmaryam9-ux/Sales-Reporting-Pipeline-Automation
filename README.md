# Sales Reporting Pipeline Automation & Data Warehousing

## Executive Summary
This project re-engineers a manual, Excel-dependent weekly reporting process into an automated, scalable ETL pipeline. By replacing manual copy-pasting and formula lookups with Power Query transformations and a Snowflake star-schema model, the reporting process moves from static Friday emails to near-real-time dashboard availability.

---


## Business Analysis & Requirements Engineering

### 1. Business Scenario (AS-IS vs. TO-BE Analysis)
* **AS-IS State (Legacy Problem):** Sales Managers manually extract 3 separate raw CSV files every Friday afternoon. The manual workflow requires opening Excel, aligning customer IDs, fixing missing dates, and running error-prone VLOOKUPs. This process consumes **4 operational hours weekly**, introduces frequent data-entry errors, and delays executive decision-making.
* **TO-BE State (Automated Solution):** Raw CSV files auto-ingest into a centralized landing folder. Power Query processes automated data transformation and loads clean datasets directly into a Snowflake Star Schema model. Power BI reports execute scheduled daily refreshes, providing executives with real-time analytics.
* **Gap Analysis:** Identified key operational bottlenecks: lack of an automated ETL pipeline, absence of a structured Star Schema data warehouse, and reliance on static email attachments rather than centralized BI reporting.

---

### 2. Requirements Management (MoSCoW Prioritization)

| Priority | Category | Requirement Description | Implementation Status |
| :--- | :--- | :--- | :--- |
| **Must-Have** | ETL & Modeling | Automated multi-CSV consolidation, Star Schema architecture (`FactSales`, `DimCustomer`, `DimProduct`, `DimDate`), automated total revenue calculation | **Completed** (`power_query_logic.m`, `sql_schema.sql`) |
| **Should-Have** | Visual Reporting | Dynamic region/category slicers in Power BI, automated scheduled dataset refreshes | **Completed** (Power BI Service) |
| **Could-Have** | UX / Executive | Mobile-optimized dashboard layout for executive access | *Planned Feature* |
| **Won't-Have** | Advanced ML | Predictive machine learning sales forecasting model | *Out of Scope for Phase 1* |

---


## Process Architecture (BPMN Workflow)

### 1. AS-IS Process (Manual & Error-Prone)
The legacy process required manual CSV exports, Excel copy-pasting, custom VLOOKUPs, and ad-hoc data fixes—leading to delays and operational risk.

![AS-IS Process Flow](<AS-IS Process Flow.png>)

### 2. TO-BE Process (Automated ETL Pipeline)
The modernized pipeline automates file ingestion from the landing folder, applies data cleaning rules via Power Query, maps fields into a Star Schema, and executes scheduled auto-refreshes in Power BI.

![TO-BE Process Flow](<TO-BE Process Flow.png>)

---

## Technical Implementation & Repository Structure

- **Data Ingestion & Cleaning (`power_query_logic.m`):** Power Query (M Language) script to combine landing files, handle null values, and enforce datatypes.
- **Data Warehouse Schema (`sql_schema.sql`):** Snowflake DDL establishing standard star-schema dimension and fact tables (`FactSales`, `DimStores`, `DimCustomer`, `DimDistrict`).
- **Reporting & Visualization:** Power BI dynamic dashboards with automated scheduled refreshes.

---

## Power BI & DAX Analytics Layer

Dynamic measures and business logic built into the reporting model:

```dax
// 1. Total Revenue
Total Revenue = 
SUM(FactSales[Total_Amount])

// 2. Customer Lifetime Value (CLV)
Customer Lifetime Value = 
CALCULATE(
    [Total Revenue],
    ALLEXCEPT(DimCustomer, DimCustomer[Customer_ID])
)

// 3. Pareto VIP Customer Identification (Top 10% Revenue Contributors)
Is VIP Customer = 
VAR CustomerRank = 
    RANKX(
        ALL(DimCustomer), 
        [Total Revenue], , 
        DESC
    )
VAR TotalCustomers = COUNTROWS(ALL(DimCustomer))
RETURN
    IF(
        DIVIDE(CustomerRank, TotalCustomers) <= 0.10, 
        "VIP (Top 10%)", 
        "Standard (90%)"
    )

// 4. Average Days Between Customer Purchases
Avg Days Between Purchases = 
AVERAGEX(
    VALUES(FactSales[Customer_ID]),
    VAR CurrentDate = SELECTEDVALUE(FactSales[Date])
    VAR PreviousDate = 
        CALCULATE(
            MAX(FactSales[Date]),
            FILTER(
                ALL(FactSales),
                FactSales[Customer_ID] = EARLY(FactSales[Customer_ID]) &&
                FactSales[Date] < CurrentDate
            )
        )
    RETURN
        IF(NOT ISBLANK(PreviousDate), DATEDIFF(PreviousDate, CurrentDate, DAY), BLANK())
)
