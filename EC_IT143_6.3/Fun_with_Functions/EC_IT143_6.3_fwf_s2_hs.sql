-- USE [EC_IT143_DA]
-- GO

/*******************************************************************************
  Object:  Fun with Functions - Step 2: Begin creating an answer
  Script Date: 06/12/2026

  NAME:     EC_IT143_6.3_fwf_s2_hs.sql
  PURPOSE:  Step 2 - Think through what I already know and the next
            logical step toward an answer.

  MODIFICATION LOG:
  Ver    Date        Author   Description
  -----  ----------  -------  ---------------------------------------------------
  1.0    06/12/2026  HS       1. Built this script for EC IT143 Assignment 6.3

  RUNTIME: N/A - this is a planning/thinking step

  NOTES:
  Where I am now:
  - I know the ContactName column contains "FirstName LastName" values.
  - I need to split the string at the space character.

  What I think the next step is:
  - T-SQL has string functions: CHARINDEX finds the position of a character,
    and LEFT/SUBSTRING can extract part of a string.
  - To get the FIRST NAME: use LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
    This gives me everything to the LEFT of the first space.
  - Next step: write an ad hoc query to test this logic.
*******************************************************************************/

-- Q1: How do I extract the first name from ContactName?
-- A1: Use LEFT() combined with CHARINDEX() to find the space position.
--     LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
--     gives everything before the first space = the first name.
