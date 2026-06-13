-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 6: Compare UDF results to ad hoc query
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s6_hs.sql

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: CASE guard in ad hoc column
*******************************************************************************/

SELECT
    ContactName
  , CASE
        WHEN CHARINDEX(' ', ContactName) > 0
        THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        ELSE ContactName
    END                                       AS AdHocFirstName
  , dbo.ufn_get_first_name(ContactName)       AS UDFFirstName
  FROM dbo.t_w3_schools_customers
 ORDER BY CustomerName;
