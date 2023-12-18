-- Creating the tables

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT
);

CREATE TABLE Wine (
    WineID INT PRIMARY KEY,
    Name VARCHAR(255),
    Type VARCHAR(255),
    Vintage YEAR,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    SupplierID INT,
    CategoryID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Date DATE,
    QuantitySold INT,
    Revenue DECIMAL(10, 2)
);

CREATE TABLE InventoryCheck (
    CheckID INT PRIMARY KEY,
    Date DATE,
    RecordedStock INT,
    ActualStock INT
);

CREATE TABLE OrderTable (
    OrderID INT PRIMARY KEY,
    Date DATE,
    ExpectedQuantity INT,
    ReceivedQuantity INT,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE SalesDetail (
    SaleID INT,
    WineID INT,
    QuantitySold INT,
    PriceAtSale DECIMAL(10, 2),
    PRIMARY KEY (SaleID, WineID),
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (WineID) REFERENCES Wine(WineID)
);


INSERT INTO Supplier (SupplierID, Name, ContactInfo) VALUES 
(1, 'Libation Project', 'contact@libationproject.com'),
(2, 'New France Wine Co', 'info@newfrance.com'),
(3, 'Bourget Imports', 'support@bourgetimports.com'),
(4, 'Rootstock Wine Co', 'sales@rootstock.com'),
(5, 'Mezzogiorno Wines', 'contact@mezzogiorno.com');

INSERT INTO Category (CategoryID, Name, Description) VALUES 
(1, 'Red', 'Red Wines including Merlot, Syrah'),
(2, 'White', 'White Wines including Chardonnay, Sauvignon'),
(3, 'Rose', 'Rose Wines'),
(4, 'Sparkling', 'Sparkling Wines including Champagne and Prosecco'),
(5, 'Dessert', 'Dessert Wines including Port and Sherry');

INSERT INTO Wine (WineID, Name, Type, Vintage, Price, StockQuantity, SupplierID, CategoryID) VALUES 
(1, 'Chateau Margaux', 'Merlot', 2018, 150.00, 20, 1, 1),
(2, 'Sebastien Riffault Sancerre', 'Sauvignon Blanc', 2019, 30.00, 30, 2, 2),
(3, 'De Moor Coteau de Rosette Chablis', 'Chardonnay', 2020, 25.00, 15, 3, 3),
(4, 'Dom Perignon', 'Champagne', 2016, 180.00, 10, 4, 4),
(5, 'Dows Vintage Port', 'Port', 2015, 40.00, 25, 5, 5),
(6, 'Silver Oak Cabernet', 'Cabernet Sauvignon', 2017, 120.00, 18, 1, 1),
(7, 'La Marca Prosecco', 'Prosecco', 2021, 22.00, 35, 2, 4);

INSERT INTO Sales (SaleID, Date, QuantitySold, Revenue) VALUES 
(1, '2023-03-01', 3, 450.00),
(2, '2023-03-02', 6, 180.00),
(3, '2023-03-03', 2, 360.00),
(4, '2023-03-04', 5, 125.00),
(5, '2023-03-05', 4, 80.00);

INSERT INTO InventoryCheck (CheckID, Date, RecordedStock, ActualStock) VALUES 
(1, '2023-03-10', 20, 19),
(2, '2023-03-11', 30, 30),
(3, '2023-03-12', 15, 14),
(4, '2023-03-13', 10, 11),
(5, '2023-03-14', 25, 25);

INSERT INTO OrderTable (OrderID, Date, ExpectedQuantity, ReceivedQuantity, SupplierID) VALUES 
(1, '2023-02-20', 20, 20, 1),
(2, '2023-02-21', 30, 28, 2),
(3, '2023-02-22', 15, 15, 3),
(4, '2023-02-23', 10, 11, 4),
(5, '2023-02-24', 25, 26, 5);

INSERT INTO SalesDetail (SaleID, WineID, QuantitySold, PriceAtSale) VALUES
(1, 1, 3, 150.00),
(2, 2, 6, 30.00),
(3, 3, 2, 25.00),
(4, 4, 5, 22.00),
(5, 5, 4, 40.00),
(1, 6, 2, 120.00),
(2, 7, 4, 22.00);

CREATE VIEW SupplierSales AS
SELECT s.SupplierID, s.Name, SUM(sd.QuantitySold) AS TotalQuantitySold
FROM Supplier s
JOIN Wine w ON s.SupplierID = w.SupplierID
JOIN SalesDetail sd ON w.WineID = sd.WineID
GROUP BY s.SupplierID;

SELECT c.Name, SUM(s.Revenue) AS TotalRevenue
FROM Category c
JOIN Wine w ON c.CategoryID = w.CategoryID
JOIN SalesDetail sd ON w.WineID = sd.WineID
JOIN Sales s ON sd.SaleID = s.SaleID
GROUP BY c.Name;

SELECT w.Name, w.Type, w.Vintage
FROM Wine w
WHERE w.SupplierID = 1; -- Assuming 1 is the SupplierID

SELECT w.Name, SUM(sd.QuantitySold) AS TotalSold
FROM Wine w
JOIN SalesDetail sd ON w.WineID = sd.WineID
GROUP BY w.Name
ORDER BY TotalSold DESC
LIMIT 5;

SELECT w.Name, (ic.ActualStock - w.StockQuantity) AS Discrepancy
FROM Wine w
JOIN InventoryCheck ic ON w.WineID = ic.WineID
WHERE ic.RecordedStock != w.StockQuantity;

SELECT s.Name, SUM(sd.QuantitySold) AS TotalSold
FROM Supplier s
JOIN Wine w ON s.SupplierID = w.SupplierID
JOIN SalesDetail sd ON w.WineID = sd.WineID
GROUP BY s.Name;

SELECT o.OrderID, (o.ExpectedQuantity - o.ReceivedQuantity) AS Discrepancy
FROM OrderTable o
WHERE o.ExpectedQuantity != o.ReceivedQuantity;

SELECT SaleID, Date, Revenue
FROM Sales
WHERE Date BETWEEN '2023-01-01' AND '2023-06-30';

SELECT Name, TotalQuantitySold
FROM SupplierSales
WHERE TotalQuantitySold > 100;

SELECT w.Name
FROM Wine w
LEFT JOIN SalesDetail sd ON w.WineID = sd.WineID
WHERE sd.SaleID IS NULL;

SELECT c.Name, AVG(w.Price) AS AveragePrice
FROM Category c
JOIN Wine w ON c.CategoryID = w.CategoryID
GROUP BY c.Name;
