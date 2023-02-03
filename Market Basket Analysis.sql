USE AdventureWorks2019
GO

WITH order_item AS (
SELECT DISTINCT
	a.CustomerKey
	,a.OrderDateKey
	,a.ProductKey
	,b.EnglishProductName as ProductName
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] a
INNER JOIN [AdventureWorksDW2019].[dbo].[DimProduct] b 
ON a.ProductKey = b.ProductKey
)

SELECT
	c.ProductName
	,d.ProductName
	,COUNT(*) frequency
FROM order_item c
INNER JOIN order_item d
ON c.CustomerKey = d.CustomerKey
AND c.OrderDateKey = d.OrderDateKey
WHERE 	c.ProductName < d.ProductName
GROUP BY 
	c.ProductName
	,d.ProductName
ORDER BY COUNT(*) DESC