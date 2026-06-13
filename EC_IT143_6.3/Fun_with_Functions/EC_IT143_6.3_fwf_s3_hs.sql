-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 3: Create an ad hoc SQL query
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s3_hs.sql
  PURPOSE:  Step 3 - Write a quick ad hoc query to test the logic for
            extracting the first name from ContactName.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: added NULLIF guard for names with no space

  RUNTIME: ~1s

  NOTES:
  NULLIF(CHARINDEX(' ', ContactName), 0) returns NULL if there is no space,
  which prevents the -1 length crash on LEFT().
*******************************************************************************/

SELECT
    ContactName
  , CASE
        WHEN CHARINDEX(' ', ContactName) > 0
        THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        ELSE ContactName   -- no space found: treat whole name as first name
    END AS FirstName
  FROM dbo.t_w3_schools_customers;
