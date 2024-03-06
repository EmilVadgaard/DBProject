/*LAV TABEL*/

CREATE TABLE Product (
    ProductID int PRIMARY KEY,
    CategoryID int,
    ProductName varChar(50),
    Description varChar(255)
);

CREATE TABLE Product_Category (
    CategoryID int PRIMARY KEY,
    Name varChar(50),
    Description varChar(255)
);

CREATE TABLE Supplier (
    SupplierVAT varchar(20) PRIMARY KEY,
    SupplierName varChar(50),
    Address varChar(100),
    Phone char(18),
    Email varchar(50)
);

CREATE TABLE Supply (
    InvoiceID int PRIMARY KEY,
    SupplierVAT varchar(20),
    Date DATE
);

CREATE TABLE Product_Supply (
    InvoiceID int PRIMARY KEY,
    ProductID int,
    Quantity int,
    Value int
);

CREATE TABLE Sale (
    SaleID int PRIMARY KEY,
    Date DATE
);

CREATE TABLE Sale_of_Product (
    SaleID int PRIMARY KEY,
    ProductID int,
    Quantity int,
    Value int
);

CREATE TABLE Product_Return (
    SaleID int PRIMARY KEY,
    ProductID int,
    Date DATE,
    Quantity int
);

CREATE TABLE Stock (
    ProductID int PRIMARY KEY,
    Quantity int
);





/*INSERT I TABEL*/
INSERT INTO Product (ProductID, CategoryID, ProductName, Description)
VALUES
(101, 201, 'Macbook', 'Macbook is a PC made by Apple'),
(102, 202, 'Samsung S11', 'Samsung S11 is a phone made by Samsung'),
(103, 201, 'Dell XPS', 'Dell XPS is a PC made by Dell'),
(104, 204, 'Samsung 65" Smart TV', 'Samsung Smart TV made by Samsung'),
(105, 203, 'HP DeskJet 2800e', 'DeskJet is a Printer made by HP'),
(106, 201, 'HP EliteBook 865', 'EliteBook is a PC made by HP'),
(107, 205, 'Canon EOS R100', 'EOS R100 is a Camera made by Canon');

INSERT INTO Product_Category (CategoryID, Name, Description)
VALUES 
(201, 'PC', 'Personal Computers'),
(202, 'Phone', 'Mobile/Cellular Phones'),
(203, 'Printer', 'Different types of Printers'),
(204, 'TV', 'TeleVisions'),
(205, 'Camera', 'Different types of Cameras');

INSERT INTO Supplier (SupplierVAT, SupplierName, Address, Phone, Email)
VALUES 
('DK10000001', 'ElLeverandøren', 'Butiksvej 23 2620 Albertslund', '+4560510013', 'El@leverandøren.dk'),
('DK10000002', 'PowerSquared', 'Butiksvej 21 2620 Albertslund', '+4553343035', 'kontor@power2.dk'),
('DE123456789', 'Media Markt', 'TysklandStrasse 1 13187 Pankow', '+499234564381', 'Desk@MedMar.com'),
('NL123456789B01', 'Amazon', 'Langegracht 69-H 2312 NW Leiden', '+31-24-3611111', 'office@Amazon.nl'),
('GB123456789', 'Amazon', '27 Fox Lane RG17 9ZS Bockhampton', '+442071234567', 'office@Amazon.co.uk');

INSERT INTO Supply (InvoiceID, SupplierVAT, Date)
VALUES
(301, 'DK10000001', '2021-03-31'),
(302, 'DK10000002', '2021-06-12'),
(303, 'DE123456789', '2021-11-10'),
(304, 'NL123456789B01', '2021-08-05'),
(305, 'GB123456789', '2022-01-22'),
(306, 'DE123456789', '2021-04-27'),
(307, 'NL123456789B01', '2021-12-01'),
(308, 'DK10000002', '2021-02-28'),
(309, 'NL123456789B01', '2021-05-10'),
(310, 'DK10000001', '2021-09-30');

INSERT INTO Product_Supply (InvoiceID, ProductID, Quantity, Value)
VALUES
(301, 101, 200, 6000),
(302, 102, 50, 3000),
(303, 103, 20, 5000),
(304, 104, 75, 2000),
(305, 104, 60, 2300),
(306, 105, 42, 500),
(307, 106, 12, 1500),
(308, 107, 7, 4000),
(309, 107, 55, 2500),
(310, 102, 210, 2500);

INSERT INTO Sale (SaleID, Date)
VALUES
(401, '2022-03-31'),
(402, '2022-06-12'),
(403, '2022-11-10'),
(404, '2022-08-05'),
(405, '2023-01-22'),
(406, '2022-04-27'),
(407, '2022-12-01'),
(408, '2023-02-28'),
(409, '2022-05-10'),
(410, '2022-09-30');

INSERT INTO Sale_of_Product (SaleID, ProductID, Quantity, Value)
VALUES
(401, 101, 166, 11000),
(402, 102, 49, 6000),
(403, 103, 10, 8000),
(404, 103, 3, 10000),
(405, 105, 9, 800),
(406, 104, 3, 3499),
(407, 104, 110, 2200),
(408, 106, 12, 2200),
(409, 106, 1, 3200),
(410, 107, 45, 4500);

INSERT INTO Product_Return (SaleID, ProductID, Date, Quantity)
VALUES
(401, 101, '2023-04-03', 13),
(402, 102, '2023-06-24', 6),
(408, 106, '2024-03-01', 1),
(407, 104, '2023-12-09', 12),
(410, 107, '2023-11-15', 44);

INSERT INTO Stock (ProductID, Quantity)
SELECT ps.ProductID, ps.Intake - sp.Sales + COALESCE(pr.TotalReturn,0) FROM 
    (
        SELECT
            ProductID,
            SUM(Quantity) AS Intake
        FROM
            Product_Supply
        GROUP BY
            ProductID
    ) ps 
LEFT JOIN
    (
        SELECT
            ProductID,
            SUM(Quantity) AS Sales
        FROM
            Sale_of_Product
        GROUP BY
            ProductID
    ) sp ON sp.ProductID = ps.ProductID 
LEFT JOIN
    (
        SELECT
            ProductID,
            COALESCE(SUM(Quantity),0) AS TotalReturn
        FROM
            Product_Return
        GROUP BY
            ProductID
    ) pr ON sp.ProductID = pr.ProductID
	ORDER BY ProductID;





/*Opgaver*/
CREATE TABLE month_num(
	Num integer
);

INSERT INTO month_num
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);


/*1)*/
SELECT num AS Month, COALESCE(TotalValue, 0) AS TotalValue
FROM month_num 
		LEFT OUTER JOIN 
	(SELECT EXTRACT(MONTH FROM sale.date) AS Month, (quantity*value) AS TotalValue
	FROM sale JOIN sale_of_product AS sop ON sale.saleid = sop.saleid
	WHERE sale.saleid = sop.saleid AND EXTRACT(YEAR FROM sale.date) = 2022)
	 	ON month_num.num = month;


/*2)*/
SELECT saleid, SUM(quantity * value) AS Total
FROM sale_of_product AS sop
GROUP BY saleid
ORDER BY Total DESC
LIMIT 1;


/*3)*/
(SELECT prod.categoryid, SUM(sop.quantity) AS NumOfSoldItems
FROM(
	sale 
		JOIN 
	(SELECT saleid, productid, quantity 
	 FROM sale_of_product) AS sop 
	ON sale.saleid = sop.saleid
	)
		JOIN
	(SELECT productid, categoryid
	FROM product) AS prod
	ON sop.productid = prod.productid
WHERE EXTRACT(YEAR from sale.date) = 2022
GROUP BY prod.categoryid
ORDER BY NumOfSoldItems DESC
LIMIT 1)
	UNION
(SELECT prod.categoryid, SUM(sop.quantity) AS NumOfSoldItems
FROM(
	sale 
		JOIN 
	(SELECT saleid, productid, quantity 
	 FROM sale_of_product) AS sop 
	ON sale.saleid = sop.saleid
	)
		JOIN
	(SELECT productid, categoryid
	FROM product) AS prod
	ON sop.productid = prod.productid
WHERE EXTRACT(YEAR from sale.date) = 2022
GROUP BY categoryid
ORDER BY NumOfSoldItems
LIMIT 1);


/*4)*/
SELECT sop.productid, (((sop.quantity * sop.value) - (prodret.quantity * sop.value)) - (prodsup.quantity * prodsup.value)) AS Profit
FROM sale_of_product AS sop 
		JOIN
	product_return AS prodret
		ON sop.productid = prodret.productid
		JOIN
	product_supply AS prodsup
		ON sop.productid = prodsup.productid
GROUP BY sop.productid, sop.quantity, sop.value, prodret.quantity, prodsup.quantity, prodsup.value
ORDER BY Profit DESC


/*5)*/



/*Ekstra*/
SELECT *
FROM stock