/* 
====================================================
              DDL Script - Purpose
====================================================
this script i used to create tables for bronze layer ,
and to run this script to re-define DDL structure of this layer tables

=================================================== */
create or alter procedure bronze.load_bronze as 
begin
	begin try 
		print '==================================';
			  print 'Loading Bronze';
		print '==================================';

		print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
			  print 'Loading CRM tables';
		print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';

	print '>>>Truncating table :bronze.crm_cust_info<<<';
		truncate table bronze.crm_cust_info;
	print 'INSERING INTO TABLE bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\sahil dhotre\Downloads\DEproject\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	print '>>>Truncating table :bronze.crm_prd_info<<<';
		truncate table bronze.crm_prd_info;
	print 'INSERING INTO TABLE bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info	
		from 'C:\Users\sahil dhotre\Downloads\DEproject\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	print '>>>Truncating table :bronze.crm_sales_details<<<';
		truncate table bronze.crm_sales_details;
	print 'INSERING INTO TABLE bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details	
		from 'C:\Users\sahil dhotre\Downloads\DEproject\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
			  print 'Loading CRM tables';
	print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';

	print '>>>Truncating table :bronze.erm_cust_az12<<<';
		truncate table bronze.erm_cust_az12;
	print 'INSERTING DATA INTO bronze.erm_cust_az12';
		BULK INSERT bronze.erm_cust_az12	
		from 'C:\Users\sahil dhotre\Downloads\DEproject\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	print '>>>Truncating table :bronze.erm_loc_a101<<<';
		truncate table bronze.erm_loc_a101;
	print 'INSERTING DATA INTO bronze.erm_loc_a101';
		BULK INSERT bronze.erm_loc_a101	
		from 'C:\Users\sahil dhotre\Downloads\DEproject\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	print '>>>Truncating table :bronze.erm_px_cat_g1v2<<<';
		truncate table bronze.erm_px_cat_g1v2;
	print 'INSERTING DATA INTO bronze.erm_px_cat_g1v2';
		BULK INSERT bronze.erm_px_cat_g1v2
		from 'C:\Users\sahil dhotre\Downloads\DEproject\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		end try
	begin catch 
		print'============================'
		print 'Error Occured While Laoding The Bronze'
		print 'Error Message'+ cast(ERROR_MESSAGE() as varchar);
		print 'Error Code'+ ERROR_NUMBER();
		print'============================'
	end catch 
end 
EXEC bronze.load_bronze;
GO


