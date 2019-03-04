--Выберите города (ид и название), в которые были доставлены товары, 
--входящие в тройку самых дорогих товаров, а также Имя сотрудника, который осуществлял упаковку заказов\



SELECT DISTINCT C.CityID, C.CityName, P.FullName FROM Application.Cities AS C
JOIN
Sales.Customers AS D
ON C.CityID=D.DeliveryCityID
JOIN 
Sales.Invoices AS I
ON I.CustomerID=D.CustomerID
JOIN 
Sales.OrderLines AS S
ON S.OrderID=I.OrderID
JOIN  (SELECT TOP 3 StockItemID, UnitPrice  FROM Warehouse.StockItems 
ORDER BY StockItems.UnitPrice desc) AS W
ON S.StockItemID=W.StockItemID
JOIN
Application.People AS P
ON P.PersonID=I.PackedByPersonID;



--CTE
WITH
	StockItemsCTE AS 
		(SELECT TOP 3 StockItemID, UnitPrice  FROM Warehouse.StockItems 
			ORDER BY StockItems.UnitPrice desc)
	SELECT DISTINCT C.CityID, C.CityName, P.FullName FROM Application.Cities AS C

JOIN
Sales.Customers AS D
ON C.CityID=D.DeliveryCityID
JOIN 
Sales.Invoices AS I
ON I.CustomerID=D.CustomerID
JOIN 
Sales.OrderLines AS O
ON O.OrderID=I.OrderID
JOIN StockItemsCTE AS S
ON S.StockItemID=O.StockItemID
JOIN
Application.People AS P
ON P.PersonID=I.PackedByPersonID


