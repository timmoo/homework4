WITH PeopleCTE AS 
(
SELECT People.FullName
FROM Application.People
WHERE People.PersonID = Invoices.SalespersonPersonID
)AS SalesPersonName,
OrderLinesCTE AS
(
SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice)
FROM Sales.OrderLines
WHERE OrderLines.OrderId = (SELECT Orders.OrderId 
FROM Sales.Orders
WHERE Orders.PickingCompletedWhen IS NOT NULL	
AND Orders.OrderId = Invoices.OrderId) AS TotalSummForPickedItems
),
InvoicesCTE AS 
(
SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
FROM Sales.InvoiceLines
GROUP BY InvoiceId
HAVING SUM(Quantity*UnitPrice) > 27000) AS SalesTotals
ON Invoices.InvoiceID = SalesTotals.InvoiceID
ORDER BY TotalSumm DESC
)
SELECT S.InvoiceID, S.InvoiceDate, TotalSummForPickedItems, TotalSummByInvoice, P.SalesPersonName
FROM Sales.Invoices AS S
	JOIN PeopleCTE AS P
		ON S.SalespersonPersonID =P.PersonID
	JOIN InvoicesCTE AS I
		ON S.InvoiceID = I.SalespersonPersonID
ORDER BY L.TotalSumm DESC, I.SalesCount DESC;