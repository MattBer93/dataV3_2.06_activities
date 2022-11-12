-- Activity 1

use bank;

-- Get different card types
select distinct type from card;

-- Get transactions in the first 15 days of 1993.
select * from trans
where substring(date, 1, 2) = 93
order by date asc
limit 15;

-- Get all running loans.
select * from loan
where status = 'C' or status = 'D';

-- Find the different values from the field A2 that start with the letter 'K'.
select A2 from district
where A2 regexp '^K';

-- Find the different values from the field A2 that end with the letter 'K'.
select A2 from district
where A2 regexp 'K$'; -- It was mentioned that Regex is case sensitive, why do we get results with lowercase k?

-- Discuss the possible use cases of using regular expressions in your query.
-- We might want to look for some given substrings and replace them, if we found out for example that there was a mistake in inputting data in the DB. 
-- Regex is also useful to remove some parts of text, isolate them,  and manipulate matchin entries in al sort of ways.

-- --------------------------------

-- Acitivity 2

-- Compare following Queries
-- %M% find M in any position
-- This query includes North Bohemia
select * from bank.district
where a3 like 'north%M%';

-- _M finds M after 1 character after North
-- This query includes North Moravia only
select * from bank.district
where a3 like 'north_M%';

-- Can you modify the query to print the rows only for those values in the A2 column that starts with 'CH'?
select * from bank.district
where a2 regexp 'ch[e-r]';

select * from bank.district
where a2 regexp '^ch[e-r]';

-- Use the table trans for this query. Use the column type to test: "By default, in an ascending sort, special characters appear first, followed by numbers, and then letters."
select type from trans
group by type; -- cannot test, there are no numbers or special characters in the type column?

-- Again use the table trans for this query. Use the column k_symbol to test: "Null values appear first if the order is ascending."
select k_symbol from trans
order by k_symbol asc; -- TRUE

-- Pick any table and any column to test: "You can use any column from the table to sort the values even if that column is not used in the select statement." 
-- Check the difference by writing the query with and without that column (column used to sort the results) in the select statement.
-- The sorting order doesn't change if I select or not the column I am using to sort
select account_id, date from account
order by date;

select account_id from account
order by date;

-- -- --------------------------------

-- Activity 3

-- 1 During the lesson, we mentioned that one of the primary reasons for NORMALIZING tables is to eliminate data redundancy. 
-- Otherwise, data redundancy can result in highly inefficient data storages. Which other problems you may think non-normalized structure may have?

-- Data Normalization has both its pros and cons. As advantages we can mention is that after normalisation, the DB becomes smaller (because we removed duplicates and redundant data)
-- and therefore quicker to navigate though and to maintain.
-- Some disadvantages of normalisation is that it causes creation of several more tables, and therefore becomes less user-friendly. A high level of expertees is required 
-- to navigate though a database with several tables, or to create one. If expertee is not high enough, the risk is to build a chaotic database.


-- 2 Later in the labs we will use another database that models a DVD rental store. 
-- ERD (entity relationship diagram) for the database is shown below. You can refer the file sakila-schema.pdf in the files_for_activities folder as well.
-- Identify the primary keys and foreign keys from the ER diagram.

-- PRIMARY KEYS
	-- All the first Ids in tables

-- SECONDARY KEYS
	-- All the Ids that come after the first one
    
-- -- --------------------------------

-- Activity 4

-- Referential Integrity is conserved

-- 2) Now use the bank database to make the following changes:
use bank;
-- a. Use the insert command to create a new entry in the loan table with the following values (8000,8000000,930705,96396,12,8033.0,'C'). 
-- Here each element corresponds to the values in columns in the table (in the order the columns appear in the table). 
-- This might raise an error. Why is that?
insert into loan
values (8000,8000000,930705,96396,12,8033.0,'C');
-- It didn't raise an error - but I guess it could raise one if we didn't provide the model to create new rows in the table 

-- b. Use the delete command to delete an entry from the table account where the account_id is 11382. 
-- Does this result in an error? If it does, then why?
delete from account where account_id = 11382;
-- no error

-- 3) Create the rest of the tables in the bank database (at least the client and the card tables)
-- They already exist? If I needed to create them, I would use this model (https://www.w3schools.com/mysql/mysql_create_table.asp)

-- 4) Design and create a new database structure. Justify your changes.
-- Some ideas include renaming columns to ones that make more sense and, for eg., in the table district, adding foreign keys wherever necessary.
create database if not exists bank_demo;
use bank_demo;

create table account (
  `account_id` int UNIQUE NOT NULL, -- AS PRIMARY KEY
  `district_id` char(20) DEFAULT NULL,
  `frequency` varchar(20) DEFAULT NULL, -- char() , varchar(255) / They are similar, but char can have as many characters as needed, varchar can have only 255
  `date` int DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (account_id)  -- constraint keyword is optional but its a good practice
);

create table card (
	`card_id` int unique not null, -- setting primary key
    `disp_id` int default null, -- I think an int for an ID is more appropriate
    `type` varchar(15), -- I don't offer card with a long name
    `issue_date` int default null,
    constraint primary key (card_id) -- card_id is the primary key
);

-- etc
















