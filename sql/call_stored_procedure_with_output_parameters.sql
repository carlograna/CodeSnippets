use adventureWorks2012;
go

drop table Family;

create table Family
(
	id int primary key identity(1,1)
	,firstname varchar(25)
	,lastname varchar(25)
)

go

insert into Family
values ('Carlo', 'Spader')
	,('Oscar', 'Spader')
	,('Juan', 'Spader')
	,('Bella', 'Spader')
	,('Isaac', 'Spader')

go


select *
from Family;
-- STORED PRECEDURE
ALTER PROCEDURE dbo.sp_test

	@id int
	 ,@firstname varchar(25) output
	 ,@lastname varchar(25) output
	 AS
BEGIN
	SELECT @firstname = firstname
		,@lastname = lastname
	FROM dbo.Family
	WHERE id = @id;

	SELECT  *
	FROM Family;
	RETURN @id;
END
GO

-- STORE PROCEDURE CALL
use AdventureWorks2012;

declare @fn varchar(25)
	,@ln varchar(25)
	,@returnValue int

exec @returnValue = dbo.sp_test
		@id = 4
	, @firstname = @fn output
	, @lastname = @ln output

select @fn as FirstName
	,@ln as LastName
	,'Return Value' = @returnValue