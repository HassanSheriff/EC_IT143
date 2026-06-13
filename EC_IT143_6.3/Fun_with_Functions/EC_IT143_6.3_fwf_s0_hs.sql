-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Setup Script - Materialize v_w3_schools_customers into a table
  Script Date: 06/12/2026

  NAME:     Setup - Create [dbo].[t_w3_schools_customers]
  PURPOSE:  Materialize the W3 Schools Customers view into a physical table
            using SELECT INTO, so we have a real table to practice functions on.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3

  RUNTIME: ~1s

  NOTES:
  Run the view creation script (dbo.v_w3_schools_customers.sql) FIRST,
  then run this script to create the physical table.
*******************************************************************************/

-- Step 1: Run the view script first (dbo.v_w3_schools_customers.sql)
-- Then materialize it:

IF OBJECT_ID('dbo.t_w3_schools_customers', 'U') IS NOT NULL
    DROP TABLE dbo.t_w3_schools_customers;
GO

SELECT *
  INTO dbo.t_w3_schools_customers
  FROM dbo.v_w3_schools_customers;
GO

-- Verify
SELECT TOP 5 *
  FROM dbo.t_w3_schools_customers;
GO
