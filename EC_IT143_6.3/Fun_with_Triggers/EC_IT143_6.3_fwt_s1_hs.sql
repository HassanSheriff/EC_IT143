-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Triggers - Step 1: Start with a question
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwt_s1_hs.sql
  PURPOSE:  Step 1 - Ask the simplest, most focused question possible
            about tracking record changes with a trigger.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3

  RUNTIME: N/A - this is a documentation/question step
*******************************************************************************/

-- Q1: How do I keep track of when a record in
--     [dbo].[t_w3_schools_customers] was last modified?

-- Initial thought:
-- A1: A DEFAULT constraint with GETDATE() will populate
--     last_modified_date when a row is INSERTED.
--     But a DEFAULT only fires on INSERT, not on UPDATE.
--     So a DEFAULT constraint alone is NOT enough.
--     I need a trigger that fires AFTER UPDATE.

-- Step 1 plan: Add a last_modified_date column to the table.
ALTER TABLE dbo.t_w3_schools_customers
ADD last_modified_date DATETIME DEFAULT GETDATE();
GO
