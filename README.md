# Sales Reporting Pipeline Automation & Data Warehousing

## Executive Summary
This repository contains an end-to-end automated sales reporting pipeline designed to eliminate manual data aggregation, streamline ETL execution, and deliver a clean star-schema model in Snowflake for executive reporting.

---

## Process Architecture (BPMN)
The reporting workflow was mapped using **BPMN 2.0** standards to identify bottlenecks, eliminate manual handoffs, and establish automated triggers.

- **BPMN Source:** `docs/process_flow.bpmn`
- **Key Improvement:** Automated data ingestion and error handling pre-validation.

---

## Data Model Architecture (Snowflake)
Built using a **Star Schema** deployed on **Snowflake** to support fast query performance for high-volume sales metrics:

- **FactSales:** Core transactional facts (`QuantitySold`, `UnitPrice`, `TotalAmount`, `TransactionDate`).
- **DimCustomer:** Customer metadata and segmentation.
- **DimStores:** Store attributes and regional hierarchies.
- **DimDistrict:** Regional classifications for macro-level aggregation.

---

## Tech Stack
- **Modeling:** BPMN 2.0
- **Transformation:** Power Query (M)
- **Data Warehouse:** Snowflake (SQL / DDL)
- **BI & Analytics:** Power BI
