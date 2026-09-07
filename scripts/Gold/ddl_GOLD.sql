/* Gold Layer
=======================================================================
purpose - This script creates views for the GOLD layer
in the data warehouse .it represents the final schema of this project 
whch is start scehma 
Here all dataset are transformed and combined from silver layer
to produce the final cleaned enriched dataset
=======================================================================
*/

print '===============================';
print'creating View for Dim_customers';
print'================================';
GO
create view Gold.dim_customers as
select 
	   ROW_NUMBER() over(order by cst_id) as customer_sr_no,
	   cu.cst_id as customer_id,
	   cu.cst_key as customer_key,
	   cu.cst_firstname as first_name,
	   cu.cst_lastname as last_name,
	   loc.cntry as country,
	   cu.cst_gndr as gender,
	   cu.cst_marital_status as marital_status,
	   ecus.bdate as birth_date,
	   cu.cst_create_date as create_date
	from silver.crm_cust_info cu
	left join silver.erp_cust_az12 ecus
	on cu.cst_key = ecus.cid
	left join silver.erp_loc_a101 loc
	on cu.cst_key = loc.cid

GO

print '===============================';
print'creating View for Dim_products';
print'================================';

select * from silver.erp_px_cat_g1v2
GO
create view Gold.dim_products as 
select 
	ROW_NUMBER() over(order by prd.prd_start_dt,prd_key) as product_srno,
	prd.prd_id as product_id,
	prd.prd_key as product_key,
	prd.prd_nm as product_name,
	prd.cat_id as category_id,
	cat.cat as category,
	cat.subcat as subcategory,
	prd.prd_line as product_line,
	prd.prd_cost as product_cost,
	cat.maintenance,
	prd.prd_start_dt as starting_date
from silver.crm_prd_info prd
left join silver.erp_px_cat_g1v2 cat
on prd.cat_id = cat.id
where prd_end_dt is null

GO

print '===============================';
print'creating View for Fact_sales';
print'================================';

select * from silver.crm_sales_details
select * from silver.crm_cust_info
select * from silver.crm_prd_info

GO

create view Gold.fact_sales as 
select
	sl.sls_ord_num as order_number,
	dp.product_srno,
	dc.customer_sr_no,
	sl.sls_order_dt as order_date,
	sl.sls_ship_dt as shipping_date,
	sl.sls_due_dt as due_date,
	sl.sls_sales as sales,
	sl.sls_quantity as Quantity,
	sl.sls_price as price
from silver.crm_sales_details sl
left join gold.dim_products dp
on sl.sls_prd_key = dp.product_key
left join gold.dim_customers dc
on sl.sls_cust_id = dc.customer_id
