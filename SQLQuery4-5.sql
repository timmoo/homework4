WITH 
OrderLinesCTE AS
	(
	SELECT O.OrderID, SUM(OL.PickedQuantity*OL.UnitPrice) as TotalSummByInvoice
	FROM Sales.OrderLines AS OL
	JOIN Sales.Orders AS O
	ON
	OL.OrderID=O.OrderID
	WHERE O.PickingCompletedWhen IS NOT NULL
	GROUP BY O.OrderID
	),
InvoicesCTE AS 
	(
	SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSummForPickedItems
	FROM Sales.InvoiceLines
	GROUP BY InvoiceId
	HAVING SUM(Quantity*UnitPrice) > 27000
	)
SELECT 
	Invoices.InvoiceID, 
	Invoices.InvoiceDate,
	People.FullName AS SalesPersonName,
	OLCTE.TotalSummByInvoice,
	ICTE.TotalSummForPickedItems
FROM Application.People
	JOIN Sales.Invoices 
ON 
	People.PersonID = Invoices.SalespersonPersonID
	JOIN OrderLinesCTE AS OLCTE
ON OLCTE.OrderId = Invoices.OrderId
	JOIN InvoicesCTE AS ICTE
ON ICTE.InvoiceID=Invoices.InvoiceID
ORDER BY TotalSummByInvoice DESC;
