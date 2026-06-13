-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 5: Create a user-defined scalar function
  Script Date: 06/12/2026

  NAME:     dbo.ufn_get_first_name
  PURPOSE:  Extract the first name from a "FirstName LastName" string.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this function for EC IT143 Assignment 6.3
  1.1    06/13/2026  HS       2. Fixed: CASE guard for names with no space

  RUNTIME: ~1s
*******************************************************************************/

IF OBJECT_ID('dbo.ufn_get_first_name', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ufn_get_first_name;
GO

CREATE FUNCTION dbo.ufn_get_first_name
(
    @full_name VARCHAR(100)
)
RETURNS VARCHAR(50)
AS
BEGIN

    DECLARE @first_name VARCHAR(50);

    SET @first_name = CASE
                          WHEN CHARINDEX(' ', @full_name) > 0
                          THEN LEFT(@full_name, CHARINDEX(' ', @full_name) - 1)
                          ELSE @full_name   -- no space: whole value is the first name
                      END;

    RETURN @first_name;

END;
GO

-- Smoke test
SELECT dbo.ufn_get_first_name('Maria Anders') AS TestResult;
-- Expected: Maria
GO
