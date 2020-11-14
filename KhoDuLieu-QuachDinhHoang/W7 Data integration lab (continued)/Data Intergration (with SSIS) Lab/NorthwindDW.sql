-- Employee Dimension
CREATE TABLE DimEmployee (
   [EmployeeKey]  int IDENTITY  NOT NULL
   --attributes
,  [EmployeeID]  int   NOT NULL
,  [EmployeeName]  nvarchar(40)   NOT NULL
,  [EmployeeTitle]  nvarchar(30)   NOT NULL
,  [HireDateKey] int NULL
,  [SupervisorID]  int   NULL
,  [SupervisorName]  nvarchar(40)  NULL
,  [SupervsorTitle]  nvarchar(30)  NULL	
-- metadata
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [pkNorthwindDimEmployee] PRIMARY KEY ( [EmployeeKey] )
);

-- Customer Dimension
CREATE TABLE DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
   -- Attributes
,  [CustomerID]  nvarchar(5)   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [ContactName]  nvarchar(30)   NOT NULL
,  [ContactTitle]  nvarchar(30)   NOT NULL
,  [CustomerCountry]  nvarchar(15)   NOT NULL
,  [CustomerRegion]  nvarchar(15)  DEFAULT 'N/A' NOT NULL
,  [CustomerCity]  nvarchar(15)   NOT NULL
,  [CustomerPostalCode]  nvarchar(10)   NOT NULL
	-- metadata
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT pkNorthwindDimCustomer PRIMARY KEY ( [CustomerKey] )
);


-- Product Dimension
create table DimProduct
(
	ProductKey int identity not null,
	-- attributes
	ProductID int not null, 
	ProductName nvarchar(40) not null,
	Discontinued nchar(1) default('N') not null,
	SupplierName nvarchar(40) not null,
	CategoryName nvarchar(15) not null,
	-- metadata
	RowIsCurrent bit default(1) not null,
	RowStartDate datetime default('1/1/1900') not null,
	RowEndDate datetime default('12/31/9999') not null,
	RowChangeReason nvarchar(200) default ('N/A') not null,
	-- keys
	constraint pkNorthwindDimProductKey primary key (ProductKey),	
);

-- Supplier
create table DimSupplier
(
	SupplierKey int identity not null,
	-- attrivbutes
	SupplierID int not null,
	CompanyName nvarchar(40) not null,
	ContactName nvarchar(30) not null,
	ContactTitle nvarchar(30) not null,
	City nvarchar(15) not null,
	Region nvarchar(15) not null,
	Country nvarchar(15) not null,
	-- metadata
	RowIsCurrent bit default(1) not null,
	RowStartDate datetime default('1/1/1900') not null,
	RowEndDate datetime default('12/31/9999') not null,
	RowChangeReason nvarchar(200) default ('N/A') not null,
	-- keys
	constraint pkNorthwindDimSupplierKey primary key (SupplierKey),
);

-- date dimension
CREATE TABLE [DimDate](
	[DateKey] [int] NOT NULL,
	[Date] [datetime] NULL,
	[DayOfWeek] [tinyint] NOT NULL,
	[DayName] [varchar](9) NOT NULL,
	[DayOfMonth] [tinyint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[MonthName] [varchar](9) NOT NULL,
	[MonthOfYear] [tinyint] NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[Year] [smallint] NOT NULL,
	[IsAWeekday] varchar(1) NOT NULL DEFAULT (('N')),
	constraint pkNorthwindDimDate PRIMARY KEY ([DateKey])
)

-- Periodic Snapshot for Inventory analysis
create table FactInventoryDailySnapshot
(
	ProductKey int not null,
	SupplierKey int not null,
	DateKey int not null,
	-- facts
	UnitsInStock int not null,
	UnitsOnOrder int not null
	-- keys
	constraint pkNorthwindFactInventoryKey primary key (DateKey, ProductKey),

	constraint fkNorthwindFactInventoryProductKey foreign key (ProductKey) 
		references DimProduct(ProductKey),
	constraint fkNorthwindFactInventorySupplierKey foreign key (SupplierKey) 
		references DimSupplier(SupplierKey),
	constraint fkNorthwindFactInventoryDateKey foreign key (DateKey) 
		references DimDate(DateKey),
);

-- sales fact table
PRINT 'CREATE TABLE northwind.FactSales'
CREATE TABLE FactSales (
   [ProductKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
	-- dimensions
,  [CustomerKey]  int   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
	-- facts
,  [Quantity]  smallint   NOT NULL
,  [ExtendedPriceAmount]  decimal(25,4) NOT NULL
,  [DiscountAmount]  decimal(25,4)  DEFAULT 0 NOT NULL
,  [SoldAmount]  decimal(25,4)  NOT NULL
,  [OrderToShippedLagInDays] smallint null
   --keys
, CONSTRAINT pkNorthwindFactSales PRIMARY KEY ( ProductKey, OrderID )
, CONSTRAINT fkNorthwindFactSalesProductKey FOREIGN KEY ( ProductKey )
	REFERENCES DimProduct (ProductKey)
, CONSTRAINT fkNorthwindFactSalesCustomerKey FOREIGN KEY ( CustomerKey )
	REFERENCES DimCustomer (CustomerKey)
, CONSTRAINT fkNorthwindFactSalesEmployeeKey FOREIGN KEY ( EmployeeKey )
	REFERENCES DimEmployee (EmployeeKey)
, CONSTRAINT fkNorthwindFactSalesOrderDateKey FOREIGN KEY (OrderDateKey )
	REFERENCES DimDate (DateKey)
, CONSTRAINT fkNorthwindFactSalesShippedDateKey FOREIGN KEY (ShippedDateKey )
	REFERENCES DimDate (DateKey)
) 
;

-- Unknown Customer
SET IDENTITY_INSERT [DimCustomer] ON
go
INSERT INTO [DimCustomer]
           ([CustomerKey]
		   ,[CustomerID]
           ,[CompanyName]
           ,[ContactName]
           ,[ContactTitle]
           ,[CustomerCountry]
           ,[CustomerRegion]
           ,[CustomerCity]
           ,[CustomerPostalCode])
     VALUES
           (-1
		   ,'UNK-1'
           ,'Unknown Company'
           ,'Unknown Contact'
           ,'Unknown Title'
           ,'None'
           ,'None'
           ,'None'
           ,'None')
GO
SET IDENTITY_INSERT [DimCustomer] OFF
go
-- Unknown Date Value
INSERT INTO [DimDate]
           ([DateKey]
           ,[Date]
           ,[DayOfWeek]
           ,[DayName]
           ,[DayOfMonth]
           ,[DayOfYear]
           ,[WeekOfYear]
           ,[MonthName]
           ,[MonthOfYear]
           ,[Quarter]
           ,[Year]
           ,[IsAWeekday])
     VALUES
           (-1
           ,null
           ,0
           ,'Unknown'
           ,0
           ,0
           ,0
           ,'Unknown'
           ,0
           ,0
           ,0
           ,'?')
GO
-- unknown Employee
SET IDENTITY_INSERT [DimEmployee] ON
GO
INSERT INTO [DimEmployee]
           ([EmployeeKey]
		   ,[EmployeeID]
           ,[EmployeeName]
           ,[EmployeeTitle]
           ,[HireDateKey]
           ,[SupervisorID]
           ,[SupervisorName]
           ,[SupervsorTitle])
     VALUES
           (-1
		   ,-1
           ,'Unknown'
           ,'Unknown'
           ,-1
           ,-1
           ,'Unknown'
           ,'Unknown')
GO
SET IDENTITY_INSERT [DimEmployee] OFF
GO

SET IDENTITY_INSERT [DimProduct] ON
GO
INSERT INTO [DimProduct]
           ([ProductKey]
		   ,[ProductID]
           ,[ProductName]
           ,[Discontinued]
           ,[SupplierName]
           ,[CategoryName])
     VALUES
           (-1
		   ,-1
           ,'Unknown'
           ,'?'
           ,'Unknown'
           ,'Unknown')
GO
SET IDENTITY_INSERT [DimProduct] OFF
GO

-- Default for Supplier
SET IDENTITY_INSERT [DimSupplier] ON
GO
INSERT INTO [DimSupplier]
           ([SupplierKey]
		   ,[SupplierID]
           ,[CompanyName]
           ,[ContactName]
           ,[ContactTitle]
           ,[City]
           ,[Region]
           ,[Country])
     VALUES
           (-1
		   ,-1
           ,'Unknown'
           ,'Unknown'
           ,'Unknown'
           ,'Unknown'
           ,'Unknown'
           ,'Unknown')
GO
SET IDENTITY_INSERT [DimSupplier] OFF
GO

