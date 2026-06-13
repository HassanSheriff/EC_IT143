-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Triggers - Step 4: Create an after-update trigger (last_modified_date)
  Script Date: 06/12/2026

  NAME:     dbo.trg_customers_last_mod_date
  PURPOSE:  After any UPDATE on t_w3_schools_customers, automatically set
            the last_modified_date column to the current server date/time
            for the rows that were just modified.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this trigger for EC IT143 Assignment 6.3

  RUNTIME: ~1s

  NOTES:
  - Fires AFTER UPDATE on dbo.t_w3_schools_customers.
  - Uses the virtual "Inserted" table to identify which CustomerID rows changed.
  - GETDATE() returns the current server date and time.
*******************************************************************************/

IF OBJECT_ID('dbo.trg_customers_last_mod_date', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_customers_last_mod_date;
GO

CREATE TRIGGER dbo.trg_customers_last_mod_date
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS

    /*--------------------------------------------------------------------------
      NAME:    dbo.trg_customers_last_mod_date
      PURPOSE: Keep track of the last modified date for each row in the table
    --------------------------------------------------------------------------*/

    UPDATE dbo.t_w3_schools_customers
       SET last_modified_date = GETDATE()
     WHERE CustomerID IN
           (
               SELECT DISTINCT CustomerID
                 FROM Inserted
           );

GO
