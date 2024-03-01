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
(),
(),
(),
(),
();

INSERT INTO Supply (InvoiceID, SupplierVAT, Date)
VALUES
(),
(),
(),
(),
();

INSERT INTO Product_Supply (InvoiceID, ProductID, Quantity, Value)
VALUES
(301, 101,),
(301, 102,),
(301, 103,),
(301, 104,),
(301, 105,),
(301, 106,),
(301, 107,);

INSERT INTO Sale (SaleID, Date)
VALUES
(401, ),
(),
(),
(),
();

INSERT INTO Sale_of_Product (SaleID, ProductID, Quantity, Value)
VALUES
(),
(),
(),
(),
();

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