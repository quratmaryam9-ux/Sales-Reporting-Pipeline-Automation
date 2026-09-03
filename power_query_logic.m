## Power BI & DAX Analytics Layer

The reporting layer connects directly to the normalized data model to deliver automated executive dashboards. Complex business logic, customer segmentation, and repeat-purchase metrics are calculated dynamically using DAX (Data Analysis Expressions).

### Key DAX Measures & Analytics Logic

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

// 4. Average Days Between Customer Purchases (Purchase Intervals)
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
