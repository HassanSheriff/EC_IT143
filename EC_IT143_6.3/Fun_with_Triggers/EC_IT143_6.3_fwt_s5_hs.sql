-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Triggers - Step 5: Test results to see if they are as expected
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwt_s5_hs.sql
  PURPOSE:  Step 5 - Verify the AFTER UPDATE trigger fires correctly.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: provide CustomerID in INSERT (NOT NULL col)

  RUNTIME: ~1s
*******************************************************************************/

-- Q2: How do I keep track of when a record was last modified?
-- A2: Maybe use an after update trigger.
-- Q3: Did it work?
-- A3: Let's see...

-- Step A: Find a safe CustomerID range to use for test rows
-- (using 9001 and 9002 to avoid conflicts with existing data)

-- Step B: Clean up test rows if they already exist
DELETE FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN (9001, 9002);
GO

-- Step C: Insert test rows WITH a CustomerID value
INSERT INTO dbo.t_w3_schools_customers
       (CustomerID, CustomerName,          ContactName,   Address,    City,       Country)
VALUES (9001,      'Test Customer Alpha', 'Alice Test',  '1 Main St','TestCity', 'TC'),
       (9002,      'Test Customer Beta',  'Bob Test',    '2 Oak Ave','TestCity', 'TC');
GO

-- Step D: See rows BEFORE update (last_modified_date should be NULL)
SELECT CustomerID, CustomerName, ContactName, last_modified_date
  FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN (9001, 9002);
GO

-- Step E: Perform an UPDATE (this fires the trigger)
UPDATE dbo.t_w3_schools_customers
   SET ContactName = 'Alice Updated'
 WHERE CustomerID = 9001;
GO

-- Step F: Check AFTER update
-- CustomerID 9001 should have last_modified_date populated
-- CustomerID 9002 should still be NULL (was not updated)
SELECT CustomerID, CustomerName, ContactName, last_modified_date
  FROM dbo.t_w3_schools_customers
 WHERE CustomerID IN (9001, 9002);
GO
