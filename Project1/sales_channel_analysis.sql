SELECT `channel`,
concat(round(sub.gross_sales_mln/1000000,2)," Million") as gross_sales_mln,
ROUND((sub.gross_sales_mln * 100.0) / SUM(sub.gross_sales_mln) OVER (), 2) AS percentage
from (
SELECT channel as `channel`,sum(sold_quantity*gross_price) as gross_sales_mln
FROM fact_sales_monthly fsm
join fact_gross_price as fgh
on fgh.product_code=fsm.product_code and fsm.fiscal_year=fgh.fiscal_year
join dim_customer dc
on fsm.customer_code=dc.customer_code
where fsm.fiscal_year=2021
group by dc.channel
order by gross_sales_mln desc
) as sub;
