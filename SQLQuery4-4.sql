--Выберите города (ид и название), в которые были доставлены товары, 
--входящие в тройку самых дорогих товаров, а также Имя сотрудника, который осуществлял упаковку заказов\



SELECT DISTINCT C.CityID, C.CityName, P.FullName FROM Application.Cities AS C
JOIN
(SELECT DeliveryCityID,CustomerID FROM Sales.Customers) AS D
ON C.CityID=D.DeliveryCityID
JOIN 
(SELECT CustomerID,OrderID, PackedByPersonID FROM Sales.Invoices) AS O
ON O.CustomerID=D.CustomerID
JOIN 
(SELECT StockItemID,OrderID FROM Sales.OrderLines) AS S
ON S.OrderID=O.OrderID
JOIN  (SELECT TOP 3 StockItemID, UnitPrice  FROM Warehouse.StockItems 
ORDER BY StockItems.UnitPrice desc) AS W
ON S.StockItemID=W.StockItemID
JOIN
(SELECT PersonID, FullName  FROM Application.People) AS P
ON P.PersonID=O.PackedByPersonID;



--CTE

WITH PeopleCTE AS
(SELECT PersonID, FullName  FROM Application.People)
, 

StockItemsCTE AS 
(SELECT TOP 3 StockItemID, UnitPrice  FROM Warehouse.StockItems 
ORDER BY StockItems.UnitPrice desc)
,

OrdersCTE AS 
(SELECT StockItemID,OrderID FROM Sales.OrderLines)
,

InvoicesCTE AS 
(SELECT CustomerID,OrderID, PackedByPersonID FROM Sales.Invoices) 
,

DeliveryCityCTE AS
(SELECT DeliveryCityID,CustomerID FROM Sales.Customers)

SELECT DISTINCT C.CityID, C.CityName, P.FullName FROM Application.Cities AS C
JOIN DeliveryCityCTE AS D
ON C.CityID=D.DeliveryCityID
JOIN InvoicesCTE AS I
ON D.CustomerID=I.CustomerID
JOIN OrdersCTE AS O
ON O.OrderID=I.OrderID
JOIN StockItemsCTE AS S
ON S.StockItemID=O.StockItemID
JOIN PeopleCTE AS P
ON P.PersonID=I.PackedByPersonID;

