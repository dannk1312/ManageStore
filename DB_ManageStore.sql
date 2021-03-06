USE [master]
GO
/****** Object:  Database [DB_ManageStore]    Script Date: 26/01/2021 9:40:23 SA ******/
CREATE DATABASE [DB_ManageStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_ManageStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DB_ManageStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_ManageStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DB_ManageStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DB_ManageStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_ManageStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_ManageStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_ManageStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_ManageStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_ManageStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_ManageStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_ManageStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_ManageStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_ManageStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_ManageStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_ManageStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_ManageStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_ManageStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_ManageStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_ManageStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_ManageStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_ManageStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_ManageStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_ManageStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_ManageStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_ManageStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_ManageStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_ManageStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_ManageStore] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_ManageStore] SET  MULTI_USER 
GO
ALTER DATABASE [DB_ManageStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_ManageStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_ManageStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_ManageStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_ManageStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_ManageStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_ManageStore', N'ON'
GO
ALTER DATABASE [DB_ManageStore] SET QUERY_STORE = OFF
GO
USE [DB_ManageStore]
GO
/****** Object:  UserDefinedFunction [dbo].[f_AdminCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_AdminCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @AdminCount int
	set @AdminCount = (SELECT COUNT(*) FROM Person INNER JOIN (SELECT * FROM PersonRole WHERE Name='ADMIN') as Admin on Person.RoleId = Admin.RoleId)

	-- Return the result of the function
	RETURN @AdminCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_BlockCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_BlockCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @BlockCount int
	set @BlockCount = (SELECT COUNT(*) FROM Person INNER JOIN (SELECT * FROM PersonRole WHERE Name='Block') as Block on Person.RoleId = Block.RoleId)

	-- Return the result of the function
	RETURN @BlockCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_CategoryCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_CategoryCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @CategoryCount int
	set @CategoryCount = (SELECT Count(*) FROM Category)

	-- Return the result of the function
	RETURN @CategoryCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_EarnBillCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_EarnBillCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @EarnBillCount int
	set @EarnBillCount = (SELECT Count(*) FROM Bill WHERE isCustomer=1 and isDone=1)

	-- Return the result of the function
	RETURN @EarnBillCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_EarnMoney]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_EarnMoney]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @EarnBillCount int
	set @EarnBillCount = (SELECT Sum(Bill.TotalPrice) FROM Bill WHERE isCustomer=1 and isDone=1)

	-- Return the result of the function
	RETURN @EarnBillCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_ItemCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_ItemCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemCount int
	set @ItemCount = (SELECT Count(*) FROM Item Where Item.Enable = 1)

	-- Return the result of the function
	RETURN @ItemCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_ItemEnableCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_ItemEnableCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemCount int
	set @ItemCount = (SELECT Count(*) FROM Item Where Item.Enable = 1)

	-- Return the result of the function
	RETURN @ItemCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_ItemUnableCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_ItemUnableCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemCount int
	set @ItemCount = (SELECT Count(*) FROM Item Where Item.Enable = 0)

	-- Return the result of the function
	RETURN @ItemCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_ManagerCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_ManagerCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ManagerCount int
	set @ManagerCount = (SELECT COUNT(*) FROM Person INNER JOIN (SELECT * FROM PersonRole WHERE Name='Manager') as Manager on Person.RoleId = Manager.RoleId)

	-- Return the result of the function
	RETURN @ManagerCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_MemberCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_MemberCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @MemberCount int
	set @MemberCount = (SELECT COUNT(*) FROM Person INNER JOIN (SELECT * FROM PersonRole WHERE Name='Member') as Member on Person.RoleId = Member.RoleId)

	-- Return the result of the function
	RETURN @MemberCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_PaidBillCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_PaidBillCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PaidBillCount int
	set @PaidBillCount = (SELECT Count(*) FROM Bill WHERE isCustomer=0 and isDone=1)

	-- Return the result of the function
	RETURN @PaidBillCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_PaidMoney]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_PaidMoney]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PaidBillCount int
	set @PaidBillCount = (SELECT Sum(Bill.TotalPrice) FROM Bill WHERE isCustomer=0 and isDone=1)

	-- Return the result of the function
	RETURN @PaidBillCount
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_UnitCount]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_UnitCount]
()
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @UnitCount int
	set @UnitCount = (SELECT Count(*) FROM Unit)

	-- Return the result of the function
	RETURN @UnitCount
END
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillId] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[PersonId] [int] NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[CityId] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[isCustomer] [bit] NOT NULL,
	[isDone] [bit] NOT NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_Bag]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[f_Bag]
(	
	@PersonId int
)
RETURNS TABLE 
AS
RETURN 
(
	Select * From BILL Where Bill.PersonId = @PersonId and BILL.isDone = 0
)
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[UnitId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Quantity] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Unit]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Unit]
AS
SELECT dbo.Unit.Name, COUNT(dbo.Item.UnitId) AS ItemQuantity, dbo.Unit.UnitId
FROM     dbo.Unit LEFT OUTER JOIN
                  dbo.Item ON dbo.Unit.UnitId = dbo.Item.UnitId
GROUP BY dbo.Unit.Name, dbo.Unit.UnitId
GO
/****** Object:  Table [dbo].[Category]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemCategory]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCategory](
	[ItemId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_ItemCategory] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Category]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Category]
AS
SELECT dbo.Category.Name, COUNT(dbo.ItemCategory.CategoryId) AS ItemQuantity, dbo.Category.CategoryId
FROM     dbo.Category LEFT OUTER JOIN
                  dbo.ItemCategory ON dbo.Category.CategoryId = dbo.ItemCategory.CategoryId
GROUP BY dbo.Category.Name, dbo.Category.CategoryId
GO
/****** Object:  Table [dbo].[City]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NOT NULL,
	[Phone] [varchar](11) NOT NULL,
	[Email] [varchar](max) NULL,
	[Address] [ntext] NULL,
	[CityId] [int] NULL,
	[Password] [varchar](max) NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_City]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_City]
AS
SELECT v1.Name, v1.BillQuantity, v2.PersonQuantity, v2.CityId
FROM     (SELECT dbo.City.Name, COUNT(dbo.Bill.CityId) AS BillQuantity, dbo.City.CityId
                  FROM      dbo.City LEFT OUTER JOIN
                                    dbo.Bill ON dbo.City.CityId = dbo.Bill.CityId
                  GROUP BY dbo.City.Name, dbo.City.CityId) AS v1 LEFT OUTER JOIN
                      (SELECT COUNT(dbo.Person.CityId) AS PersonQuantity, City_1.CityId
                       FROM      dbo.City AS City_1 LEFT OUTER JOIN
                                         dbo.Person ON City_1.CityId = dbo.Person.CityId
                       GROUP BY City_1.CityId) AS v2 ON v1.CityId = v2.CityId
GO
/****** Object:  Table [dbo].[PersonRole]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonRole](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AccountRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Person]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Person]
AS
SELECT dbo.Person.Name, dbo.Person.Phone, dbo.Person.Email, dbo.Person.Address, dbo.Person.Password, dbo.Person.PersonId, dbo.Person.RoleId, dbo.Person.CityId, dbo.City.Name AS City, dbo.PersonRole.Name AS Role
FROM     dbo.Person LEFT OUTER JOIN
                  dbo.City ON dbo.Person.CityId = dbo.City.CityId LEFT OUTER JOIN
                  dbo.PersonRole ON dbo.Person.RoleId = dbo.PersonRole.RoleId
GO
/****** Object:  UserDefinedFunction [dbo].[f_PersonRoleTable]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[f_PersonRoleTable]
(	
	
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT PersonRole.Name, COUNT(*) as Quantity
	FROM Person Inner Join PersonRole on Person.RoleId = PersonRole.RoleId
	GROUP BY 	PersonRole.RoleId, PersonRole.Name
)
GO
/****** Object:  Table [dbo].[BillItem]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillItem](
	[BillId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_BillItem_1] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_BillItem]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[f_BillItem]
(	
	@BillId int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT Item.ItemId,Item.Code,Item.Name,BillItem.Quantity,BillItem.Price
	FROM BillItem Join Item on BillItem.ItemId = Item.ItemId
	WHERE BillItem.BillId = @BillId
)
GO
/****** Object:  View [dbo].[vw_Bill]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Bill]
AS
SELECT dbo.Person.Name AS Person, dbo.Bill.Date, dbo.Bill.TotalPrice, dbo.Bill.Address, dbo.City.Name AS City, dbo.Bill.isCustomer, dbo.Bill.isDone, dbo.Bill.PersonId, dbo.Bill.CityId, dbo.Bill.BillId
FROM     dbo.Bill INNER JOIN
                  dbo.Person ON dbo.Bill.PersonId = dbo.Person.PersonId INNER JOIN
                  dbo.City ON dbo.Bill.CityId = dbo.City.CityId
GO
/****** Object:  View [dbo].[vw_Item]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Item]
AS
SELECT dbo.Item.Code, dbo.Item.Name, dbo.Item.Quantity, dbo.Item.Price, dbo.Unit.Name AS Unit, dbo.Item.Enable, dbo.Item.ItemId, dbo.Item.UnitId
FROM     dbo.Item INNER JOIN
                  dbo.Unit ON dbo.Item.UnitId = dbo.Unit.UnitId
GO
/****** Object:  UserDefinedFunction [dbo].[f_ItemCategory]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[f_ItemCategory]
(	
	@ItemId int
)
RETURNS TABLE 
AS
RETURN 
(
	Select Category.CategoryId, Category.Name 
	From ItemCategory Join Category on ItemCategory.CategoryId = Category.CategoryId
	Where ItemCategory.ItemId = @ItemId
)
GO
/****** Object:  UserDefinedFunction [dbo].[f_AnotherCategory]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[f_AnotherCategory]
(	
	@ItemId int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT Category.CategoryId, Category.Name
	FROM Category LEFT OUTER JOIN (Select Category.CategoryId, Category.Name 
	From ItemCategory Join Category on ItemCategory.CategoryId = Category.CategoryId
	Where ItemCategory.ItemId = @ItemId) as A ON Category.CategoryId = A.CategoryId 
	WHERE A.CategoryId  IS NULL 
)


GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (1, CAST(N'2021-01-21T11:43:28.127' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (4, CAST(N'2021-01-21T11:45:17.660' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (5, CAST(N'2021-01-21T11:49:46.387' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (6, CAST(N'2021-01-21T11:50:04.737' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (10, CAST(N'2021-01-21T11:51:31.570' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (11, CAST(N'2021-01-21T11:51:54.687' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (12, CAST(N'2021-01-21T11:52:10.103' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (13, CAST(N'2021-01-21T11:52:16.303' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (18, CAST(N'2021-01-21T11:54:01.180' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (19, CAST(N'2021-01-21T11:54:09.723' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (21, CAST(N'2021-01-21T12:08:02.113' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (22, CAST(N'2021-01-21T12:09:47.697' AS DateTime), 2, 1000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (23, CAST(N'2021-01-21T12:16:02.453' AS DateTime), 2, 1000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (24, CAST(N'2021-01-21T12:17:15.823' AS DateTime), 2, 1000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (25, CAST(N'2021-01-21T12:18:14.970' AS DateTime), 2, 1000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (26, CAST(N'2021-01-21T12:18:49.507' AS DateTime), 2, 1000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (27, CAST(N'2021-01-21T12:19:15.520' AS DateTime), 2, 1000.0000, 1, N'SOMEWHERE', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (28, CAST(N'2021-01-25T08:34:26.003' AS DateTime), 4, 200000.0000, 2, N'????', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (29, CAST(N'2021-01-25T08:34:26.003' AS DateTime), 4, 200000.0000, 2, N'?????', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (30, CAST(N'2021-01-21T11:52:16.303' AS DateTime), 2, 20000.0000, 1, N'SOMEWHERE', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (32, CAST(N'2021-01-25T08:34:26.003' AS DateTime), 3, 200000.0000, 2, N'?????', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (33, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 2, 300000.0000, 2, N'xxxx', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (34, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 2, 300000.0000, 2, N'xxxx', 0, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (35, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 19, 2000000.0000, 2, N'', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (36, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 2, 0.0000, 2, N'A', 1, 0)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (37, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 18, 0.0000, 4, N'AAAAA', 1, 0)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (39, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 19, 10000.0000, 2, N'', 1, 1)
INSERT [dbo].[Bill] ([BillId], [Date], [PersonId], [TotalPrice], [CityId], [Address], [isCustomer], [isDone]) VALUES (45, CAST(N'2021-01-25T00:00:00.000' AS DateTime), 19, 0.0000, 2, N'', 1, 0)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (1, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (4, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (4, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (5, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (5, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (6, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (6, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (10, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (10, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (11, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (11, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (12, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (12, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (13, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (13, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (18, 1, 300, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (18, 2, 300, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (19, 1, 300, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (19, 2, 300, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (21, 3, 10, 30000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (22, 4, 10, 30000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (26, 4, 10, 30000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (27, 4, -20, 30000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (29, 3, 5, 20000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (32, 3, 5, 20000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (33, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (34, 1, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (34, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (34, 3, 5, 20000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (34, 7, 5, 20000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (35, 3, 5, 20000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (39, 2, 5, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (45, 2, 0, 10000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (45, 4, 0, 30000.0000)
INSERT [dbo].[BillItem] ([BillId], [ItemId], [Quantity], [Price]) VALUES (45, 7, 0, 20000.0000)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (5, N'Loại 1')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (6, N'Loại 2')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (7, N'Loại 3')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[City] ON 

INSERT [dbo].[City] ([CityId], [Name]) VALUES (1, N'TPHCM')
INSERT [dbo].[City] ([CityId], [Name]) VALUES (2, N'Đà Nẵng')
INSERT [dbo].[City] ([CityId], [Name]) VALUES (4, N'Hà Nội')
INSERT [dbo].[City] ([CityId], [Name]) VALUES (5, N'Hải Phòng')
SET IDENTITY_INSERT [dbo].[City] OFF
GO
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (1, N'CODE1', N'ITEM', 10, 1, 10000.0000, 1)
INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (2, N'CODE2', N'ITEM', 0, 6, 10000.0000, 1)
INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (3, N'CODE3', N'ITEM', 0, 1, 20000.0000, 1)
INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (4, N'CODE4', N'ITEM', 0, 1, 30000.0000, 1)
INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (7, N'CODE5', N'ITEM', 5, 6, 20000.0000, 1)
INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (8, N'CODE6', N'ITEM', 0, 8, 30000.0000, 1)
INSERT [dbo].[Item] ([ItemId], [Code], [Name], [Quantity], [UnitId], [Price], [Enable]) VALUES (11, N'CODE7', N'ITEM', 0, 6, 30000.0000, 1)
SET IDENTITY_INSERT [dbo].[Item] OFF
GO
INSERT [dbo].[ItemCategory] ([ItemId], [CategoryId]) VALUES (3, 5)
INSERT [dbo].[ItemCategory] ([ItemId], [CategoryId]) VALUES (7, 6)
INSERT [dbo].[ItemCategory] ([ItemId], [CategoryId]) VALUES (7, 7)
INSERT [dbo].[ItemCategory] ([ItemId], [CategoryId]) VALUES (8, 5)
INSERT [dbo].[ItemCategory] ([ItemId], [CategoryId]) VALUES (8, 7)
INSERT [dbo].[ItemCategory] ([ItemId], [CategoryId]) VALUES (11, 6)
GO
SET IDENTITY_INSERT [dbo].[Person] ON 

INSERT [dbo].[Person] ([PersonId], [Name], [Phone], [Email], [Address], [CityId], [Password], [RoleId]) VALUES (2, N'Danh', N'01234567899', N'dannk1312', N'Somewhere', 1, N'2903', 1)
INSERT [dbo].[Person] ([PersonId], [Name], [Phone], [Email], [Address], [CityId], [Password], [RoleId]) VALUES (3, N'Tuong', N'00987654321', N'sandais2903', N'Somewhere', 1, N'2903', 2)
INSERT [dbo].[Person] ([PersonId], [Name], [Phone], [Email], [Address], [CityId], [Password], [RoleId]) VALUES (4, N'Hieu', N'12345678900', N'hieubui0000', N'Somewhere', 1, N'2903', 4)
INSERT [dbo].[Person] ([PersonId], [Name], [Phone], [Email], [Address], [CityId], [Password], [RoleId]) VALUES (16, N'Danh', N'0', N'hieubui000', N'0', 1, N'0', 3)
INSERT [dbo].[Person] ([PersonId], [Name], [Phone], [Email], [Address], [CityId], [Password], [RoleId]) VALUES (18, N'Test', N'090000019', N'Test123', N'AAAAA', 4, N'', 3)
INSERT [dbo].[Person] ([PersonId], [Name], [Phone], [Email], [Address], [CityId], [Password], [RoleId]) VALUES (19, N'dannk', N'', N'dannk1313', N'', 2, N'', 3)
SET IDENTITY_INSERT [dbo].[Person] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonRole] ON 

INSERT [dbo].[PersonRole] ([RoleId], [Name]) VALUES (1, N'ADMIN')
INSERT [dbo].[PersonRole] ([RoleId], [Name]) VALUES (2, N'MANAGER')
INSERT [dbo].[PersonRole] ([RoleId], [Name]) VALUES (3, N'MEMBER')
INSERT [dbo].[PersonRole] ([RoleId], [Name]) VALUES (4, N'BLOCK')
SET IDENTITY_INSERT [dbo].[PersonRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([UnitId], [Name]) VALUES (1, N'25kg')
INSERT [dbo].[Unit] ([UnitId], [Name]) VALUES (6, N'15kg')
INSERT [dbo].[Unit] ([UnitId], [Name]) VALUES (8, N'10kg')
INSERT [dbo].[Unit] ([UnitId], [Name]) VALUES (9, N'5kg')
INSERT [dbo].[Unit] ([UnitId], [Name]) VALUES (25, N'2kg')
INSERT [dbo].[Unit] ([UnitId], [Name]) VALUES (29, N'1kg')
SET IDENTITY_INSERT [dbo].[Unit] OFF
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([CityId])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_City]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Person]
GO
ALTER TABLE [dbo].[BillItem]  WITH CHECK ADD  CONSTRAINT [FK_BillItem_Bill] FOREIGN KEY([BillId])
REFERENCES [dbo].[Bill] ([BillId])
GO
ALTER TABLE [dbo].[BillItem] CHECK CONSTRAINT [FK_BillItem_Bill]
GO
ALTER TABLE [dbo].[BillItem]  WITH CHECK ADD  CONSTRAINT [FK_BillItem_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[BillItem] CHECK CONSTRAINT [FK_BillItem_Item]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Unit] FOREIGN KEY([UnitId])
REFERENCES [dbo].[Unit] ([UnitId])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Unit]
GO
ALTER TABLE [dbo].[ItemCategory]  WITH CHECK ADD  CONSTRAINT [FK_ItemCategory_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[ItemCategory] CHECK CONSTRAINT [FK_ItemCategory_Category]
GO
ALTER TABLE [dbo].[ItemCategory]  WITH CHECK ADD  CONSTRAINT [FK_ItemCategory_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[ItemCategory] CHECK CONSTRAINT [FK_ItemCategory_Item]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_AccountRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[PersonRole] ([RoleId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_AccountRole]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([CityId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_City]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddToBag]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddToBag]
	-- Add the parameters for the stored procedure here
	@PersonId int, @ItemId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @BillId int
	
	If((Select COUNT(*) From BILL Where Bill.PersonId = @PersonId and BILL.isDone = 0)=0)
	BEGIN 
		DECLARE @Mess nvarchar(max)
		DECLARE @CityId int
		DECLARE @Address nvarchar(max)
		DECLARE @Date date
		set @Date = GETDATE()
		set @CityId = (SELECT CityId FROM Person WHERE Person.PersonId = @PersonId)
		set @Address = (SELECT Address FROM Person WHERE Person.PersonId = @PersonId)
		EXEC sp_InsertBill @Date,@PersonId,0,@CityId,@Address,1,0,'',@Mess out

		SET @BillId = SCOPE_IDENTITY()
		if(@BillId is Null)
		Begin
			Select -1
			return;
		end
	END
	ELSE SET @BillId = (Select BillId From BILL JOIN Person on Bill.PersonId = Person.PersonId WHERE BILL.isDone = 0 and Person.PersonId=@PersonId)
	If((SELECT COUNT(*) FROM ITEM WHERE Item.ItemId = @ItemId) > 0)
	BEGIN
		If((SELECT COUNT(*) From BillItem WHERE BillItem.ItemId = @ItemId and BillItem.BillId=@BillId) = 0)
			INSERT INTO BillItem VALUES (@BillId,@ItemId,0,(SELECT Price FROM ITEM WHERE Item.ItemId = @ItemId))
		Select 1
	END
	ELSE Select -1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateBag]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CreateBag]
	-- Add the parameters for the stored procedure here
	@PersonId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		DECLARE @BillId int
		DECLARE @Mess nvarchar(max)
		DECLARE @CityId int
		DECLARE @Address nvarchar(max)
		DECLARE @Date date
		set @Date = GETDATE()
		set @CityId = (SELECT CityId FROM Person WHERE Person.PersonId = @PersonId)
		set @Address = (SELECT Address FROM Person WHERE Person.PersonId = @PersonId)
		EXEC sp_InsertBill @Date,@PersonId,0,@CityId,@Address,1,0,'',@Mess out

		SET @BillId = SCOPE_IDENTITY()
		if(@BillId is Null)
		Begin
			Select -1
			return;
		end
		Select @BillId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCategory]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteCategory]
	@CategoryId int, @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 

	IF((SELECT COUNT(*) FROM Category WHERE CategoryId = @CategoryId) = 0)
	BEGIN 
		set @Message = N'[F]Xoá thất bại. ID không tồn tại.'
		return
	END

	IF((SELECT COUNT(*) FROM ItemCategory WHERE CategoryId = @CategoryId)>0)
	BEGIN 
		set @Message = N'[F]Xoá thất bại. ID có kết nối với dữ liệu ở vật phẩm.'
		return
	END
	
	BEGIN
		DECLARE @Flag bit;
		set @Flag = 0;
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
		BEGIN TRANSACTION
			DELETE Category WHERE CategoryId = @CategoryId;
			set @Message = N'[S]Xoá thành công.'
			set @Flag = 1;
		COMMIT
		if(@Flag = 0)
			set @Message = N'[F]Xoá thất bại.'
		return
	END
END
-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCity]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteCity]
	@CityId int, @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 

	IF((SELECT COUNT(*) FROM City WHERE CityId = @CityId) = 0)
	BEGIN 
		set @Message = N'[F]Xoá thất bại. ID không tồn tại.'
		return
	END

	IF((SELECT COUNT(*) FROM Bill WHERE CityId = @CityId)>0 or 
		(SELECT COUNT(*) FROM Person WHERE CityId = @CityId)>0)
	BEGIN 
		set @Message = N'[F]Xoá thất bại. ID có kết nối với dữ liệu ở vật phẩm.'
		return
	END
	
	BEGIN
		DECLARE @Flag bit;
		set @Flag = 0;
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
		BEGIN TRANSACTION
			DELETE City WHERE CityId = @CityId;
			set @Message = N'[S]Xoá thành công.'
			set @Flag = 1;
		COMMIT
		if(@Flag = 0)
			set @Message = N'[F]Xoá thất bại.'
		return
	END
END
-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUnit]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteUnit]
	@UnitId int, @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 
	IF((SELECT COUNT(*) FROM Unit WHERE UnitId = @UnitId) = 0)
	BEGIN 
		set @Message = N'[F]Xoá thất bại. ID không tồn tại.'
		return
	END

	IF((SELECT COUNT(*) FROM Item WHERE UnitId = @UnitId) > 0)
	BEGIN 
		set @Message = N'[F]Xoá thất bại. ID có kết nối với dữ liệu ở vật phẩm.'
		return
	END
	
	BEGIN
		DECLARE @Flag bit;
		set @Flag = 0;
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
		BEGIN TRANSACTION
			DELETE Unit WHERE UnitId = @UnitId;
			set @Message = N'[S]Xoá thành công.'
			set @Flag = 1;
		COMMIT
		if(@Flag = 0)
			set @Message = N'[F]Xoá thất bại.'
		return
	END
END
-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertBill]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_InsertBill]
	@Date datetime,@PersonId int,@TotalPrice money,@CityId int,@Address nvarchar(max),@IsCustomer bit = 1,@IsDone bit = 0,@AllBillItemData varchar(max),@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	BEGIN TRANSACTION
		DECLARE @canAdd bit;
		set @canAdd = 1;
		IF(@Date>GETDATE())
			BEGIN
				set @Message = N'[F]Ngày lập đơn không hợp lệ. '
				set @canAdd = 0;
			END
		IF((SELECT COUNT(*) FROM Person WHERE Person.PersonId = @PersonId) = 0)
			BEGIN
				set @Message = N'[F]Không tồn tại PersonId này. '
				set @canAdd = 0;
			END
		IF(@CityId is not null and (SELECT COUNT(*) FROM City WHERE City.CityId = @CityId) = 0)
			BEGIN
				set @Message = N'[F]Không tồn tại CityId này '
				set @canAdd = 0;
			END
		IF(@canAdd = 1)
			BEGIN
				set @canAdd = 0;
				BEGIN
					DECLARE @BigCursor CURSOR;
					DECLARE @BillItemData varchar(max);
					SET @BigCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@AllBillItemData,';')
					OPEN @BigCursor 
					FETCH NEXT FROM @BigCursor INTO @BillItemData
					DECLARE @SmallCursor CURSOR;
					DECLARE @ItemId int;
					DECLARE @Quantity int;

					if(@IsDone=1 and @IsCustomer=1 and @AllBillItemData!='')
					BEGIN
						WHILE @@FETCH_STATUS = 0
							-- SPLIT DATA BILLITEM TO INSERT BILLITEM
							BEGIN
								SET @SmallCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@BillItemData,',')
								OPEN @SmallCursor 
								FETCH NEXT FROM @SmallCursor INTO @ItemId;
								FETCH NEXT FROM @SmallCursor INTO @Quantity;

								IF((SELECT SUM(Item.Quantity) FROM Item WHERE Item.ItemId = @ItemId) < @Quantity)
									BEGIN
										set @Message = N'[F]Thêm đơn ' + @BillItemData + N' Thất Bại. Không đủ số lượng.'
										COMMIT;
									RETURN;
									END;
							END;
					END;
					INSERT INTO Bill(Date,PersonId,TotalPrice,CityId,Address,isCustomer,isDone) VALUES (@Date,@PersonId,@TotalPrice,@CityId,@Address,@IsCustomer,@IsDone)
					DECLARE @BillId int;
					set @BillId = SCOPE_IDENTITY();
					SET @BigCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@AllBillItemData,';')
					OPEN @BigCursor 
					FETCH NEXT FROM @BigCursor INTO @BillItemData
					If(@AllBillItemData!='')
					WHILE @@FETCH_STATUS = 0
						-- SPLIT DATA BILLITEM TO INSERT BILLITEM
						BEGIN
							BEGIN
								SET @SmallCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@BillItemData,',')
								OPEN @SmallCursor 
								FETCH NEXT FROM @SmallCursor INTO @ItemId;
								FETCH NEXT FROM @SmallCursor INTO @Quantity;

								DECLARE @ItemQuantity int;
								SET @ItemQuantity = (SELECT SUM(Item.Quantity) FROM Item WHERE Item.ItemId = @ItemId);

								IF(@IsCustomer = 1)
								BEGIN
									INSERT INTO BillItem VALUES (@BillId,@ItemId,@Quantity,(SELECT SUM(Item.Price) FROM Item WHERE Item.ItemId = @ItemId))
									if(@IsDone = 1)
										UPDATE Item SET Quantity = Quantity - @Quantity WHERE ItemId = @ItemId;
								END
								ELSE 
									BEGIN
										IF(@ItemQuantity + @Quantity <0)
											SET @Quantity = -@ItemQuantity;
										INSERT INTO BillItem VALUES (@BillId,@ItemId,@Quantity,(SELECT SUM(Item.Price) FROM Item WHERE Item.ItemId = @ItemId))
										if(@IsDone = 1)
											UPDATE Item SET Quantity = @Quantity + Quantity WHERE ItemId = @ItemId;
									END

								CLOSE @SmallCursor ;
								DEALLOCATE @SmallCursor;
							END;
						  --
					  FETCH NEXT FROM @BigCursor INTO @BillItemData 
					END; 

					CLOSE @BigCursor ;
					DEALLOCATE @BigCursor;
					set @Message = N'[S]Thêm đơn Thành Công ID:' +CAST(@BillId as varchar(max))
					set @canAdd = 1;
					END;
				END;
	COMMIT
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCategory]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertCategory]
	@Name nvarchar(max), @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 
	DECLARE @Temp nvarchar(max);
	set @Temp =  LOWER(@Name);
	IF((SELECT COUNT(*) FROM Category WHERE LOWER(Category.Name) = @Temp) > 0)
	BEGIN
		set @Message = N'[F]Đã tồn tại.'
		return;
	END

	INSERT INTO Category VALUES (@Name);
	set @Message = N'[S]Thêm thành công ID:' + CAST(SCOPE_IDENTITY() as varchar(max));
END

-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCity]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertCity]
	@Name nvarchar(max), @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 
	DECLARE @Temp nvarchar(max);
	set @Temp =  LOWER(@Name);
	IF((SELECT COUNT(*) FROM City WHERE LOWER(City.Name) = @Temp) > 0)
	BEGIN
		set @Message = N'[F]Đã tồn tại.'
		return;
	END

	INSERT INTO City VALUES (@Name);
	set @Message = N'[S]Thêm thành công ID:' + CAST(SCOPE_IDENTITY() as varchar(max));
END

-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertItem]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_InsertItem]
	@Code varchar(max),@Name nvarchar(max),@Price money,@UnitId int,@AllCategory varchar(max),@Enable bit,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

	BEGIN TRANSACTION
		DECLARE @ItemId int;
		IF((SELECT COUNT(*) FROM Unit WHERE Unit.UnitId = @UnitId) = 0)
			BEGIN
				set @Message = N'[F]Đơn vị này không tồn tại. '
			END
		ELSE IF((SELECT COUNT(*) FROM Item WHERE Item.Code = @Code and Item.UnitId = @UnitId) > 0)
			BEGIN
				set @Message = N'[F]Code với đơn vị này đã tồn tại. '
			END
		ELSE
			BEGIN
				INSERT INTO Item VALUES (@Code,@Name,0,@UnitId,@Price,@Enable)
				SET @ItemId = SCOPE_IDENTITY();		

				DECLARE @Cursor CURSOR;
				DECLARE @CategoryId int;
				SET @Cursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@AllCategory,',')
					OPEN @Cursor 
				FETCH NEXT FROM @Cursor INTO @CategoryId
					
				WHILE @@FETCH_STATUS = 0
					BEGIN
						IF((SELECT COUNT(*) FROM Category WHERE CategoryId = @CategoryId)>0)
							INSERT INTO ItemCategory VALUES (@ItemId,@CategoryId)
						FETCH NEXT FROM @Cursor INTO @CategoryId
					END; 
				CLOSE @Cursor ;
				DEALLOCATE @Cursor;

				set @Message = N'[S]Thêm thành công ID:'+CAST(@ItemId as varchar(max))
			END
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPerson]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_InsertPerson]
	@Name ntext,@Phone varchar(11),@Email varchar(max)
	,@Address ntext,@CityId int
	,@Password varchar(max),@RoleId int = 3
	,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @DONE bit;
	set @DONE = 1;
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	BEGIN TRANSACTION 
		IF((SELECT COUNT(*) FROM Person WHERE Person.Phone = @Phone) > 0)
		BEGIN
			set @Message = N'[F]Đã tồn tại số điện thoại này. '
			set @DONE = 0;
		END
		IF(@Email is not null and (SELECT COUNT(*) FROM Person WHERE Person.Email = @Email) > 0)
		BEGIN
			set @Message = N'[F]Đã tồn tại email này. '
			set @DONE = 0;
		END
		IF((SELECT COUNT(*) FROM PersonRole WHERE PersonRole.RoleId = @RoleId) = 0)
		BEGIN
			set @Message = N'[F]Không tồn tại Role này. '
			set @DONE = 0;
		END
		IF((SELECT COUNT(*) FROM City WHERE City.CityId = @CityId) = 0)
		BEGIN
			set @Message = N'[F]Không tồn tại thành phố này. '
			set @DONE = 0;
		END

		IF(@DONE = 1)
			BEGIN
				INSERT INTO Person VALUES (@Name,@Phone,@Email,@Address,@CityId,@Password,@RoleId)
				set @Message = N'[S]Thêm thành công ID:' + CAST(SCOPE_IDENTITY() as varchar(max))
			END
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUnit]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertUnit]
	@Name nvarchar(max), @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 
	DECLARE @Temp nvarchar(max);
	set @Temp =  LOWER(@Name);
	IF((SELECT COUNT(*) FROM Unit WHERE LOWER(Unit.Name) = @Temp) > 0)
	BEGIN
		set @Message = N'[F]Đã tồn tại.'
		return;
	END

	INSERT INTO Unit VALUES (@Name);
	set @Message = N'[S]Thêm thành công ID:' + CAST(SCOPE_IDENTITY() as varchar(max));
END

-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Login] 
	@POE varchar(max),@Pass varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @Id int
	set @Id = (SELECT PersonId FROM Person WHERE (Person.Phone = @POE or Person.Email = @POE) and Person.Password = @Pass)
	print @Id
	If(@Id>0)
		select @Id
	else select -1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateBill]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdateBill]
	@BillId int, @Date datetime, @PersonId int, @TotalPrice money, @CityId int, @Address nvarchar(max), @IsCustomer bit = 1, @IsDone bit = 0, @AllBillItemData varchar(max),@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	BEGIN TRANSACTION
		DECLARE @canAdd bit;
		set @canAdd = 1;
		IF(@Date>GETDATE())
			BEGIN
				set @Message = N'[F]Ngày lập đơn không hợp lệ. '
				set @canAdd = 0;
			END
		IF((SELECT COUNT(*) FROM Person WHERE Person.PersonId = @PersonId) = 0)
			BEGIN
				set @Message = N'[F]Không tồn tại PersonId này. '
				set @canAdd = 0;
			END
		IF(@CityId is not null and (SELECT COUNT(*) FROM City WHERE City.CityId = @CityId) = 0)
			BEGIN
				set @Message = N'[F]Không tồn tại CityId này.'
				set @canAdd = 0;
			END
		IF((SELECT Count(*) FROM Bill WHERE Bill.BillId = @BillId and Bill.isDone = 1) = 1)
			BEGIN
				set @Message = N'[F]Đơn đã hoàn thành, không thể thay đổi.'
				set @canAdd = 0;
			END
		IF((SELECT COUNT(*) FROM Bill WHERE Bill.BillId = @BillId) = 0)
			BEGIN
				set @Message = N'[F]Không tồn tại đơn hàng này.' + CAST(@BIllId as varchar(max))
				set @canAdd = 0;
			END
		IF(@canAdd = 1)
			BEGIN
				set @canAdd = 0;

				-- SPLIT ALL DATA TO EACH BILLITEM
				BEGIN
					DELETE BillItem WHERE BillItem.BillId = @BillId
					DECLARE @BigCursor CURSOR;
					DECLARE @BillItemData varchar(max);
					SET @BigCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@AllBillItemData,';')
					OPEN @BigCursor 
					FETCH NEXT FROM @BigCursor INTO @BillItemData
					DECLARE @SmallCursor CURSOR;
					DECLARE @ItemId int;
					DECLARE @Quantity int;
					DECLARE @Price money;

					
					IF(@IsCustomer = 1 and @IsDone = 1 and @AllBillItemData!='')
					WHILE @@FETCH_STATUS = 0
						-- SPLIT DATA BILLITEM TO INSERT BILLITEM
						BEGIN
							BEGIN
								SET @SmallCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@BillItemData,',')
								OPEN @SmallCursor 
								FETCH NEXT FROM @SmallCursor INTO @ItemId;
								FETCH NEXT FROM @SmallCursor INTO @Quantity;

								IF((SELECT SUM(Item.Quantity) FROM Item WHERE Item.ItemId = @ItemId) < @Quantity)
									BEGIN
										set @Message = N'[F]Cập nhật đơn ' + @BillItemData + N' Thất Bại. Không đủ số lượng.'
										COMMIT;
										RETURN;
									END
							END;
						  --
						FETCH NEXT FROM @BigCursor INTO @BillItemData 
					END; 

					UPDATE Bill 
					SET Date=@Date,PersonId=@PersonId,TotalPrice=@TotalPrice,CityId=@CityId,Address=@Address,isCustomer=@IsCustomer,isDone=@IsDone
					WHERE BillId=@BillId

					SET @BigCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@AllBillItemData,';')
					OPEN @BigCursor 
					FETCH NEXT FROM @BigCursor INTO @BillItemData
					IF(@AllBillItemData!='')
					WHILE @@FETCH_STATUS = 0
						-- SPLIT DATA BILLITEM TO INSERT BILLITEM
						BEGIN
							BEGIN
								SET @SmallCursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@BillItemData,',')
								OPEN @SmallCursor 
								FETCH NEXT FROM @SmallCursor INTO @ItemId;
								FETCH NEXT FROM @SmallCursor INTO @Quantity;

								DECLARE @ItemQuantity int;
								SET @ItemQuantity = (SELECT SUM(Item.Quantity) FROM Item WHERE Item.ItemId = @ItemId);

								IF(@IsCustomer = 1)
								BEGIN
									INSERT INTO BillItem VALUES (@BillId,@ItemId,@Quantity,(SELECT SUM(Item.Price) FROM Item WHERE Item.ItemId = @ItemId))
									if(@IsDone = 1)
										UPDATE Item SET Quantity = Quantity - @Quantity WHERE ItemId = @ItemId;
								END
								ELSE 
									BEGIN
										IF(@ItemQuantity + @Quantity <0)
											SET @Quantity = -@ItemQuantity;
										INSERT INTO BillItem VALUES (@BillId,@ItemId,@Quantity,(SELECT SUM(Item.Price) FROM Item WHERE Item.ItemId = @ItemId))
										if(@IsDone = 1)
											UPDATE Item SET Quantity = @Quantity + Quantity WHERE ItemId = @ItemId;
									END

								CLOSE @SmallCursor ;
								DEALLOCATE @SmallCursor;
							END;
						  --
						FETCH NEXT FROM @BigCursor INTO @BillItemData 
						END; 

						CLOSE @BigCursor ;
						DEALLOCATE @BigCursor;
						set @Message = N'[S]Cập nhật đơn Thành Công.'
						set @canAdd = 1;
						END;
			END;

	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCategory]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateCategory]
	@CategoryId int,@Name nvarchar(max), @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 

	IF((SELECT COUNT(*) FROM Category WHERE CategoryId = @CategoryId) = 0)
	BEGIN
		set @Message = N'[F]Không tồn tại ID.'
		return
	END
	
	UPDATE Category SET Name = @Name WHERE CategoryId = @CategoryId;
	set @Message = N'[S]Cập nhật thành công.'
	return
END

-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCity]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateCity]
	@CityId int,@Name nvarchar(max), @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 

	IF((SELECT COUNT(*) FROM City WHERE City.CityId = @CityId) = 0)
	BEGIN
		set @Message = N'[F]Không tồn tại ID.'
		return
	END
	
	UPDATE City SET Name = @Name WHERE CityId = @CityId;
	set @Message = N'[S]Cập nhật thành công.'
	return
END

-- ==========================================================================================

SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateItem]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdateItem]
	@ItemId int,@Code varchar(max),@Name nvarchar(max),@Price money,@UnitId int,@AllCategory varchar(max),@Enable bit,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

	BEGIN TRANSACTION
		IF((SELECT COUNT(*) FROM Item WHERE Item.ItemId = @ItemId) = 0)
			BEGIN
				set @Message = N'[F]Không tồn tại Id này. '
			END
		ELSE IF((SELECT COUNT(*) FROM Item WHERE Item.Code = @Code and Item.UnitId = @UnitId and Item.ItemId!=@ItemId) > 0)
			BEGIN
				set @Message = N'[F]Code với đơn vị này đã tồn tại. '
			END
		ELSE
			BEGIN
				DELETE ItemCategory WHERE ItemCategory.ItemId = @ItemId 

				UPDATE ITEM SET Code=@Code,Name=@Name,UnitId=@UnitId,Price=@Price,Enable=@Enable WHERE ItemId=@ItemId
				DECLARE @Cursor CURSOR;
				DECLARE @CategoryId int;
				SET @Cursor = CURSOR FOR SELECT VALUE FROM STRING_SPLIT(@AllCategory,',')
					OPEN @Cursor
				FETCH NEXT FROM @Cursor INTO @CategoryId
					
				WHILE @@FETCH_STATUS = 0
					BEGIN
						IF((SELECT COUNT(*) FROM Category WHERE CategoryId = @CategoryId)>0)
							INSERT INTO ItemCategory VALUES (@ItemId,@CategoryId)
						FETCH NEXT FROM @Cursor INTO @CategoryId
					END; 
				CLOSE @Cursor ;
				DEALLOCATE @Cursor;

				set @Message = N'[S]Cập nhật thành công.'
			END
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePerson]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdatePerson]
	@PersonId int,@Name ntext,@Phone varchar(11),@Email varchar(max) = null
	,@Address ntext,@CityId int = null
	,@Password varchar(max) = null,@RoleId int = 3
	,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @DONE bit;
	set @DONE = 1;
	BEGIN TRANSACTION 
		IF((SELECT COUNT(*) FROM Person WHERE PersonId = @PersonId) = 0)
		BEGIN
			set @Message = N'[F]Không tồn tại Id này. '
			set @DONE = 0;
		END

		IF((SELECT COUNT(*) FROM Person WHERE Person.Phone = @Phone and Person.PersonId!=@PersonId) > 0)
		BEGIN
			set @Message = N'[F]Đã tồn tại số điện thoại này. '
			set @DONE = 0;
		END
		IF(@Email is not null and (SELECT COUNT(*) FROM Person WHERE Person.Email = @Email and Person.PersonId!=@PersonId) > 0)
		BEGIN
			set @Message = N'[F]Đã tồn tại email này. '
			set @DONE = 0;
		END
		IF((SELECT COUNT(*) FROM PersonRole WHERE PersonRole.RoleId = @RoleId) = 0)
		BEGIN
			set @Message = N'[F]Không tồn tại Role này. '
			set @DONE = 0;
		END
		IF(@CityId is not null and (SELECT COUNT(*) FROM City WHERE City.CityId = @CityId) = 0)
		BEGIN
			set @Message = N'[F]Không tồn tại thành phố này. '
			set @DONE = 0;
		END

		IF(@DONE = 1)
		BEGIN
			UPDATE Person 
			Set Name = @Name,Phone=@Phone,Email=@Email,Address=@Address
				,CityId=@CityId,Password=@Password,RoleId=@RoleId
			WHERE PersonId = @PersonId
			set @Message = N'[S]Cập nhật thành công.'
		END

	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePersonInfor]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdatePersonInfor]
	@PersonId int,@Name ntext,@Phone varchar(11),@Email varchar(max) = null
	,@Address ntext,@CityId int = null
	,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	BEGIN TRANSACTION 
		IF((SELECT COUNT(*) FROM Person WHERE PersonId = @PersonId) = 0)
		BEGIN
			set @Message = '[F]Không tồn tại. '
			ROLLBACK
		END

		UPDATE Person Set Phone=@Phone,Email=@Email WHERE PersonId = @PersonId
		IF((SELECT COUNT(*) FROM Person WHERE Person.Phone = @Phone) > 0)
		BEGIN
			set @Message = '[F]Đã tồn tại số điện thoại này. '
			ROLLBACK
		END
		IF(@Email is not null and (SELECT COUNT(*) FROM Person WHERE Person.Email = @Email) > 0)
		BEGIN
			set @Message = '[F]Đã tồn tại email này. '
			ROLLBACK
		END
		IF(@CityId is not null and (SELECT COUNT(*) FROM City WHERE City.CityId = @CityId) = 0)
		BEGIN
			set @Message = '[F]Không tồn tại thành phố này. '
			ROLLBACK
		END

		UPDATE Person 
		Set Name = @Name,Phone=@Phone,Email=@Email,Address=@Address
			,CityId=@CityId
		WHERE PersonId = @PersonId
		set @Message = '[S]Cập nhật thành công.'
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePersonPassword]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdatePersonPassword]
	@PersonId int,@Password varchar(max)
	,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	BEGIN TRANSACTION 
		IF((SELECT COUNT(*) FROM Person WHERE PersonId = @PersonId) = 0)
		BEGIN
			set @Message = '[F]Không tồn tại. '
			ROLLBACK
		END

		UPDATE Person 
		Set Password = @Password
		WHERE PersonId = @PersonId
		set @Message = '[S]Cập nhật thành công.'
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePersonRole]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdatePersonRole]
	@PersonId int,@RoleId int
	,@Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	BEGIN TRANSACTION 
		IF((SELECT COUNT(*) FROM Person WHERE PersonId = @PersonId) = 0)
		BEGIN
			set @Message = '[F]Không tồn tại. '
			ROLLBACK
		END

		IF((SELECT COUNT(*) FROM PersonRole WHERE PersonRole.RoleId = @RoleId) = 0)
		BEGIN
			set @Message = '[F]Không tồn tại Role này. '
			ROLLBACK
		END

		UPDATE Person 
		Set RoleId = @RoleId
		WHERE PersonId = @PersonId
		set @Message = '[S]Cập nhật thành công.'
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUnit]    Script Date: 26/01/2021 9:40:24 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateUnit]
	@UnitId int,@Name nvarchar(max), @Message nvarchar(max) out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON; 

	IF((SELECT COUNT(*) FROM Unit WHERE UnitId = @UnitId) = 0)
	BEGIN
		set @Message = N'[F]Không tồn tại ID.'
		return
	END
	
	UPDATE Unit SET Name = @Name WHERE UnitId = @UnitId;
	set @Message = N'[S]Cập nhật thành công.'
	return
END

-- ==========================================================================================

SET ANSI_NULLS ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Bill"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Person"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "City"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 126
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Bill'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Bill'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Category"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ItemCategory"
            Begin Extent = 
               Top = 7
               Left = 306
               Bottom = 126
               Right = 516
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "v1"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v2"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 126
               Right = 485
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Item"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 126
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Item'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Item'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Person"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 274
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "City"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 126
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PersonRole"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 126
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Person'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Person'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Unit"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 138
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Item"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2280
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Unit'
GO
USE [master]
GO
ALTER DATABASE [DB_ManageStore] SET  READ_WRITE 
GO
