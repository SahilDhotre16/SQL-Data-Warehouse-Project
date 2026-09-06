/*
Silver layer stored procedure from Bronze to silver
====================================================
purpose : This stored procedure perform ETL process
to Extract data from Bronze and to TRANSFORM the data 
and LOAD into Silver layer 
====================================================
*/

create or alter procedure silver.load_silver as 
Begin
	print '>>Truncating table silver.crm_cust_info<<';
	truncate table silver.crm_cust_info
	print '================================';
	print 'Inserting into silver cust_info';
	print '================================';
	insert into silver.crm_cust_info(
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date)
	select cst_id,
			cst_key,
			TRIM(cst_firstname) as cst_firstname,
			TRIM(cst_lastname) as cst_lastname,
	case when upper(TRIM(cst_marital_status)) = 'S' then 'Single'
		 when upper(TRIM(cst_marital_status)) = 'M' then 'Married'
		 else 'N/A'
		 end cst_marital_status,

	case when upper(TRIM(cst_gender)) = 'F' then 'Female'
		  when upper(TRIM(cst_gender)) = 'M' then 'Male'
		else 'Unknown'
	end cst_gender,
	cst_create_date
	from (	
	select*,
	row_Number() over (partition by cst_id order by cst_create_date) as last_Flag
	from bronze.crm_cust_info
	)t
	where last_Flag = 1;


	print '>>Truncating table silver.crm_prd_info<<';
	truncate table silver.crm_prd_info
	print '============================';
	print 'Inserting crm_prd_info';
	print '============================';
	insert into silver.crm_prd_info ( 
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt)
	select prd_id,
		   replace(substring(prd_key, 1,5), '-' , '_') as Cat_id,
		   substring(prd_key, 7,len(prd_key)) as prd_key,
		   prd_nm,
		   isnull(prd_cost,0) as prd_cost,
		 case when upper(TRIM(prd_line)) = 'M' then 'Mountain'
			  when upper(TRIM(prd_line)) = 'R' then 'Road'
			  when upper(TRIM(prd_line)) = 'S' then 'Other Sales'
			  when upper(TRIM(prd_line)) = 'T' then 'Touring'
		else 'n/a'
		end as prd_line,
		cast(prd_start_dt as date) as prd_start_dt,
		cast(LEAD(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as date) as prd_end_dt
	from bronze.crm_prd_info


	print '>>Truncating table silver.crm_sales_details<<';
	truncate table silver.crm_sales_details
	print '============================';
	print 'Inserting crm_sales_details';
	print '============================';
	insert into silver.crm_sales_details (
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price)
	select sls_ord_num ,
		   sls_prd_key,
		   sls_cust_id,
		case when sls_order_dt = 0 or len(sls_order_dt) != 8 then null
		   else cast(cast(sls_order_dt as varchar) as date)
		   end as sls_order_dt,

		case when sls_ship_dt = 0 or len(sls_ship_dt) != 8 then null
		   else cast(cast(sls_ship_dt as varchar) as date)
		   end as sls_ship_dt,

		case when sls_due_dt = 0 or len(sls_due_dt) != 8 then null
		   else cast(cast(sls_due_dt as varchar) as date)
		   end as sls_due_dt,

		case when sls_sales <= 0 or sls_sales is null or sls_sales != sls_price * ABS(sls_quantity)
				then sls_price * ABS(sls_quantity)
				else sls_sales
				end as sls_sales,

		   sls_quantity,

		case when sls_price < 0 or sls_price is null
			 then sls_sales/nullif(sls_quantity,0)
			 else sls_price
			 end as sls_price
	from bronze.crm_sales_details



	print '>>Truncating table silver.erm_cust_az12<<';
	truncate table silver.erp_cust_az12
	print '======================================';
	print 'Inserting into silver.erm_cust_az12'
	print '======================================';
	insert into silver.erp_cust_az12( cid,bdate, gen)
	select 
		 case when cid like '%NAS%' then substring(cid, 4, len(cid)) 
		  else cid
		  end as cid,
		case when bdate > getdate() then null
		  else bdate
		  end as bdate,
		case when upper(TRIM(gen))in  ('F', 'FEMALE') then 'Female'
			 when upper(TRIM(gen))in  ('F', 'MALE') then 'Male'
			 else 'n/a'
			 end as gen
	from bronze.erm_cust_az12


	print '>>Truncating table silver.erm_loc_a101<<';
	truncate table silver.erp_loc_a101
	print'================================';
	print 'Inserting into silver.erm_loc_a101';
	print '================================';
	insert into silver.erp_loc_a101( cid,cntry)
	select 
		replace(cis, '-', '') as cid,
		case when trim(cntry) = 'DE' then 'Germany'
			 when trim(cntry) in ('US', 'USA') then ' United States'
			 when trim(cntry) = '' or cntry IS NULL then 'n/a'
			 else trim(cntry)
			 end as cntry 
	from bronze.erm_loc_a101

	select * from silver.erp_loc_a101



	print '>>Truncating table silver.erm_px_cat_g1v2<<';
	truncate table silver.erp_px_cat_g1v2
	print '================================';
	print 'Inserting into silver.erm_px_cat_g1v2';
	print '================================';
	insert into silver.erp_px_cat_g1v2(id, cat, subcat, maintenance)
	select id, cat, subcat, maintenance from bronze.erm_px_cat_g1v2
End
