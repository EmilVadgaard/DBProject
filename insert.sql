/*
PRODUCTS
"Macbook"
"Samsung S11"
"Dell XPS"
"Samsung 65" Smart TV"
"DeskJet 2800e"
"EliteBook 865"
"EOS R100"
""

CATEGORY
"PC"
"Phone"
"Printer"
"TV"
"Camera"

SUPPLIER
"Apple"
"Dell"
"Samsung"
"HP"
"Canon"
*/
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
('DK10000001', 'Elgiganten', 'Butiksvej 23 2620 Albertslund', '+4560510013', 'El@giganten.dk'),
('DK10000002', 'Power', 'Butiksvej 21 2620 Albertslund', '+4553343035', 'kontor@power.dk'),
('DE123456789', 'Media Markt', 'TysklandStrasse 1 13187 Pankow', '+499234564381', 'Desk@MedMar.com'),
('NL123456789B01', 'Amazon', null, 'Langegracht 69-H 2312 NW Leiden', '+31-24-3611111', 'office@Amazon.nl'),
('GB123456789', 'Amazon', null, '27 Fox Lane RG17 9ZS Bockhampton', '+442071234567', 'office@Amazon.co.uk');

INSERT INTO Supply (InvoiceID, SupplierVAT, Date)
VALUES
(301, 'DK10000001', 2023-03-31),
(302, 'DK10000002', 2023-06-12),
(303, 'DE123456789', 2023-11-10),
(304, 'NL123456789B01', 2023-08-05),
(305, 'GB123456789', 2024-01-22),
(306, 'DE123456789', 2023-04-27),
(307, 'NL123456789B01', 2023-12-01),
(308, 'DK10000002', 2024-02-29),
(309, 'NL123456789B01', 2023-05-10),
(310, 'DK10000001', 2023-09-30);

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
(401, 2023-03-31),
(402, 2023-06-12),
(403, 2023-11-10),
(404, 2023-08-05),
(405, 2024-01-22),
(406, 2023-04-27),
(407, 2023-12-01),
(408, 2024-02-29),
(409, 2023-05-10),
(410, 2023-09-30);

INSERT INTO Sale_of_Product (SaleID, ProductID, Quantity, Value)
VALUES
(401),
(402),
(403),
(404),
(405),
(406),
(407),
(408),
(409),
(410);

INSERT INTO Product_Return (SaleID, ProductID, Date, Quantity)
VALUES
(),
(),
(),
(),
();

INSERT INTO Stock (ProductID, Quantity)
VALUES
(),
(),
(),
(),
();