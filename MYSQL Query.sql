create database prod;

use prod;

SELECT * FROM prod.`prod+env+inventory+dataset`;

update prod.`prod+env+inventory+dataset`
set `Product ID` = 7 where `Product ID` = 21;

update prod.`prod+env+inventory+dataset`
set `Product ID` = 11 where `Product ID` = 22;

SELECT * FROM prod.products;

-- Now we prep the data for power bi 

create table new_table as
select 
a.`Order Date (DD/MM/YYYY)` as `Order_Date_DD_MM_YYYY`,
a.`Product ID` as Product_ID,
a.Availability,
a.Demand,
b.`Product Name` as Product_Name,
b.`Unit Price ($)` as Unit_Price
from prod.`prod+env+inventory+dataset` as a left join prod.products as b
on a.`Product ID` = b.`Product ID`;

-- So we have to give same alias name because the column and table name
-- should match with power bi report data

SELECT * FROM prod.new_table;