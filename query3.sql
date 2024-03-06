/*
En gantagelse af query2.sql
Jeg laver NATURAL JOIN mellem "Sale_of_Product" og "Product" (på ProductID)
Så laver jeg NATURAL JOIN fra denne liste med "Product_Category" (på CategoryID)
Dette gør jeg 2 gange, hvor den ene er sorteret, og den anden omvendt sorteret.
Så er begge begrænset til én tuple, og jeg laver Union på dette.
*/
(
SELECT CategoryID, Value
FROM 
	Product_Category
	NATURAL JOIN
	(
		SELECT CategoryID, Value
		FROM
			Sale_of_Product
			NATURAL JOIN
			Product
	) t2
ORDER BY Value DESC
LIMIT 1
)
UNION
(
SELECT CategoryID, Value
FROM 
	Product_Category
	NATURAL JOIN
	(
		SELECT CategoryID, Value
		FROM
			Sale_of_Product
			NATURAL JOIN
			Product
	)
ORDER BY Value
LIMIT 1
);
