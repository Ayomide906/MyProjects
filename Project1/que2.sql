SELECT 
    unique_product_2020,
    unique_product_2021,
    ((unique_product_2021 - unique_product_2020) / unique_product_2020) * 100 AS percentage_chg
FROM (
    SELECT 
        SUM(CASE WHEN fiscal_year = 2020 THEN sold_quantity END) AS unique_product_2020,
        SUM(CASE WHEN fiscal_year = 2021 THEN sold_quantity END) AS unique_product_2021
    FROM fact_sales_monthly
) AS sub;
select * from fact_sales_monthly;
SELECT sum(sold_quantity) as sum from fact_sales_monthly
where fiscal_year=2020