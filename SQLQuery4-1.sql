SELECT *
FROM Application.People AS P
WHERE P.IsSalesperson = 1 AND NOT EXISTS (SELECT SalespersonPersonID FROM Sales.Invoices AS I WHERE I.SalespersonPersonID=P.PersonID);



SELECT * FROM Application.People
WHERE IsSalesperson = 1 AND  PersonId NOT IN (SELECT SalespersonPersonID FROM Sales.Orders);