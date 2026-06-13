-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Triggers - Step 2: Begin creating an answer
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwt_s2_hs.sql
  PURPOSE:  Step 2 - Write out where I am and what the next logical step is.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3

  RUNTIME: N/A - planning step
*******************************************************************************/

-- Q1: How do I keep track of when a record was last modified?
-- A1: A DEFAULT constraint with GETDATE() handles the initial INSERT only.

-- Commented out (already run in step 1):
-- ALTER TABLE dbo.t_w3_schools_customers
-- ADD last_modified_date DATETIME DEFAULT GETDATE();

-- Q2: How do I keep track of when a record was last modified
--     AFTER an UPDATE?
-- A2: Maybe use an AFTER UPDATE trigger?

--     An AFTER UPDATE trigger fires automatically every time
--     an UPDATE statement runs on the table. Inside the trigger
--     body, I can SET last_modified_date = GETDATE() for the
--     rows that were just changed, using the special Inserted
--     virtual table to identify which rows were affected.
