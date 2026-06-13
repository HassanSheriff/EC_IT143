-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Triggers - Step 3: Research and test a solution
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwt_s3_hs.sql
  PURPOSE:  Step 3 - Research T-SQL AFTER UPDATE triggers and identify
            the correct pattern to use.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3

  RUNTIME: N/A - research step

  SOURCES USED:
  1. https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql
     (Official Microsoft docs - CREATE TRIGGER syntax and examples)
  2. https://stackoverflow.com/questions/9522982/t-sql-trigger-update
     (Stack Overflow - practical AFTER UPDATE trigger patterns)
  3. https://stackoverflow.com/questions/4574010/how-to-create-trigger-to-keep-track-of-last-changed-data
     (Stack Overflow - tracking last changed data with triggers)
*******************************************************************************/

-- Q1: How do I keep track of when a record was last modified?
-- A1: DEFAULT GETDATE() handles INSERT only.

-- Q2: How do I keep track of when a record was last modified (UPDATE)?
-- A2: Use an AFTER UPDATE trigger.

-- Key research findings:
-- * CREATE TRIGGER syntax: CREATE TRIGGER trigger_name ON table_name AFTER UPDATE AS ...
-- * Inside the trigger body: use the virtual "Inserted" table to find which rows changed.
-- * Pattern:
--       UPDATE target_table
--          SET last_modified_date = GETDATE()
--        WHERE primary_key IN (SELECT DISTINCT primary_key FROM Inserted);
--
-- * The "Inserted" table holds the NEW (post-update) version of changed rows.
-- * Using SELECT DISTINCT on the PK ensures we update each affected row once.

-- Next step: build the actual AFTER UPDATE trigger (Step 4).
