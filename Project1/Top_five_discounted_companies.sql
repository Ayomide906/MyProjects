SELECT fpi.customer_code,customer,pre_invoice_discount_pct 
as average_discount_percentage 
FROM fact_pre_invoice_deductions fpi
RIGHT JOIN dim_customer dc
ON fpi.customer_code=dc.customer_code
WHERE dc.market="india" AND fpi.fiscal_year=2021
ORDER BY average_discount_percentage desc
limit 5
