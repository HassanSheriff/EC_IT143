-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 7: Perform a "0 results expected" test
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s7_hs.sql

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: CASE guard in CTE ad hoc column

  NOTES:
  Expect: 0 rows returned if UDF is working correctly.
*******************************************************************************/

WITH cte_compare AS
(
    SELECT
        ContactName
      , CASE
            WHEN CHARINDEX(' ', ContactName) > 0
            THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
            ELSE ContactName
        END                                     AS AdHocFirstName
      , dbo.ufn_get_first_name(ContactName)     AS UDFFirstName
      FROM dbo.t_w3_schools_customers
)
SELECT *
  FROM cte_compare
 WHERE AdHocFirstName <> UDFFirstName;   -- Expect: 0 rows
