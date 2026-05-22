/*
================================================================================
  SCRIPT HEADER
================================================================================
  File Name   : EC_IT143_W3.4_hs.sql
  Author      : Hassan Sheriff
  Date        : 2026-05-22
  Course      : IT 143 – Introduction to SQL
  Assignment  : W3.4 Adventure Works – Create Answers
  Database    : AdventureWorks2019
  Description : This script contains 8 user-generated questions and their
                corresponding SQL answers using the AdventureWorks sample
                database. Questions cover marginal, moderate, and increased
                complexity, plus metadata questions using INFORMATION_SCHEMA.
--------------------------------------------------------------------------------
  Runtime Estimate: ~5 seconds total for all queries
================================================================================
  QUESTION MIX SUMMARY
  ─────────────────────────────────────────────────────────────────────────────
  Q1 – Marginal Complexity    : List all employees by name
  Q2 – Marginal Complexity    : List all products and their list prices
  Q3 – Moderate Complexity    : Total sales amount per customer
  Q4 – Moderate Complexity    : Number of orders placed each year
  Q5 – Increased Complexity   : Top 5 salespeople by total revenue
  Q6 – Increased Complexity   : Products that have never been ordered
  Q7 – Metadata               : All tables in the AdventureWorks database
  Q8 – Metadata               : All columns in Sales.SalesOrderHeader
================================================================================
  LEARNING RESOURCES
  ─────────────────────────────────────────────────────────────────────────────
  1. https://stackoverflow.com/help/how-to-ask
  2. https://stackoverflow.com/help/how-to-answer
  3. https://www.ccl.org/articles/leading-effectively-articles/coaching-others-use-active-listening-skills/
  4. https://learnsql.com/blog/sql-formatting-standards/
  5. https://learn.microsoft.com/en-us/sql/t-sql/language-elements/comment-transact-sql
  6. https://learn.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/system-information-schema-views-transact-sql
================================================================================
*/

-- ============================================================================
-- SETUP: Make sure we are using the correct database
-- ============================================================================
USE AdventureWorks2019;
GO

-- ============================================================================
-- QUESTION 1 (Marginal Complexity)
-- ============================================================================
-- Question Author : Hassan Sheriff
-- Question        : What are the first and last names of all employees
--                   in the AdventureWorks database?
-- Why Asked       : HR staff may need a simple roster of all employees.
-- ============================================================================

SELECT
    p.FirstName,
    p.LastName,
    e.JobTitle
FROM HumanResources.Employee   AS e
JOIN Person.Person             AS p
    ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY
    p.LastName ASC,
    p.FirstName ASC;

-- ============================================================================
-- QUESTION 2 (Marginal Complexity)
-- ============================================================================
-- Question Author : Gloria
-- Question        : What products does AdventureWorks sell,
--                   and what are their list prices?
-- Why Asked       : A sales rep may need a quick product price reference.
-- ============================================================================

SELECT
    ProductNumber,
    Name          AS ProductName,
    ListPrice,
    Color,
    Size
FROM Production.Product
WHERE ListPrice > 0          -- exclude products with no listed price
ORDER BY ListPrice DESC;

-- ============================================================================
-- QUESTION 3 (Moderate Complexity)
-- ============================================================================
-- Question Author : Gloria
-- Question        : What is the total sales amount for each customer,
--                   sorted from highest to lowest?
-- Why Asked       : Sales managers need to identify their highest-value
--                   customers for relationship management.
-- ============================================================================

SELECT
    c.CustomerID,
    p.FirstName,
    p.LastName,
    SUM(soh.TotalDue)   AS TotalSalesAmount,
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM Sales.Customer                 AS c
JOIN Person.Person                  AS p
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader         AS soh
    ON c.CustomerID = soh.CustomerID
GROUP BY
    c.CustomerID,
    p.FirstName,
    p.LastName
ORDER BY TotalSalesAmount DESC;

-- ============================================================================
-- QUESTION 4 (Moderate Complexity)
-- ============================================================================
-- Question Author : Gloria
-- Question        : How many sales orders were placed in each calendar year?
-- Why Asked       : Executives want to track order volume trends year over year.
-- ============================================================================

SELECT
    YEAR(OrderDate)     AS OrderYear,
    COUNT(SalesOrderID) AS TotalOrders,
    SUM(TotalDue)       AS TotalRevenue
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

-- ============================================================================
-- QUESTION 5 (Increased Complexity)
-- ============================================================================
-- Question Author : Gloria
-- Question        : Who are the top 5 salespeople ranked by their total
--                   sales revenue generated?
-- Why Asked       : Sales directors use this to award bonuses and identify
--                   top performers.
-- ============================================================================

SELECT TOP 5
    p.FirstName,
    p.LastName,
    st.Name                 AS SalesTerritory,
    SUM(soh.TotalDue)       AS TotalRevenue,
    COUNT(soh.SalesOrderID) AS TotalOrders
FROM Sales.SalesPerson              AS sp
JOIN Person.Person                  AS p
    ON sp.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader         AS soh
    ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Sales.SalesTerritory           AS st
    ON sp.TerritoryID = st.TerritoryID
GROUP BY
    p.FirstName,
    p.LastName,
    st.Name
ORDER BY TotalRevenue DESC;

-- ============================================================================
-- QUESTION 6 (Increased Complexity)
-- ============================================================================
-- Question Author : Hassan Sheriff
-- Question        : Which products have never been included in any sales order?
-- Why Asked       : Inventory managers need to identify dead stock products
--                   that may need to be discontinued or promoted.
-- ============================================================================

SELECT
    p.ProductID,
    p.ProductNumber,
    p.Name          AS ProductName,
    p.ListPrice,
    p.StandardCost
FROM Production.Product AS p
WHERE p.ProductID NOT IN (
    SELECT DISTINCT sod.ProductID
    FROM Sales.SalesOrderDetail AS sod
)
ORDER BY p.Name ASC;

-- ============================================================================
-- QUESTION 7 (Metadata – INFORMATION_SCHEMA)
-- ============================================================================
-- Question Author : Gloria
-- Question        : What tables exist inside the AdventureWorks database,
--                   and what schema do they belong to?
-- Why Asked       : A new developer joining the team needs to understand
--                   the overall structure of the database quickly.
-- ============================================================================

SELECT
    TABLE_SCHEMA    AS SchemaName,
    TABLE_NAME      AS TableName,
    TABLE_TYPE      AS TableType
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'     -- excludes views
ORDER BY
    TABLE_SCHEMA ASC,
    TABLE_NAME   ASC;

-- ============================================================================
-- QUESTION 8 (Metadata – INFORMATION_SCHEMA)
-- ============================================================================
-- Question Author : Gloria
-- Question        : What columns exist in the Sales.SalesOrderHeader table,
--                   and what data type does each column use?
-- Why Asked       : A report developer needs to know which columns and
--                   data types are available before writing queries.
-- ============================================================================

SELECT
    COLUMN_NAME         AS ColumnName,
    ORDINAL_POSITION    AS ColumnOrder,
    DATA_TYPE           AS DataType,
    CHARACTER_MAXIMUM_LENGTH AS MaxLength,
    IS_NULLABLE         AS Nullable
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Sales'
  AND TABLE_NAME   = 'SalesOrderHeader'
ORDER BY ORDINAL_POSITION ASC;

/*
================================================================================
  END OF SCRIPT
  Total Questions Answered : 8
  Marginal Complexity      : Q1, Q2
  Moderate Complexity      : Q3, Q4
  Increased Complexity     : Q5, Q6
  Metadata                 : Q7, Q8
================================================================================
*/
