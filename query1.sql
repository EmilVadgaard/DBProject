SELECT 
	EXTRACT(MONTH FROM Date) AS Months, 
	SUM(Value) AS Total_Sales
FROM 
	Sale NATURAL JOIN Sale_of_Product
WHERE
	EXTRACT(YEAR FROM Date) = 2022
GROUP BY
	EXTRACT(MONTH FROM Date)
ORDER BY
	Months
    
--Lave et nyt table, some indeholder alle måneder hvor der faktisk blev solgt noget.
--For at udregne TotalValue, skal man blot i "Sale_of_Product", gange value med quantity.
--Så kan man gøre det samme i "Product_Supply" og "Product_Return", ligge disse 2 sammen,
--og trække dette fra værdien i udregnet i "Sale_of_Product".