SELECT *
FROM Warehouse.StockItems
WHERE UnitPrice <= ALL (SELECT UnitPrice 
FROM Warehouse.StockItems);

SELECT * 
FROM Warehouse.StockItems 
WHERE UnitPrice = (SELECT MIN(UnitPrice) 
FROM Warehouse.StockItems)