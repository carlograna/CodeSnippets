use AdventureWorks_2012;
go

create function fnCustomerSales(@startDate  Date, @endDate Date)
returns table
as
return(
	select
	C.CustomerID
	,C.AccountNumber
	,sum(SOD.UnitPrice) as TotalPrice
	from Sales.Customer C
	left join Sales.SalesOrderHeader SOH on SOH.CustomerID = C.CustomerID
	left join Sales.SalesOrderDetail SOD on SOD.SalesOrderId = SOH.SalesOrderID
	where SOH.OrderDate > @startDate and SOH.OrderDate < @endDate
	group by C.CustomerID, C.AccountNumber

);

select CustomerID, TotalPrice from fnCustomerSales('20080301', '20140801')




