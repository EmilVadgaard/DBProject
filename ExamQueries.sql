/* (i)
*/
SELECT EXTRACT(MONTH FROM Date) AS Month, SUM(value) AS TotalValue
FROM Sale JOIN Sale_Of_Product ON
    Sale.SaleID = Sale_Of_Product.SaleID
WHERE EXTRACT(YEAR FROM Date) = 2023
GROUP BY EXTRACT(MONTH FROM Date)
ORDER BY Month;

/* (ii)
*/
SELECT SaleID, (Value*Quantity) AS Value
FROM Sale_Of_Product
WHERE (Value*Quantity) >= ALL(
    SELECT Value*Quantity
    FROM Sale_Of_Product
);

/* (iii)
*/
WITH SaleProdCategory AS(
    SELECT P1.ProductID, P1.CategoryID, Quantity, Date
	FROM ((Product P1 JOIN Product_Category P2 ON
	P1.CategoryID = P2.CategoryID) JOIN Sale_Of_Product S1 ON
		P1.ProductID = S1.ProductID) JOIN Sale S2 ON
			S1.SaleID = S2.SaleID
)

(SELECT CategoryID, SUM(Quantity)
FROM SaleProdCategory
WHERE EXTRACT(YEAR FROM Date) = 2023
GROUP BY CategoryID
HAVING SUM(Quantity) >= ALL(
    SELECT SUM(Quantity)
    FROM SaleProdCategory
    WHERE EXTRACT(YEAR FROM Date) = 2023
    GROUP BY CategoryID
))
	UNION
(SELECT CategoryID, SUM(Quantity)
FROM SaleProdCategory
WHERE EXTRACT(YEAR FROM Date) = 2023
GROUP BY CategoryID
HAVING SUM(Quantity) <= ALL(
    SELECT SUM(Quantity)
    FROM SaleProdCategory
    WHERE EXTRACT(YEAR FROM Date) = 2023
    GROUP BY CategoryID
));

/* (iv)
*/
SELECT P1.ProductID, COALESCE(SUM(S.Quantity * S.Value), 0)
	- COALESCE(SUM(P2.Quantity * S.Value), 0)
	- COALESCE(SUM(P1.Quantity * P1.Value), 0) AS Profit
FROM (Product_Supply P1 FULL OUTER JOIN Sale_Of_Product S ON 
	P1.ProductID=S.ProductID) FULL OUTER JOIN Product_Return P2 ON
    	P1.ProductID=P2.ProductID
GROUP BY P1.ProductID
HAVING COALESCE(SUM(S.Quantity * S.Value), 0)
	- COALESCE(SUM(P2.Quantity * S.Value), 0)
	- COALESCE(SUM(P1.Quantity * P1.Value), 0) >= ALL(
	SELECT COALESCE(SUM(S.Quantity * S.Value), 0)
	- COALESCE(SUM(P2.Quantity * S.Value), 0)
	- SUM(P1.Quantity * P1.Value) AS Profit
	FROM (Product_Supply P1 FULL OUTER JOIN Sale_Of_Product S ON 
		P1.ProductID=S.ProductID) FULL OUTER JOIN Product_Return P2 ON
    		P1.ProductID=P2.ProductID
	GROUP BY P1.ProductID);

/* (v)
*/
WITH SupplySaleSameMonth AS(
	SELECT Product.CategoryID, EXTRACT(MONTH FROM Sale.Date) AS Month,
		COALESCE(SUM(Sale_Of_Product.Quantity * Sale_Of_Product.Value), 0) AS SaleTotalValue,
		COALESCE(SUM(Product_Return.Quantity * Sale_Of_Product.Value), 0) AS ReturnTotalValue,
		COALESCE(SUM(Product_Supply.Quantity * Product_Supply.Value), 0 ) AS SupplyTotalValue
	FROM ((((Supply JOIN Product_Supply ON
		Supply.InvoiceID = Product_Supply.InvoiceID) FULL OUTER JOIN (Sale JOIN Sale_Of_Product 
														   ON Sale.SaleID = Sale_Of_Product.SaleID) ON 
			Sale_Of_Product.ProductID = Product_Supply.ProductID AND 
			EXTRACT(MONTH FROM Sale.Date) = EXTRACT(MONTH FROM Supply.Date) AND
		 	EXTRACT(YEAR FROM Sale.Date) = EXTRACT(YEAR FROM Supply.Date))
		FULL OUTER JOIN Product_Return ON
			Sale.SaleID = Product_Return.SaleID) JOIN Product ON
				Product.ProductID = Sale_Of_Product.ProductID) JOIN Product_Category ON
					Product.CategoryID = Product_Category.CategoryID
	WHERE EXTRACT(YEAR FROM Sale.Date) = 2023
	GROUP BY Product.CategoryID, EXTRACT(MONTH FROM Sale.Date)
)

SELECT Month, CategoryID, (SaleTotalValue - ReturnTotalValue) - SupplyTotalValue AS Profit
FROM SupplySaleSameMonth;