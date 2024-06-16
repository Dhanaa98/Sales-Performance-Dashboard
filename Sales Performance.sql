		-- Data Cleaning

select * from adidas_sales;


-- 1. Remove duplications

create table adidas_sales_staging
like adidas_sales;
insert adidas_sales_staging
select * from adidas_sales;

select * from adidas_sales_staging;

select 'Retailer', 'Retailer ID', 'Invoice Date', 'Region', 'State', 'City', 'Product', 'Price per Unit', 'Units Sold', 'Total Sales', 'Operating Profit', 'Operating Margin', 'Sales Method', count(*)
from adidas_sales_staging
group by 'Retailer', 'Retailer ID', 'Invoice Date', 'Region', 'State', 'City', 'Product', 'Price per Unit', 'Units Sold', 'Total Sales', 'Operating Profit', 'Operating Margin', 'Sales Method'
having count(*)> 1;

-- No Duplicates found


-- 2. Remove Null values

select * from adidas_sales_staging
	where 'Retailer' is null or
    'Retailer ID'  is null or
    'Invoice Date' is null or
    'Region' is null or
    'State' is null or
    'City' is null or
    'Product' is null or
    'Price per Unit' is null or
    'Units Sold' is null or
    'Total Sales' is null or
    'Operating Profit' is null or
    'Operating Margin' is null or
    'Sales Method' is null;
    
-- No Null or blank values found


-- 3. Standardizing data
    
select `Invoice Date`,
str_to_date(`Invoice Date`, '%m/%d/%Y')
from adidas_sales_staging ;
    
update adidas_sales_staging
set `Invoice Date` = str_to_date(`Invoice Date`, '%m/%d/%Y');

alter table adidas_sales_staging
modify column `Invoice Date` date;

update adidas_sales_staging 
set `Price per Unit` = replace(`Price per Unit`,'$', ' ');
update adidas_sales_staging 
set `Total Sales` = replace(`Total Sales`, '$',' ');

update adidas_sales_staging 
set `Operating Profit` = replace(`Operating Profit`, '$',' ');

-- 4. Validating data

select * from adidas_sales_staging
where `Units Sold`< 0;


-- 4. No columns to be removed

		-- Data is connected to PowerBi for more visualizations --
        


