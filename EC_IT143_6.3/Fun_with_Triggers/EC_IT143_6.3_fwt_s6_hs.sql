-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Triggers - Step 6: Ask the next question (last_modified_by)
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwt_s6_hs.sql
  PURPOSE:  Step 6 - Track WHO last modified a record using SUSER_NAME().

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: provide CustomerID in INSERT

  SOURCES USED:
  1. https://learn.microsoft.com/en-us/sql/t-sql/functions/suser-name-transact-sql
  2. https://learn.microsoft.com/en-us/sql/t-sql/statements/alter-table-transact-sql
*******************************************************************************/

-- Q4: How do I keep track of WHO last modified a record?
-- A4: Add last_modified_by column with DEFAULT SUSER_NAME(), plus a trigger.

-- Step A: Add the last_modified_by column (only if it doesn't exist)
IF NOT EXISTS (
    SELECT 1
      FROM sys.columns
     WHERE object_id = OBJECT_ID('dbo.t_w3_schools_customers')
       AND name = 'last_modified_by'
)
BEGIN
    ALTER TABLE dbo.t_w3_schools_customers
    ADD last_modified_by VARCHAR(50) DEFAULT SUSER_NAME();
END;
GO

-- Step B: Create the AFTER UPDATE trigger for last_modified_by
IF OBJECT_ID('dbo.trg_customers_last_mod_by', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_customers_last_mod_by;
GO

CREATE TRIGGER dbo.trg_customers_last_mod_by
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
    /*--------------------------------------------------------------------------
      NAME:    dbo.trg_customers_last_mod_by
      PURPOSE: Record the SQL Server login of the user who last modified
               each row. Uses SUSER_NAME() to capture the server-level user.
    --------------------------------------------------------------------------*/
    UPDATE dbo.t_w3_schools_customers
       SET last_modified_by = SUSER_NAME()
     WHERE CustomerID IN
           (
               SELECT DISTINCT CustomerID
                 FROM Inserted
           );
GO

-- Step C: Clean up and insert fresh test rows
DELETE FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN (9001, 9002);
GO

INSERT INTO dbo.t_w3_schools_customers
       (CustomerID, CustomerName,          ContactName,   Address,    City,       Country)
VALUES (9001,      'Test Customer Alpha', 'Alice Test',  '1 Main St','TestCity', 'TC'),
       (9002,      'Test Customer Beta',  'Bob Test',    '2 Oak Ave','TestCity', 'TC');
GO

-- Step D: Update one row (fires BOTH triggers)
UPDATE dbo.t_w3_schools_customers
   SET ContactName = 'Bob Updated'
 WHERE CustomerID = 9002;
GO

-- Step E: Verify BOTH last_modified_date AND last_modified_by are populated
SELECT
    CustomerID
  , CustomerName
  , ContactName
  , last_modified_date
  , last_modified_by
  FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN (9001, 9002);
-- Expected:
-- 9001: last_modified_date NULL, last_modified_by NULL (not updated)
-- 9002: last_modified_date = timestamp, last_modified_by = your login name
GO

-- Step F: Clean up test rows
DELETE FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN (9001, 9002);
GO
