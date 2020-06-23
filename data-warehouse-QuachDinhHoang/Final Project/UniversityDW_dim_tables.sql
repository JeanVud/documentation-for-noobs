/* Create table dbo.DimStudent */
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
;

/* Create table dbo.DimInstructor */
CREATE TABLE dbo.DimInstructor (
   [InstructorKey]  int IDENTITY  NOT NULL
,  [InstructorID]  varchar(5)   NOT NULL
,  [InstructorName]  varchar(20)   NULL
,  [DeptName]  varchar(20)   NOT NULL
,  [Salary]  numeric(8,2)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimInstructor] PRIMARY KEY CLUSTERED 
( [InstructorKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimTakes */
CREATE TABLE dbo.DimTakes (
   [TakesKey]  int IDENTITY  NOT NULL
,  [StudentName]  varchar(20)   NOT NULL
,  [CourseTitle]  varchar(50)   NULL
,  [SectionID]  varchar(8)   NOT NULL
,  [Year]  numeric(4,0)   NULL
,  [Grade]  varchar(2)   NULL
,  [Semester]  varchar(6)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimTakes] PRIMARY KEY CLUSTERED 
( [TakesKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimCourse */
CREATE TABLE dbo.DimCourse (
   [CourseKey]  int IDENTITY  NOT NULL
,  [CourseID]  varchar(8)   NOT NULL
,  [DeptName]  varchar(50)   NOT NULL
,  [Credits]  numeric(2,0)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimCourse] PRIMARY KEY CLUSTERED 
( [CourseKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimPrereq */
CREATE TABLE dbo.DimPrereq (
   [PrereqKey]  int IDENTITY  NOT NULL
,  [CourseTitle]  varchar(50)   NOT NULL
,  [PrereqTitle]  varchar(50)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimPrereq] PRIMARY KEY CLUSTERED 
( [PrereqKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimTimeSlot */
CREATE TABLE dbo.DimTimeSlot (
   [TimeSlotKey]  int IDENTITY  NOT NULL
,  [TimeSlotID]  varchar(4)   NOT NULL
,  [Day]  varchar(1)   NOT NULL
,  [Start_hr]  numeric(2,0)   NOT NULL
,  [Start_min]  numeric(2,0)   NOT NULL
,  [End_hr]  numeric(2,0)   NULL
,  [End_min]  numeric(2,0)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimTimeSlot] PRIMARY KEY CLUSTERED 
( [TimeSlotKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimSection */
CREATE TABLE dbo.DimSection (
   [SectionKey]  int IDENTITY  NOT NULL
,  [CourseTitle]  varchar(50)  DEFAULT '0' NULL
,  [SectionID]  varchar(8)  DEFAULT '0' NOT NULL
,  [Year]  numeric(4,0)  DEFAULT 0 NULL
,  [Semester]  varchar(6)   NOT NULL
,  [Building]  varchar(15)   NULL
,  [RoomNumber]  varchar(7)   NULL
,  [TimeSlotID]  varchar(4)   NULL
,  [InstructorName]  varchar(20)   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimSection] PRIMARY KEY CLUSTERED 
( [SectionKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimClassroom */
CREATE TABLE dbo.DimClassroom (
   [ClassroomKey]  int IDENTITY  NOT NULL
,  [Building]  varchar(15)   NOT NULL
,  [RoomNumber]  varchar(7)   NOT NULL
,  [Capacity]  numeric(4,0)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimClassroom] PRIMARY KEY CLUSTERED 
( [ClassroomKey] )
) ON [PRIMARY]
;
