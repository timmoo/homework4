SELECT * FROM Sales.Customers
WHERE CustomerID IN
(SELECT TOP 5 CustomerID FROM Sales.CustomerTransactions 
ORDER BY TransactionAmount desc);


SELECT * FROM Sales.Customers C
WHERE CustomerID = SOME (SELECT TOP 5 CustomerID FROM Sales.CustomerTransactions ORDER BY TransactionAmount desc);
 

WITH CustomerTransactionsCTE AS 
(
	SELECT TOP 5 CustomerID FROM Sales.CustomerTransactions 
ORDER BY TransactionAmount desc
)
SELECT * 
FROM Sales.Customers AS C
	JOIN CustomerTransactionsCTE AS T
		ON C.CustomerID = T.CustomerID;
