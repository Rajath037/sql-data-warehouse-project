/*
--------------------------------------------------
Create database and Schemas
--------------------------------------------------

Script purpose : 
	This script creates a new database named 'Datawarehouse' after checking if it already exists.
	If database exists, it is dropped and recreateed. Additionally this scripts sets up three schemas 
	within the database : 'bronze','silver' and 'gold'.

WARNING: 
	Running this scripts will drop the entire 'datawarehouse' database if it exists.
	All the data in the database wil be permanently deleted. Proceed with caution.
	and ensure we have proper backups before running the scripts.
*/


USE master;
GO

--Drop and recreate the 'DataWareHouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name=	'DataWareHouse')
BEGIN 
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

--Create the DataWareHouse database 

CREATE DATABASE DataWareHouse;
GO


USE DataWarehouse;
GO

--Create Schemas 


CREATE Schema bronze;
GO
CREATE Schema silver;
GO
CREATE Schema gold;
GO
