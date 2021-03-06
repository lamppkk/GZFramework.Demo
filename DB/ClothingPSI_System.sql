USE [GZFrameworkDemo_System]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_SplitEx]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufn_SplitEx]
(
	@C VARCHAR(8000), --字符串
	@SPLIT VARCHAR(2), --分隔符
	@DeleEmpty INT--1,删除空值，2，不删除空
)
RETURNS @T TABLE(COL VARCHAR(50))   
AS   
BEGIN   

/***************************************************************
功能：SQL分割字符串并返回表

--测试案例：
SELECT * FROM dbo.ufn_SplitEx('11 ,22,33,44,55 ',',',1)
SELECT * FROM dbo.ufn_SplitEx(',22,',',',1)
SELECT * FROM dbo.ufn_SplitEx('10a0c745bd9f454baed387c02975dbce,382f031293214b15bd7f900ac0652a2b,8d0b1424ea6a4029bc13429fa9eb3398,9dfa32b6c61543c2b027b96c0693c1a2,c60520184e8d47f6b6dd3d9033d76877,c7f091144a2149c2a509343d1bac62d9,',',',1)
***************************************************************/
	IF ISNULL(@C,'')='' RETURN
	
	
	DECLARE @tmp VARCHAR(2000)
	
	WHILE(CHARINDEX(@SPLIT,@C)<>0)   
	BEGIN   
		SET @tmp=''
		SET @tmp=RTRIM(LTRIM(SUBSTRING(@C,1,CHARINDEX(@SPLIT,@C)-1)))
		
		--IF((SELECT COUNT(*) FROM @T WHERE COL=@tmp)=0)
			INSERT @T(COL) VALUES (@tmp)   
		SET @C=STUFF(@C,1,CHARINDEX(@SPLIT,@C),'')
	END 
	--IF((SELECT COUNT(*) FROM [@T] WHERE COL=@tmp)=0)  
		INSERT @T(COL) VALUES (RTRIM(LTRIM(@C)))  
	
	IF(@DeleEmpty=1)
		DELETE @T WHERE ISNULL(COL,'')=''
	
	RETURN   
END
GO
/****** Object:  Table [dbo].[dt_MyRole]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_MyRole](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RoleID] [varchar](10) NOT NULL,
	[DBCode] [varchar](50) NULL,
	[RoleName] [varchar](20) NULL,
	[Description] [nvarchar](50) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DT_MYROLE] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dt_MyRoleAuthority]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_MyRoleAuthority](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RoleID] [varchar](10) NULL,
	[FunctionID] [varchar](200) NULL,
	[Authority] [int] NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DT_MYROLEAUTHORITY] PRIMARY KEY CLUSTERED 
(
	[isid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dt_MyUser]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_MyUser](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Account] [varchar](20) NOT NULL,
	[Password] [varchar](200) NULL,
	[UserName] [nvarchar](20) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [nvarchar](200) NULL,
	[IsSysAdmain] [varchar](1) NULL,
	[IsSysLock] [varchar](1) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DT_MYUSER] PRIMARY KEY CLUSTERED 
(
	[Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dt_MyUserDBs]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_MyUserDBs](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Account] [varchar](20) NOT NULL,
	[DBCode] [varchar](50) NOT NULL,
	[IsDBLock] [varchar](1) NULL,
	[IsDBAdmin] [varchar](1) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DT_MYUSERDBS] PRIMARY KEY CLUSTERED 
(
	[Account] ASC,
	[DBCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dt_MyUserRole]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_MyUserRole](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Account] [varchar](20) NULL,
	[DBCode] [varchar](50) NULL,
	[RoleID] [varchar](20) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DT_MYUSERROLE] PRIMARY KEY CLUSTERED 
(
	[isid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_CommonSearch]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_CommonSearch](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[RowID] [varchar](50) NOT NULL,
	[SearchCode] [varchar](200) NULL,
	[strColumnName] [nvarchar](20) NULL,
	[strSQL] [varchar](100) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_COMMONSEARCH] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_CommonSearchUser]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_CommonSearchUser](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](20) NOT NULL,
	[RowID] [varchar](50) NOT NULL,
	[Flag] [varchar](1) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_COMMONSEARCHUSER] PRIMARY KEY CLUSTERED 
(
	[Account] ASC,
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_DataBaseList]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_DataBaseList](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[DBCode] [varchar](50) NOT NULL,
	[DBDisplayText] [nvarchar](20) NULL,
	[DBProviderName] [varchar](100) NULL,
	[DBServer] [nvarchar](50) NULL,
	[DBName] [nvarchar](100) NULL,
	[DBConnection] [nvarchar](2000) NULL,
 CONSTRAINT [PK_SYS_DATABASELIST] PRIMARY KEY CLUSTERED 
(
	[DBCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_DataBaseListAuthority]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_DataBaseListAuthority](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DBCode] [varchar](50) NULL,
	[FunctionID] [varchar](200) NULL,
	[Authority] [int] NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DT_DBAUTHORITY] PRIMARY KEY CLUSTERED 
(
	[isid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_DataSN]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_DataSN](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[DocCode] [varchar](50) NOT NULL,
	[DocName] [nvarchar](50) NULL,
	[DocHeader] [varchar](10) NULL,
	[Separate] [varchar](2) NULL,
	[DocType] [varchar](20) NULL,
	[Length] [int] NOT NULL,
	[Demo] [nvarchar](50) NULL,
 CONSTRAINT [PK_SYS_DATASN] PRIMARY KEY CLUSTERED 
(
	[DocCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_DataSNDetail]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_DataSNDetail](
	[DocCode] [varchar](50) NOT NULL,
	[Seed] [varchar](50) NOT NULL,
	[MaxID] [int] NULL,
 CONSTRAINT [PK_SYS_DATASNDETAIL] PRIMARY KEY CLUSTERED 
(
	[DocCode] ASC,
	[Seed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_GridViewLayout]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_GridViewLayout](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[LayoutID] [varchar](50) NOT NULL,
	[ViewCode] [varchar](200) NULL,
	[LayoutName] [nvarchar](50) NULL,
	[IsDefault] [varchar](1) NULL,
	[IntervalColor] [varchar](1) NULL,
	[HeadHeight] [int] NULL,
	[RowHeight] [int] NULL,
	[HorzLine] [varchar](1) NULL,
	[HorzLineColor] [int] NULL,
	[VertLine] [varchar](1) NULL,
	[VertLineColor] [int] NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_GRIDVIEWLAYOUT] PRIMARY KEY CLUSTERED 
(
	[LayoutID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_GridViewLayoutDetail]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_GridViewLayoutDetail](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[LayoutID] [varchar](50) NOT NULL,
	[FileName] [varchar](50) NOT NULL,
	[FileCaptionBK] [nvarchar](20) NULL,
	[FileCaption] [nvarchar](20) NULL,
	[IsShow] [varchar](1) NULL,
	[Width] [int] NULL,
	[FontColor] [int] NULL,
	[BackColor] [int] NULL,
	[Alignment] [int] NULL,
	[SummaryType] [int] NULL,
	[SummaryFormat] [nvarchar](20) NULL,
	[CreateUser] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [varchar](20) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_sys_GridViewLayoutDetail] PRIMARY KEY CLUSTERED 
(
	[LayoutID] ASC,
	[FileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_GridViewLayoutUser]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_GridViewLayoutUser](
	[isid] [int] IDENTITY(1,1) NOT NULL,
	[LayoutID] [varchar](50) NULL,
	[ConfigType] [varchar](1) NULL,
	[ConfigValue] [varchar](20) NULL,
 CONSTRAINT [PK_SYS_GRIDVIEWLAYOUTUSER] PRIMARY KEY CLUSTERED 
(
	[isid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_Modules]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_Modules](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Sort] [int] NULL,
	[ModuleID] [varchar](200) NOT NULL,
	[ModuleNameRef] [nvarchar](20) NULL,
	[ImgRef] [nvarchar](200) NULL,
	[ModuleName] [nvarchar](20) NULL,
	[Img] [nvarchar](200) NULL,
 CONSTRAINT [PK_SYS_MODULES] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_ModulesFunction]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_ModulesFunction](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ModuleID] [varchar](200) NULL,
	[FunctionID] [varchar](200) NOT NULL,
	[FunctionNameRef] [nvarchar](50) NULL,
	[ImgLargeRef] [nvarchar](200) NULL,
	[ImgSmallRef] [nvarchar](200) NULL,
	[FunctionName] [nvarchar](50) NULL,
	[ImgLarge] [nvarchar](200) NULL,
	[ImgSmall] [nvarchar](200) NULL,
	[AppDoc] [varchar](1) NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_SYS_MODULESFUNCTION] PRIMARY KEY CLUSTERED 
(
	[FunctionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_ModulesFunctionAuthority]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_ModulesFunctionAuthority](
	[isid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FunctionID] [varchar](200) NOT NULL,
	[AuthorityID] [int] NOT NULL,
	[AuthorityNameRef] [varchar](20) NULL,
	[AuthorityName] [varchar](20) NULL,
 CONSTRAINT [PK_SYS_FUNCTIONAUTHORITY] PRIMARY KEY CLUSTERED 
(
	[FunctionID] ASC,
	[AuthorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dt_MyRoleAuthority]  WITH CHECK ADD  CONSTRAINT [FK_DT_MYROL_REFERENCE_DT_MYROL] FOREIGN KEY([RoleID])
REFERENCES [dbo].[dt_MyRole] ([RoleID])
GO
ALTER TABLE [dbo].[dt_MyRoleAuthority] CHECK CONSTRAINT [FK_DT_MYROL_REFERENCE_DT_MYROL]
GO
ALTER TABLE [dbo].[dt_MyUserRole]  WITH CHECK ADD  CONSTRAINT [FK_DT_MYUSE_REFERENCE_DT_MYUSE] FOREIGN KEY([Account])
REFERENCES [dbo].[dt_MyUser] ([Account])
GO
ALTER TABLE [dbo].[dt_MyUserRole] CHECK CONSTRAINT [FK_DT_MYUSE_REFERENCE_DT_MYUSE]
GO
ALTER TABLE [dbo].[sys_CommonSearchUser]  WITH CHECK ADD  CONSTRAINT [FK_SYS_COMM_REFERENCE_SYS_COMM] FOREIGN KEY([RowID])
REFERENCES [dbo].[sys_CommonSearch] ([RowID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_CommonSearchUser] CHECK CONSTRAINT [FK_SYS_COMM_REFERENCE_SYS_COMM]
GO
ALTER TABLE [dbo].[sys_DataBaseListAuthority]  WITH CHECK ADD  CONSTRAINT [FK_DT_DBAUT_REFERENCE_SYS_DATA_AuthOrity] FOREIGN KEY([DBCode])
REFERENCES [dbo].[sys_DataBaseList] ([DBCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_DataBaseListAuthority] CHECK CONSTRAINT [FK_DT_DBAUT_REFERENCE_SYS_DATA_AuthOrity]
GO
ALTER TABLE [dbo].[sys_GridViewLayoutDetail]  WITH CHECK ADD  CONSTRAINT [FK_SYS_GRID_REFERENCE_SYS_GRID_Detail] FOREIGN KEY([LayoutID])
REFERENCES [dbo].[sys_GridViewLayout] ([LayoutID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_GridViewLayoutDetail] CHECK CONSTRAINT [FK_SYS_GRID_REFERENCE_SYS_GRID_Detail]
GO
ALTER TABLE [dbo].[sys_GridViewLayoutUser]  WITH CHECK ADD  CONSTRAINT [FK_SYS_GRID_REFERENCE_SYS_GRID] FOREIGN KEY([LayoutID])
REFERENCES [dbo].[sys_GridViewLayout] ([LayoutID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_GridViewLayoutUser] CHECK CONSTRAINT [FK_SYS_GRID_REFERENCE_SYS_GRID]
GO
/****** Object:  StoredProcedure [dbo].[__usp_sys_GetModules_CurrentUser]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[__usp_sys_GetModules_CurrentUser]
	@Account VARCHAR(50)
AS
BEGIN
		/**************************************************
			-- 功能：获得模块列表
			-- 时间：2015年1月29日17:04:34
			-- 作者：GarsonZhang
			-- 备注：
			-- 测试：
			
			
			SELECT * FROM dbo.sys_Modules
			SELECT * FROM dbo.sys_ModulesFunction
			SELECT * FROM dbo.sys_ModulesFunctionAuthority

			usp_sys_GetModules_CurrentUser ''
		**************************************************/
		
		SELECT FunctionID,dbo.BinaryOrOperation(Authority) AS Authority INTO #tmp
		FROM dbo.dt_MyRoleAuthority WHERE RoleID IN(SELECT RoleID FROM dbo.dt_MyUserRole WHERE Account=@Account)
		GROUP BY FunctionID
		
		
		SELECT a.*,b.Authority AS DBAuthority,a.AuthorityID&ISNULL(b.Authority,0) AS Flag INTO #ModulesFunctionAuthorityID FROM dbo.sys_ModulesFunctionAuthority AS a LEFT JOIN #tmp AS b ON b.FunctionID = a.FunctionID
		
		DELETE FROM #ModulesFunctionAuthorityID WHERE Flag<>AuthorityID
		
		
		
		SELECT * INTO #ModulesFunction FROM dbo.sys_ModulesFunction WHERE FunctionID IN(SELECT DISTINCT FunctionID FROM #ModulesFunctionAuthorityID)
		
		SELECT * INTO #Modules FROM dbo.sys_Modules WHERE ModuleID IN(SELECT DISTINCT ModuleID FROM #ModulesFunction)
		

		
		CREATE TABLE #Result(
			PKey VARCHAR(200),
			ParentKey VARCHAR(200),
			DisplayName VARCHAR(200),
			ModuleID VARCHAR(200),
			FunctionID VARCHAR(200),
			AuthorityID INT
		)

		INSERT INTO #Result(PKey,ParentKey,DisplayName,ModuleID)
		SELECT ModuleID,'',ModuleName,ModuleID FROM #Modules

		INSERT INTO #Result(PKey,ParentKey,DisplayName,FunctionID)
		SELECT FunctionID,ModuleID,FunctionName,FunctionID FROM #ModulesFunction

		INSERT INTO #Result(PKey,ParentKey,DisplayName,AuthorityID)
		SELECT FunctionID+'.'+CAST(AuthorityID AS VARCHAR),FunctionID,AuthorityName,AuthorityID FROM #ModulesFunctionAuthorityID

		SELECT * FROM #Result
		
		
		
END

GO
/****** Object:  StoredProcedure [dbo].[_DataInitialization]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

create procedure [dbo].[_DataInitialization] 
as
BEGIN
	/*******************************************************
		-- 删除模块
	*******************************************************/
    INSERT INTO dbo.dt_MyUser( Account ,[Password] ,UserName,IsSysAdmain)
    VALUES('admin','ovj25JBDGEc=','管理员','Y')
END

GO
/****** Object:  StoredProcedure [dbo].[sys_GetDataSN]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sys_GetDataSN] 
    @DocCode VARCHAR(50),
    @CustomerSeed VARCHAR(50)='',
    @CustomerHead VARCHAR(50)=''
AS
BEGIN
/*-------------------------------------------------------------------------------------
  程序说明:返回单据号码
  返回结果:MAX_NO
  -------------------------------------------------------------------------------------

sys_GetDataSN 'BANK'

SELECT * FROM dbo.sys_DataSN

-------------------------------------------------------------------------------------*/

	IF NOT EXISTS(SELECT * FROM sys_DataSN WHERE DocCode=@DocCode)
	BEGIN
		SELECT ''
		RETURN;
	END
	
	DECLARE @DocHeader VARCHAR(50),@DocType VARCHAR(50),@Length INT,@Separate VARCHAR(2)

	SELECT @DocHeader=DocHeader,@DocType=DocType,@Length=[Length],@Separate=Separate FROM sys_DataSN WHERE DocCode=@DocCode
	
		
	DECLARE @DocSeed VARCHAR(100)
	IF(@DocType='Year')--年,递增
		SET @DocSeed=CONVERT(VARCHAR(4),GETDATE(),23)
	IF(@DocType='Year-Month')--年-月,递增
		SET @DocSeed=CONVERT(VARCHAR(7),GETDATE(),23)
	IF(@DocType='Year-Month-dd')--年-月-日,递增
		SET @DocSeed=CONVERT(VARCHAR(10),GETDATE(),23)
	IF(@DocType='Up')--直接递增
		SET @DocSeed=@DocCode
	IF(@DocType='Customer')--自定义
		SET @DocSeed=@CustomerSeed
	
	DECLARE @Value VARCHAR(100)
	EXEC sys_GetDataSNBase @DocCode,@DocSeed,@Length,@Value OUTPUT
	
	IF(@DocType='Customer')
		SELECT ISNULL(@CustomerHead,'')+@Value
	ELSE
		SELECT ISNULL(@DocHeader,'')+ISNULL(@Separate,'')+@Value
  -----------------------------------------END--------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sys_GetDataSNBase]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sys_GetDataSNBase] 
    @DocCode VARCHAR(50),
    @Seed VARCHAR(50),
    @Length INT =4, --预设4位长度 
    @Result VARCHAR(50) OUT
AS
BEGIN
/*-------------------------------------------------------------------------------------
  程序说明:返回单据号码
  返回结果:MAX_NO
  -------------------------------------------------------------------------------------
--delete FROM sys_DataSN
select FROM sys_DataSN

---测试--------


sys_GetDataSNBase 'A',4 

select * from sys_DataSN
select * from sys_DataSNDetail

DECLARE @param1 VARCHAR(100)
EXEC sys_GetDataSNBase '9','',4,@param1 OUTPUT
SELECT @param1

-------------------------------------------------------------------------------------*/
	DECLARE @Value INT

	SELECT @Value=MaxID FROM dbo.sys_DataSNDetail WHERE DocCode=@DocCode AND Seed=@Seed

	IF (@Value IS NULL)
	BEGIN
	    SELECT @Value=0
		INSERT INTO dbo.sys_DataSNDetail(DocCode,Seed,MaxID)
		VALUES (@DocCode,@Seed,0)
	END

	SET @Value=ISNULL(@Value,0)+1 /*取最大值+1,为返回的流水号,过滤掉带4的号码*/

	WHILE(CHARINDEX('4',@Value)>0)
	BEGIN
		SET @Value=@Value+1
	END
	WHILE(CHARINDEX('47',@Value)>0)/*过滤掉带47的号码*/
	BEGIN
		SET @Value=@Value+1
	END
	
	UPDATE dbo.sys_DataSNDetail SET MaxID=@Value WHERE DocCode=@DocCode AND Seed=@Seed /*更新流水号*/

	SET @Result=RIGHT(REPLACE(SPACE(@Length),' ','0')+CAST(@Value AS VARCHAR),@Length)	


	RETURN
  -----------------------------------------END--------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[usp_CommonSearch_Search]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CommonSearch_Search]
	@SearchCode VARCHAR(200)
AS
BEGIN
	SELECT * FROM dbo.sys_CommonSearch WHERE SearchCode=@SearchCode
END	
	
GO
/****** Object:  StoredProcedure [dbo].[usp_CommonSearchUser_Search]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CommonSearchUser_Search]
	@SearchCode VARCHAR(200),
	@Account VARCHAR(20)
AS
BEGIN
	SELECT * INTO #tmp FROM dbo.sys_CommonSearch WHERE SearchCode=@SearchCode
	
	SELECT * INTO #tmpu FROM dbo.sys_CommonSearchUser WHERE Account=@Account AND RowID IN (SELECT RowID FROM dbo.sys_CommonSearch WHERE SearchCode=@SearchCode)
	
	SELECT b.isid,
			Account=ISNULL(b.Account,@Account),
			a.RowID,a.strColumnName,a.strSQL ,b.Flag,b.CreateUser,b.CreateDate,b.LastUpdateUser,b.LastUpdateDate
	FROM  #tmp AS a LEFT JOIN #tmpu AS b ON b.RowID = a.RowID
END	
	
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserDBList]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetUserDBList]
	@Account VARCHAR(20)
AS
BEGIN
	/************************************************************
		-- 功能：获得用户的数据库权限列表
		-- 时间：2016年1月23日09:52:02
		-- 作者：GarsonZhang
		-- 备注：
		-- 测试:
	************************************************************/
	IF EXISTS(SELECT * FROM dbo.dt_MyUser WHERE Account=@Account AND IsSysAdmain='Y')
	BEGIN
		SELECT * FROM sys_DataBaseList
	END
	ELSE
	BEGIN
		SELECT a.* FROM dbo.sys_DataBaseList AS a INNER JOIN dbo.dt_MyUserDBs AS b ON b.DBCode = a.DBCode WHERE b.Account=@Account	
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetViewLayout_Default]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetViewLayout_Default]
	@ViewCode VARCHAR(200)
	
AS
BEGIN
	/******************************************************
		-- 功能：获得数据控件布局
		usp_GetViewLayoutUser '',''
		
	******************************************************/

		DECLARE @LayoutID VARCHAR(50)
		SELECT @LayoutID=LayoutID FROM dbo.sys_GridViewLayout WHERE ViewCode=@ViewCode AND IsDefault='Y'
		
		SELECT * FROM dbo.sys_GridViewLayout WHERE LayoutID=@LayoutID
		SELECT * FROM dbo.sys_GridViewLayoutDetail WHERE LayoutID=@LayoutID ORDER BY isid
		SELECT * FROM dbo.sys_GridViewLayoutUser WHERE LayoutID=@LayoutID
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetViewLayoutLayoutID]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetViewLayoutLayoutID]
	@ViewCode VARCHAR(200),
	@LayoutID VARCHAR(50)
AS
BEGIN
	/******************************************************
		-- 功能：获得数据控件布局
		usp_GetViewLayoutUser '',''
	******************************************************/

		SELECT * FROM dbo.sys_GridViewLayout WHERE LayoutID=@LayoutID
		SELECT * FROM dbo.sys_GridViewLayoutDetail WHERE LayoutID=@LayoutID ORDER BY isid
		SELECT * FROM dbo.sys_GridViewLayoutUser WHERE LayoutID=@LayoutID
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetViewLayoutUser]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetViewLayoutUser]
	@ViewCode VARCHAR(200),
	@Account VARCHAR(20)
AS
BEGIN
	/******************************************************
		-- 功能：获得数据控件布局
		usp_GetViewLayoutUser '',''
	******************************************************/
	DECLARE @LayoutID VARCHAR(50)
	
	SELECT * INTO #tmp FROM dbo.sys_GridViewLayoutUser 
	WHERE LayoutID IN(SELECT LayoutID FROM dbo.sys_GridViewLayout WHERE ViewCode=@ViewCode) 
	
	SELECT TOP 1 @LayoutID=LayoutID FROM #tmp 
	WHERE (ConfigType=1 AND ConfigValue=@Account) OR (ConfigType=2 AND ConfigValue IN (SELECT RoleID FROM dbo.dt_MyUserRole WHERE Account=@Account))
	ORDER BY isid DESC
	
	IF(ISNULL(@LayoutID,'')='') SELECT @LayoutID=LayoutID FROM dbo.sys_GridViewLayout WHERE ViewCode=@ViewCode AND IsDefault='Y'
	
	IF(ISNULL(@LayoutID,'')='')
	BEGIN
		SELECT TOP 0 * FROM dbo.sys_GridViewLayout
		SELECT TOP 0 * FROM dbo.sys_GridViewLayoutDetail
	END
	ELSE
	BEGIN
		SELECT * FROM dbo.sys_GridViewLayout WHERE LayoutID=@LayoutID
		SELECT * FROM dbo.sys_GridViewLayoutDetail WHERE LayoutID=@LayoutID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GridViewLayout_IDOfUser]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GridViewLayout_IDOfUser]
	@ViewCode VARCHAR(200),
	@Account VARCHAR(20)
AS
BEGIN
	/*****************************************
		usp_GridViewLayout_IDOfUser '',''
	*****************************************/
		DECLARE @LayoutID VARCHAR(50)
	
	SELECT * INTO #tmp FROM dbo.sys_GridViewLayoutUser 
	WHERE LayoutID IN(SELECT LayoutID FROM dbo.sys_GridViewLayout WHERE ViewCode=@ViewCode) 
	
	SELECT TOP 1 @LayoutID=LayoutID FROM #tmp 
	WHERE (ConfigType=1 AND ConfigValue=@Account) OR (ConfigType=2 AND ConfigValue IN (SELECT RoleID FROM dbo.dt_MyUserRole WHERE Account=@Account))
	ORDER BY isid DESC
	
	IF(ISNULL(@LayoutID,'')='') SELECT @LayoutID=LayoutID FROM dbo.sys_GridViewLayout WHERE ViewCode=@ViewCode AND IsDefault='Y'
	
	SELECT @LayoutID AS LayoutID
END
GO
/****** Object:  StoredProcedure [dbo].[usp_MyUser_GetUserModules]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_MyUser_GetUserModules] 
	@DBCode VARCHAR(50),
	@Account VARCHAR(20) 
AS
BEGIN
	/**************************************************
		-- 功能：获得当前用户的权限菜单
		-- 时间：2015-2-2 14:01:23
		-- 作者：GarsonZhang
		-- 备注：
		-- 测试：
		usp_MyUser_GetUserModules 'Data','garson'
		usp_MyUser_GetUserModules 'Data','admin'
		usp_MyUser_GetUserModules 'Data','zgs'
		
	
	**************************************************/
	
		
		DECLARE @Admin INT
		
		SELECT @Admin=ISNULL(@Admin,0)+ COUNT(*) FROM dbo.dt_MyUser WHERE Account=@Account AND IsSysAdmain='Y'
		SELECT @Admin=ISNULL(@Admin,0)+ COUNT(*) FROM dbo.dt_MyUserDBs WHERE Account=@Account AND DBCode=@DBCode AND IsDBAdmin='Y' 
		
		IF (@Admin>0)--管理员
		BEGIN
			SELECT * FROM dbo.sys_Modules ORDER BY Sort
			SELECT *,1073741823 AS UserAuthority FROM dbo.sys_ModulesFunction ORDER BY Sort
			
		END
		ELSE--非管理员
		BEGIN
			--SELECT FunctionID,dbo.BinaryOrOperation(Authority) AS Authority INTO #tmpAuthorityUser
			--FROM dbo.dt_MyRoleAuthority WHERE RoleID IN(SELECT RoleID FROM dbo.dt_MyUserRole WHERE Account=@Account)
			--GROUP BY FunctionID
			
			SELECT RoleID INTO #tmp FROM dbo.dt_MyUserRole  WHERE Account=@Account

			SELECT FunctionID,0 AS Authority INTO #tmpAuthorityUser
			FROM dbo.dt_MyRoleAuthority 
			WHERE RoleID IN(SELECT * FROM #tmp)
			GROUP BY FunctionID

			DECLARE @RoleID VARCHAR(20)

			WHILE EXISTS(SELECT * FROM #tmp)
			BEGIN
				SELECT TOP 1 @RoleID=RoleID FROM #tmp
				UPDATE #tmpAuthorityUser SET Authority=b.Authority|a.Authority
				FROM (SELECT * FROM dbo.dt_MyRoleAuthority WHERE RoleID=@RoleID) AS a INNER JOIN #tmpAuthorityUser AS b ON b.FunctionID = a.FunctionID
				DELETE FROM #tmp WHERE RoleID=@RoleID
			END

			
			SELECT * INTO #tmpAuthorityDB FROM dbo.sys_DataBaseListAuthority WHERE DBCode=@DBCode
			
			
			SELECT a.FunctionID,a.Authority&b.Authority AS UserAuthority INTO #tmpAuthority FROM #tmpAuthorityUser AS a INNER JOIN #tmpAuthorityDB AS b ON b.FunctionID = a.FunctionID
			
			SELECT a.*,b.UserAuthority INTO #ResultFunction FROM dbo.sys_ModulesFunction AS a INNER JOIN #tmpAuthority AS b ON b.FunctionID = a.FunctionID
			
			SELECT * FROM dbo.sys_Modules WHERE ModuleID IN(SELECT DISTINCT ModuleID FROM #ResultFunction )
			
			SELECT * FROM #ResultFunction
		END
		
		

	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetModules]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_sys_GetModules]
AS
BEGIN
		/**************************************************
			-- 功能：获得模块列表
			-- 时间：2015年1月29日17:04:34
			-- 作者：GarsonZhang
			-- 备注：
			-- 测试：
			
			
			SELECT * FROM dbo.sys_Modules
			SELECT * FROM dbo.sys_ModulesFunction
			SELECT * FROM dbo.sys_ModulesFunctionAuthority



			usp_sys_GetModules
		**************************************************/
		CREATE TABLE #Result(
			PKey VARCHAR(200),
			ParentKey VARCHAR(200),
			DisplayName VARCHAR(200),
			ModuleID VARCHAR(200),
			FunctionID VARCHAR(200),
			AuthorityID INT
		)

		INSERT INTO #Result(PKey,ParentKey,DisplayName,ModuleID)
		SELECT ModuleID,'',ModuleName,ModuleID FROM dbo.sys_Modules

		INSERT INTO #Result(PKey,ParentKey,DisplayName,FunctionID)
		SELECT FunctionID,ModuleID,FunctionName,FunctionID FROM dbo.sys_ModulesFunction

		INSERT INTO #Result(PKey,ParentKey,DisplayName,AuthorityID)
		SELECT FunctionID+'.'+CAST(AuthorityID AS VARCHAR),FunctionID,AuthorityName,AuthorityID FROM dbo.sys_ModulesFunctionAuthority

		SELECT * FROM #Result
END

GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetModules_LoginDB]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_sys_GetModules_LoginDB]
	@DBCode VARCHAR(50)
AS
BEGIN
		/**************************************************
			-- 功能：获得模块列表
			-- 时间：2015年1月29日17:04:34
			-- 作者：GarsonZhang
			-- 备注：
			-- 测试：
			
			
			SELECT * FROM dbo.sys_Modules
			SELECT * FROM dbo.sys_ModulesFunction
			SELECT * FROM dbo.sys_ModulesFunctionAuthority



			usp_sys_GetModules_LoginDB ''
		**************************************************/

		SELECT FunctionID,Authority INTO #tmp FROM sys_DataBaseListAuthority WHERE DBCode=@DBCode
		
		SELECT a.*,b.Authority AS DBAuthority,a.AuthorityID&ISNULL(b.Authority,0) AS Flag INTO #ModulesFunctionAuthorityID FROM dbo.sys_ModulesFunctionAuthority AS a LEFT JOIN #tmp AS b ON b.FunctionID = a.FunctionID
		
		DELETE FROM #ModulesFunctionAuthorityID WHERE Flag<>AuthorityID
		
		
		
		SELECT * INTO #ModulesFunction FROM dbo.sys_ModulesFunction WHERE FunctionID IN(SELECT DISTINCT FunctionID FROM #ModulesFunctionAuthorityID)
		
		SELECT * INTO #Modules FROM dbo.sys_Modules WHERE ModuleID IN(SELECT DISTINCT ModuleID FROM #ModulesFunction)
		

		
		CREATE TABLE #Result(
			PKey VARCHAR(200),
			ParentKey VARCHAR(200),
			DisplayName VARCHAR(200),
			ModuleID VARCHAR(200),
			FunctionID VARCHAR(200),
			AuthorityID INT
		)

		INSERT INTO #Result(PKey,ParentKey,DisplayName,ModuleID)
		SELECT ModuleID,'',ModuleName,ModuleID FROM #Modules

		INSERT INTO #Result(PKey,ParentKey,DisplayName,FunctionID)
		SELECT FunctionID,ModuleID,FunctionName,FunctionID FROM #ModulesFunction

		INSERT INTO #Result(PKey,ParentKey,DisplayName,AuthorityID)
		SELECT FunctionID+'.'+CAST(AuthorityID AS VARCHAR),FunctionID,AuthorityName,AuthorityID FROM #ModulesFunctionAuthorityID

		SELECT * FROM #Result
		
		
		
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UserLogin]    Script Date: 2017-06-21 23:20:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UserLogin]
	@Account VARCHAR(20),
	@Pwd VARCHAR(200),
	@LoginDBCode VARCHAR(50)=''
AS
BEGIN
	/************************************************************
		-- 功能：验证账套 用户名密码
		-- 时间：2016年1月23日09:52:02
		-- 作者：GarsonZhang
		-- 备注：
		-- 测试:
		usp_UserLogin 'admin','ovj25JBDGEc=',''
		usp_UserLogin 'admin','ovj25JBDGEc=','DBData'
	************************************************************/	
	SELECT * INTO #tmpuser FROM dbo.dt_MyUser WHERE Account=@Account AND [Password]=@Pwd
	
	SELECT * INTO #tmpuserdb FROM dbo.dt_MyUserDBs WHERE Account=@Account AND DBCode=@LoginDBCode
	
	SELECT a.*,b.DBCode,b.IsDBLock,b.IsDBAdmin FROM #tmpuser AS a LEFT JOIN #tmpuserdb AS b ON b.Account = a.Account
	
END	
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'isid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'RoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'RoleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CreateUser' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CreateDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LastUpdateUser' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LastUpdateDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRole'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'isid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'RoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'FunctionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'Authority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CreateUser' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CreateDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LastUpdateUser' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LastUpdateDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyRoleAuthority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是管理员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'IsSysAdmain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账套标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'DBCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'IsDBLock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是管理员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'IsDBAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户账套' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserDBs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账套编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'DBCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'RoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户角色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_MyUserRole'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'RowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检索标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'SearchCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检所列名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'strColumnName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL语句' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'strSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通用多列检索配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'RowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'Flag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户通用检索设置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_CommonSearchUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'DBCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'DBDisplayText'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'DBProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务器地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'DBServer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'链接字符串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList', @level2type=N'COLUMN',@level2name=N'DBConnection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'isid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账套标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'DBCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'FunctionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'Authority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CreateUser' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CreateDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LastUpdateUser' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LastUpdateDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账套功能配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataBaseListAuthority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'DocCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'DocName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据头' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'DocHeader'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分割线' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'Separate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'DocType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'长度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN', @level2type=N'COLUMN',@level2name=N'Length'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据号码表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSNDetail', @level2type=N'COLUMN',@level2name=N'DocCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增长种子' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSNDetail', @level2type=N'COLUMN',@level2name=N'Seed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSNDetail', @level2type=N'COLUMN',@level2name=N'MaxID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据号码表2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_DataSNDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'LayoutID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'视图编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'ViewCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'LayoutName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认布局' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'IsDefault'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交替行颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'IntervalColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表头高度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'HeadHeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行高度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'RowHeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'水平线' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'HorzLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'水平线颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'HorzLineColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'垂直线' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'VertLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'垂直线颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'VertLineColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayout'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'LayoutID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'FileCaptionBK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'FileCaption'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'IsShow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'Width'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文字颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'FontColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'背景颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'BackColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对其方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'Alignment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'SummaryType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示格式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'SummaryFormat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'CreateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'LastUpdateUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail', @level2type=N'COLUMN',@level2name=N'LastUpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局明细' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutUser', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutUser', @level2type=N'COLUMN',@level2name=N'LayoutID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型(用户/角色)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutUser', @level2type=N'COLUMN',@level2name=N'ConfigType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutUser', @level2type=N'COLUMN',@level2name=N'ConfigValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'布局配置权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_GridViewLayoutUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'ModuleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认模块名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'ModuleNameRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认模块图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'ImgRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'ModuleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules', @level2type=N'COLUMN',@level2name=N'Img'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统模块' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_Modules'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'ModuleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'FunctionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认功能名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'FunctionNameRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认图片(大)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'ImgLargeRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认图片(小)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'ImgSmallRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'FunctionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片(大)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'ImgLarge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片(小)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'ImgSmall'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'业务审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'AppDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块功能' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunctionAuthority', @level2type=N'COLUMN',@level2name=N'isid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunctionAuthority', @level2type=N'COLUMN',@level2name=N'FunctionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunctionAuthority', @level2type=N'COLUMN',@level2name=N'AuthorityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认权限名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunctionAuthority', @level2type=N'COLUMN',@level2name=N'AuthorityNameRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunctionAuthority', @level2type=N'COLUMN',@level2name=N'AuthorityName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_ModulesFunctionAuthority'
GO
