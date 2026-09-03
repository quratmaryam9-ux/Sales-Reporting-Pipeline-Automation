SQL
-- Create Schema
CREATE SCHEMA IF NOT EXISTS SALES_DW;
USE SCHEMA SALES_DW;

-- DimDistrict Table
CREATE OR REPLACE TABLE DimDistrict (
    DistrictID INT PRIMARY KEY,
    DistrictName VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL
);

-- DimStores Table
CREATE OR REPLACE TABLE DimStores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    DistrictID INT FOREIGN KEY REFERENCES DimDistrict(DistrictID),
    IsActive BOOLEAN DEFAULT TRUE
);

-- DimCustomer Table
CREATE OR REPLACE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerSegment VARCHAR(50),
    CreatedDate DATE DEFAULT CURRENT_DATE()
);

-- FactSales Table
CREATE OR REPLACE TABLE FactSales (
    SalesID BIGINT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES DimCustomer(CustomerID),
    StoreID INT FOREIGN KEY REFERENCES DimStores(StoreID),
    TransactionDate TIMESTAMP_NTZ NOT NULL,
    QuantitySold INT NOT NULL,
    UnitPrice NUMBER(10,2) NOT NULL,
    TotalAmount NUMBER(12,2) NOT NULL
);
