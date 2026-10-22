SQL
-- Create Schema
CREATE SCHEMA SALES_DW;
GO

-- DimDistrict Table
CREATE TABLE DimDistrict (
    DistrictID INT PRIMARY KEY,
    DistrictName VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL
);

-- DimStores Table
CREATE TABLE DimStores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    DistrictID INT FOREIGN KEY REFERENCES DimDistrict(DistrictID),
    IsActive BIT DEFAULT 1
);

-- DimCustomer Table
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerSegment VARCHAR(50),
    CreatedDate DATE DEFAULT GETDATE()
);

-- FactSales Table
CREATE TABLE FactSales (
    SalesID BIGINT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES DimCustomer(CustomerID),
    StoreID INT FOREIGN KEY REFERENCES DimStores(StoreID),
    TransactionDate DATETIME2 NOT NULL,
    QuantitySold INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL
);
