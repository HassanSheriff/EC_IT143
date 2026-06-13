-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 8: Ask the next question (Last Name UDF)
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s8_hs.sql

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: CASE guard for no-space names

  NOTES:
  Next question: How do I extract the LAST name from ContactName?
  Use SUBSTRING starting one position after the first space.
  SOURCE: https://learn.microsoft.com/en-us/sql/t-sql/functions/substring-transact-sql
*******************************************************************************/

-- Q2: How do I extract the last name from ContactName?
-- A2: Use SUBSTRING() starting one position after the first space.

-- Ad hoc test
SELECT
    ContactName
  , CASE
        WHEN CHARINDEX(' ', ContactName) > 0
        THEN SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
        ELSE NULL   -- no space: no last name
    END AS AdHocLastName
  FROM dbo.t_w3_schools_customers
 ORDER BY CustomerName;
GO

-- Create the Last Name UDF
IF OBJECT_ID('dbo.ufn_get_last_name', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufn_get_last_name;
GO

CREATE FUNCTION dbo.ufn_get_last_name
(
    @full_name VARCHAR(100)
)
RETURNS VARCHAR(50)
AS
BEGIN

    DECLARE @last_name VARCHAR(50);

    SET @last_name = CASE
                         WHEN CHARINDEX(' ', @full_name) > 0
                         THEN SUBSTRING(
                                  @full_name,
                                  CHARINDEX(' ', @full_name) + 1,
                                  LEN(@full_name)
                              )
                         ELSE NULL
                     END;

    RETURN @last_name;

END;
GO

-- Smoke test
SELECT dbo.ufn_get_last_name('Maria Anders') AS TestResult;
-- Expected: Anders
GO

-- Side-by-side comparison
SELECT
    ContactName
  , CASE
        WHEN CHARINDEX(' ', ContactName) > 0
        THEN SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
        ELSE NULL
    END                                     AS AdHocLastName
  , dbo.ufn_get_last_name(ContactName)      AS UDFLastName
  FROM dbo.t_w3_schools_customers
 ORDER BY CustomerName;
GO

-- 0 results expected test
WITH cte_compare AS
(
    SELECT
        ContactName
      , CASE
            WHEN CHARINDEX(' ', ContactName) > 0
            THEN SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
            ELSE NULL
        END                                     AS AdHocLastName
      , dbo.ufn_get_last_name(ContactName)      AS UDFLastName
      FROM dbo.t_w3_schools_customers
)
SELECT *
  FROM cte_compare
 WHERE AdHocLastName <> UDFLastName;   -- Expect: 0 rows
GO
