CREATE TABLE Product (
    ProductID int PRIMARY KEY,
    CategoryID int,
    ProductName varChar(50),
    Description varChar(255)
)

CREATE TABLE Product_Category (
    CategoryID int PRIMARY KEY,
    Name varChar(50),
    Description varChar(255)
)

CREATE TABLE Supplier (
    SupplierVAT varchar(20) PRIMARY KEY,
    SupplierName varChar(50),
    Address varChar(100),
    Phone char(18),
    Email varchar(50)
)

CREATE TABLE Supply (
    InvoiceID int PRIMARY KEY,
    SupplierVAT varchar(20),
    Date DATE
)

CREATE TABLE Product_Supply (
    InvoiceID int PRIMARY KEY,
    ProductID int,
    Quantity int,
    Value int
)

CREATE TABLE Sale (
    SaleID int PRIMARY KEY,
    Date DATE
)

CREATE TABLE Sale_of_Product (
    SaleID int PRIMARY KEY,
    ProductID int,
    Quantity int,
    Value int
)

CREATE TABLE Product_Return (
    SaleID int PRIMARY KEY,
    ProductID int,
    Date DATE,
    Quantity int
)

CREATE TABLE Stock (
    ProductID int PRIMARY KEY,
    Quantity int
)