====================
created databse and schemas
====================
The purpose of this script - 
This scripts creates a new database with name name"Datawareshouseproj" here we did not checked if it's exists since i knew it doesn't exists
and additionally created 3 schemas within the database : 'bronze', 'silver', 'gold'.


use master;
-- creating Databse

Create Database DataWarehouseproj;
USE DataWarehouseproj;

-- ====================
-- creating schema
-- ====================
create schema bronze;
GO
create schema silver;
GO
create schema gold;
GO
