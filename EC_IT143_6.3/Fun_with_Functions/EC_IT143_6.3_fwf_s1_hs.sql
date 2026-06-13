-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 1: Start with a question
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s1_hs.sql
  PURPOSE:  Step 1 of the scalar function method - ask the simplest,
            most focused question possible.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3

  RUNTIME: N/A - this is a documentation/question step

  NOTES:
  The hallmarks of a good Step 1 question: brevity, precision, singular focus.
*******************************************************************************/

-- Q1: How do I extract the first name from the ContactName column
--     in [dbo].[t_w3_schools_customers]?

-- Example data preview:
-- ContactName = 'Maria Anders'  --> First Name = 'Maria'
-- ContactName = 'Ana Trujillo'  --> First Name = 'Ana'

-- The first name is everything BEFORE the first space character.
