/*
    Ideen er at JOIN alle 3 tabeller "Product_Supply", "Product_Return" og "Sale_of_Product",
    på ProductID og værdien gange antal solgte.
    Derved skal antal returnerede og antal købte trakkes fra det totale solgte.
*/
SELECT 
	ps.ProductID, 
	sp.TotalSales - (COALESCE(pr.TotalReturn, 0) + ps.TotalSupply)
FROM
	(
        SELECT
            ProductID,
            SUM(Quantity * Value) AS TotalSupply
        FROM
            Product_Supply
        GROUP BY
            ProductID
    ) ps 
LEFT JOIN
    (
        SELECT
            ProductID,
            SUM(Quantity * Value) AS TotalSales
        FROM
            Sale_of_Product
        GROUP BY
            ProductID
    ) sp ON sp.ProductID = ps.ProductID 
LEFT JOIN
    (
        SELECT
            t1.ProductID,
            SUM(t1.Quantity * t2.Value) AS TotalReturn
        FROM
            Product_Return t1 LEFT JOIN Sale_of_Product t2
		ON
			t1.ProductID = t2.ProductID
        GROUP BY
            t1.ProductID
    ) pr ON sp.ProductID = pr.ProductID
	ORDER BY ProductID;