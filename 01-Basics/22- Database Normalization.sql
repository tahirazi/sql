--Database Normalization
-- The process of organizing data to minimize data redundancy (data duplication), which in turn ensures data consistency.
-- Database normalization is a step by step process. There are 6 normal forms, First Normal form (1NF) thru Sixth Normal Form (6NF). 
-- Most databases are in third normal form (3NF). There are certain rules, that each normal form should follow.

----Data Redundancy Problems
------ Disk space wastage
------ Data become inconsistent
------ DML queries may become slow, as there may be many records and columns to process.

--First Normal Form (1NF)
---- 1. The data in each column should be atomic. No multiple values, sepearated by comma.
---- 2. The table does not contain any repeating column groups
---- 3. Identify each record uniquely using primary key.

--Second Normal Form (2NF)
---- 1. The table meets all the conditions of 1NF
---- 2. Move redundant data to a separate table
---- 3. Create relationship between these tables using foreign keys.

--Third Normal Form (3NF)
---- 1. Meets all the conditions of 1NF and 2NF
---- 2. Does not contain columns (attributes) that are not fully dependent upon the primary key (e.g annual salary)

