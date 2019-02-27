SELECT *
FROM Application.People
WHERE EXISTS (SELECT SalespersonPersonID 
	FROM Sales.Orders
	WHERE SalespersonPersonID = 1);


SELECT * FROM Application.People
WHERE PersonId NOT IN (SELECT SalespersonPersonID FROM Sales.Orders) AND IsSalesperson = 1;
