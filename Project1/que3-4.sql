select segment, count(product_code) as product_count 
from dim_product
GROUP BY segment
order by product_count desc;
SELECT segment,product_count_2020,product_count_2021,
(product_count_2021-product_count_2020) as difference
from (SELECT segment,count(distinct case when fiscal_year=2020 then dm.product_code end) 
as product_count_2020, 
count(distinct case when fiscal_year=2021 then dm.product_code end) as product_count_2021
from dim_product dm
join fact_sales_monthly ft
on dm.product_code=ft.product_code
group by segment
) as sub
order by difference desc