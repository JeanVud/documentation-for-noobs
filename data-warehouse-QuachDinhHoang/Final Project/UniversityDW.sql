CREATE TABLE dbo.DimStudent (
   [StudentKey]  int IDENTITY  NOT NULL
,  [StudentID]  varchar(5)   NOT NULL
,  [StudentName]  varchar(20)   NOT NULL
,  [DeptName]  varchar(20)   NOT NULL
,  [TotalCredit]  int   NOT NULL
,  [AdvisorName]  varchar(20)   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime   NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimStudent] PRIMARY KEY CLUSTERED 
( [StudentKey] )
) ON [PRIMARY]