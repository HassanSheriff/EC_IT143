-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 4: Research and test a solution
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s4_hs.sql
  PURPOSE:  Step 4 - Research and refine before packaging into a UDF.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: CASE guard for no-space names

  RUNTIME: ~1s

  SOURCES USED:
  1. https://learn.microsoft.com/en-us/sql/t-sql/functions/left-transact-sql
  2. https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql
  3. https://stackoverflow.com/questions/2681789/how-to-split-a-string-to-get-the-first-word-in-tsql
*******************************************************************************/

SELECT
    ContactName
  , CHARINDEX(' ', ContactName)   AS SpacePosition
  , CASE
        WHEN CHARINDEX(' ', ContactName) > 0
        THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        ELSE ContactName
    END                           AS FirstName
  FROM dbo.t_w3_schools_customers
 ORDER BY CustomerName;
