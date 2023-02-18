USE adventureworks2019

go

WITH order_item
     AS (SELECT DISTINCT a.customerkey,
                         a.orderdatekey,
                         a.productkey,
                         b.englishproductname AS ProductName
         FROM   [AdventureWorksDW2019].[dbo].[factinternetsales] a
                INNER JOIN [AdventureWorksDW2019].[dbo].[dimproduct] b
                        ON a.productkey = b.productkey)
SELECT c.productname,
       d.productname,
       Count(*) frequency
FROM   order_item c
       INNER JOIN order_item d
               ON c.customerkey = d.customerkey
                  AND c.orderdatekey = d.orderdatekey
WHERE  c.productname < d.productname
GROUP  BY c.productname,
          d.productname
ORDER  BY Count(*) DESC
