/*
Jeg vil have et skema, hvor der er en tuple kombination for hver månede med alle Kategorier.
Får hver tuple skal der være en profit for hvad der er tjent på den pågældende månede i den specifikke kategori.
Så jeg vil regne profit på hvert kategori for hver månede
*/
SELECT 
	EXTRACT(MONTH FROM Date),
	CategoryID,
	sp.Total_Sales - ps.value - COALESCE(rp.value, 0) AS Profit
FROM
    (
        SELECT 
            EXTRACT(MONTH FROM Date) AS Months,
            CategoryID,
            Total_Sales
        FROM
            (
            SELECT
                t2.Date,
                SUM(t1.Value * t1.Quantity) AS Total_Sales
            FROM
                Sale_of_Product t1
            LEFT JOIN
                Sale t2 ON t1.SaleID = t2.SaleID
            GROUP BY Date
            ) t1
                LEFT JOIN
            Product_Category t2 ON t1.ProductID = t2.ProductID
        GROUP BY CategoryID
    ) sp
LEFT JOIN
    (
        SELECT 
            EXTRACT(MONTH FROM Date) AS Months,
            CategoryID,
            SUM(Value)
        FROM
            Product_Supply
                LEFT JOIN
            Supply ON InvoiceID
                LEFT JOIN
            Product_Category ON ProductID
        GROUP BY CategoryID
    ) ps ON Months
LEFT JOIN
    (
        SELECT 
            EXTRACT(MONTH FROM Date) AS Months,
            CategoryID,
            SUM(value)
        FROM
            Product_Return
                LEFT JOIN
            Product_Category ON CategoryID
        GROUP BY CategoryID
    ) rp ON Months
    GROUP BY Months
    ORDER BY Months, CategoryID