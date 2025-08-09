SELECT 
  sub.Month,
  sub.Year,
  CASE
    WHEN sub.numeric_val >= 1000000000 THEN 
      CONCAT(ROUND(sub.numeric_val / 1000000000, 2), ' Billion')
    WHEN sub.numeric_val >= 1000000 THEN 
      CONCAT(ROUND(sub.numeric_val / 1000000, 2), ' Million')
    WHEN sub.numeric_val >= 1000 THEN 
      CONCAT(ROUND(sub.numeric_val / 1000, 2), ' Thousand')
    ELSE 
      ROUND(sub.numeric_val, 2)
  END AS Gross_sale_amount
FROM (
  SELECT 
    CONCAT(MONTHNAME(fsm.date), "(", YEAR(fsm.date), ")") AS Month,
    fsm.fiscal_year AS Year,
    SUM(fsm.sold_quantity * fg.gross_price) AS numeric_val
  FROM fact_sales_monthly fsm
  JOIN dim_customer dm 
    ON fsm.customer_code = dm.customer_code
  JOIN fact_gross_price fg
    ON fsm.product_code = fg.product_code AND fsm.fiscal_year = fg.fiscal_year
  WHERE dm.customer = "Atliq Exclusive"
  GROUP BY Month, Year
) AS sub
ORDER BY sub.numeric_val asc;
