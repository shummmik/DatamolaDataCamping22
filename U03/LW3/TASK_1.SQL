
USE [HumanResources]
GO

CREATE TABLE [dbo].[EmployeesExternal](
	EmployeeID INT IDENTITY (1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	EmailAddress NVARCHAR(50) NULL,
	City NVARCHAR(50) NOT NULL,
	StateProvinceName NVARCHAR(50) NOT NULL,
	CountryRegionName NVARCHAR(50) NOT NULL,
	
	CONSTRAINT PK_EmployeesExternal_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID)
) 
GO




CREATE TABLE [dbo].[EmployeesAW](

	BusinessEntityID INT IDENTITY (1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NULL,
	CONSTRAINT PK_EmployeesAW_BusinessEntityID PRIMARY KEY CLUSTERED (BusinessEntityID)
) 
GO



CREATE TABLE [dbo].[EmailAddressesAW](

	EmailAddressId INT IDENTITY (1,1) NOT NULL,
	BusinessEntityID INT NOT NULL,
	EmailAddress NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_EmailAddressesAW_EmailAddressId PRIMARY KEY CLUSTERED (EmailAddressId)
) 
GO