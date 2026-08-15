--Creating Test Environment

create database test_env

use test_env

--imported the flat file in the test_env

select * from Products

select * from [Test+Environment+Inventory+Dataset]

select distinct Order_Date_DD_MM_YYYY from [Test+Environment+Inventory+Dataset]

select distinct Product_ID from [Test+Environment+Inventory+Dataset]

select distinct Availability from [Test+Environment+Inventory+Dataset]

select distinct Demand from [Test+Environment+Inventory+Dataset]

--Using Left Join to join tables using a common column which is product ID


select a.Order_Date_DD_MM_YYYY,a.Product_ID,a.Availability,a.Demand,b.Product_Name,b.Unit_Price
from [Test+Environment+Inventory+Dataset] as a left join Products as b on a.Product_ID=b.Product_ID

--Now inserting the joined data in new table 

select * into new_table from 
(select a.Order_Date_DD_MM_YYYY,a.Product_ID,a.Availability,a.Demand,b.Product_Name,b.Unit_Price
from [Test+Environment+Inventory+Dataset] as a left join Products as b on a.Product_ID=b.Product_ID
)x

select * from new_table

--Now for reporting importing this data into powerbi

--Created the Power BI Report 

---------------------------------------------------------------


--creating production database

create database PROD

use PROD

select * from [dbo].[Prod+Env+Inventory+Dataset]

select distinct Order_Date_DD_MM_YYYY from [Prod+Env+Inventory+Dataset]
where Order_Date_DD_MM_YYYY is null or Order_Date_DD_MM_YYYY = ''

select distinct Product_ID from [Prod+Env+Inventory+Dataset]
--where Order_Date_DD_MM_YYYY is null or Order_Date_DD_MM_YYYY = ''

--The Production Dataset we can see there are two extra Product ID (22)

select * from [Products+(1)]

--The Product table only has 20 Product ID


--Updated Response from the data engineer team is 
--Product ID 21 ---> 7
--Product ID 22 ---> 11

update [Prod+Env+Inventory+Dataset]
set Product_ID = 7 where Product_ID= 21

update [Prod+Env+Inventory+Dataset]
set Product_ID = 11 where Product_ID= 22

select distinct Availability from [Prod+Env+Inventory+Dataset]
where Availability is null or Availability = ''

select distinct Demand from [Prod+Env+Inventory+Dataset]
where Demand is null or Demand = ''

------------------------------------

--Production Data Prep

select * into new_table from 
(select a.Order_Date_DD_MM_YYYY,a.Product_ID,a.Availability,a.Demand,b.Product_Name,b.Unit_Price
from [Prod+Env+Inventory+Dataset] as a left join [Products+(1)] as b on a.Product_ID=b.Product_ID
)x

--Updating PowerBI Report with this new data by updating source setting
--Table name and Column name should remain to update report in Power BI 
