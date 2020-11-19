USE [Cure_University]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[School_ID] [int] NULL,
	[First_Name] [nvarchar](20) NULL,
	[Last_Name] [nvarchar](20) NULL,
	[Adress] [nvarchar](80) NULL,
	[Email] [nvarchar](50) NULL,
	[Contact_Number] [varchar](12) NULL,
	[Username] [varchar](40) NULL,
	[Activity] [varchar](9) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COURSES]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COURSES](
	[SchoolId] [int] NULL,
	[Course] [varchar](60) NULL,
	[Assignment_Name] [varchar](50) NULL,
	[Assignment_Type] [varchar](50) NULL,
	[Assignment_Data] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[All students]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE VIEW [dbo].[All students]
		AS
		SELECT School_ID, First_Name, Last_Name, Adress, Email, Contact_Number, Username, Activity, COURSES.Course
		FROM Users 
		LEFT join COURSES
		ON Users.School_ID = SchoolId WHERE (School_ID < 4000)
GO
/****** Object:  View [dbo].[All Teachers]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE VIEW [dbo].[All Teachers]
		AS
		SELECT School_ID, First_Name, Last_Name, Adress, Email, Contact_Number, Username, Activity, COURSES.Course
		FROM Users 
		LEFT join COURSES
		ON Users.School_ID = SchoolId WHERE (School_ID < 7000) AND (School_ID > 5999)
GO
/****** Object:  Table [dbo].[CourseDetails]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseDetails](
	[CourseName] [varchar](40) NULL,
	[CreditHours] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[SchoolID] [int] NULL,
	[Message] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Email] [varchar](40) NULL,
	[Role] [varchar](10) NULL,
	[Password] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spCheckCredentials]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCheckCredentials]
@Email NVARCHAR(40),
@Password VARCHAR(10)
AS
BEGIN
	SELECT [Role] FROM Roles WHERE (Email=REPLACE(@Email,'%40','@') AND [Password]=@Password)
END
GO
/****** Object:  StoredProcedure [dbo].[spChooseTeacher]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spChooseTeacher]
@Course VARCHAR(20)
AS
BEGIN
	SELECT * FROM COURSES WHERE Course = @Course
END
GO
/****** Object:  StoredProcedure [dbo].[spCourseRegister]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCourseRegister]
@Email NVARCHAR (100),
@CourseName VARCHAR(20)
AS
BEGIN

	IF(((SELECT 1 FROM (SELECT * FROM COURSES WHERE SchoolId = (SELECT School_ID FROM Users WHERE Email=REPLACE(@Email,'%40','@'))) AS Coursess WHERE Course = @CourseName)) > 0)
	BEGIN
	PRINT'ALREADY REGISTERED IN THIS COURSE'
	SELECT 0
	END
	ELSE
	BEGIN
	INSERT INTO COURSES(SchoolId, Course)
	VALUES ((SELECT School_ID FROM Users WHERE Email=REPLACE(@Email,'%40','@')),@CourseName)
	SELECT 1
	PRINT'Course Registered'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spEditCourse]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spEditCourse]
@CourseRefrence VARCHAR(20),
@CourseName VARCHAR(20),
@CourseCredits INT
AS
BEGIN
	UPDATE CourseDetails SET CourseName = @CourseName, CreditHours = @CourseCredits WHERE CourseName = @CourseRefrence
	UPDATE COURSES SET Course = @CourseName WHERE Course = @CourseRefrence
END
GO
/****** Object:  StoredProcedure [dbo].[spGetId]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spGetId] 
@Email VARCHAR(40)
AS
BEGIN
	SELECT * FROM Users WHERE School_ID =  (SELECT School_ID FROM Users WHERE Email=@Email)

END
GO
/****** Object:  StoredProcedure [dbo].[spMessage]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spMessage]
@SchoolID INT,
@message VARCHAR(255)
AS
BEGIN
	SELECT 1 FROM [dbo].[Messages] WHERE SchoolID = @SchoolID

	UPDATE [dbo].[Messages] SET [Message] = @message WHERE SchoolID = @SchoolID

END
GO
/****** Object:  StoredProcedure [dbo].[spReadMessage]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spReadMessage]
@SchoolID INT
AS
BEGIN
	SELECT [Message] FROM [dbo].[Messages] WHERE SchoolID=@SchoolID
END
GO
/****** Object:  StoredProcedure [dbo].[spShowCourses]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spShowCourses]
AS
BEGIN
	SELECT CourseName, CreditHours FROM CourseDetails
END
GO
/****** Object:  StoredProcedure [dbo].[spShowCredits]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spShowCredits]
@Email NVARCHAR(50)
AS
BEGIN

	SELECT SUM(CreditHours)
	FROM (	SELECT CourseDetails.CreditHours 
	FROM (SELECT SchoolId,Course FROM COURSES WHERE SchoolId = ((SELECT School_ID FROM Users WHERE Email=REPLACE(@Email,'%40','@')))) AS Tabl
	INNER JOIN CourseDetails
	ON CourseDetails.CourseName = Tabl.Course) AS CreditHours
	
END
GO
/****** Object:  StoredProcedure [dbo].[spShowRegisteredCourse]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spShowRegisteredCourse]
@Email NVARCHAR(50)
AS
BEGIN
	SELECT Course FROM COURSES WHERE SchoolId = ((SELECT School_ID FROM Users WHERE Email=REPLACE(@Email,'%40','@')))
END
GO
/****** Object:  StoredProcedure [dbo].[spShowTeacher]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spShowTeacher]
@CourseName VARCHAR(50)
AS
BEGIN
SELECT TAB2.First_Name FROM(SELECT * FROM (SELECT * FROM (SELECT SchoolId FROM COURSES WHERE COURSE = @CourseName)
AS ID WHERE (SchoolID > 5999 AND SchoolID <6999)) AS TAB1
INNER JOIN USERS
ON TAB1.SchoolId = Users.School_ID) AS TAB2
END
GO
/****** Object:  StoredProcedure [dbo].[spstudentSignup]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spstudentSignup]
@Email NVARCHAR(40),
@FirstName VARCHAR(20),
@LastName VARCHAR(20),
@Address VARCHAR(80),
@SchoolId INT,
@Contact_Number VARCHAR(12),
@Password VARCHAR(20),
@Username VARCHAR(40)
AS
DECLARE @ResultValue int 

If(SELECT 1 FROM Users WHERE Email = REPLACE(@Email,'%40','@')) > 0
BEGIN
	SET  @ResultValue = 0  --user exists
END
ELSE
BEGIN
	INSERT INTO Users(School_ID,First_Name,Last_Name,Adress,Email,Contact_Number,Username)
	VALUES (@SchoolId,@FirstName,@LastName,@Address,REPLACE(@Email,'%40','@'),@Contact_Number,@Username)
	INSERT INTO Roles(Email,[Role],[Password])
	VALUES (REPLACE(@Email,'%40','@'),'Student',@Password)
	INSERT INTO COURSES(SchoolId,Course)
	VALUES (@SchoolId,'')
	SET  @ResultValue = 1  --new user is registered
END
GO
/****** Object:  StoredProcedure [dbo].[spSuspend]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spSuspend]
@SchoolID INT,
@Choice INT
AS
BEGIN
			if(@Choice = 0)
			BEGIN
			if(select 1 from Users where School_ID = @SchoolID AND Activity='Active') > 0
			BEGIN
			update Users set Activity='Blocked' where School_ID = @SchoolID
			SELECT 0
			END
			ELSE IF (select 1 from Users where School_ID = @SchoolID) > 0
			BEGIN
			update Users set Activity='Active' where School_ID = @SchoolID
			SELECT 0
			END
			END
			ELSE IF(@Choice = 1)
			BEGIN
			if(select 1 from Users where School_ID = @SchoolID AND Activity='Active') > 0
			BEGIN
			update Users set Activity='Suspended' where School_ID = @SchoolID
			SELECT 0
			END
			ELSE IF (select 1 from Users where School_ID = @SchoolID) > 0
			BEGIN
			update Users set Activity='Active' where School_ID = @SchoolID
			SELECT 0
			END
			END
			ELSE
			BEGIN
			SELECT 1
			END
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateStudent]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spUpdateStudent]
@reference VARCHAR(100),
@Username VARCHAR(100),
@FirstName VARCHAR(100),
@LastName VARCHAR(100),
@Contact_Number VARCHAR(100),
@Email NVARCHAR(100),
@Address VARCHAR(500)

AS

BEGIN
	UPDATE Users SET First_Name = @FirstName, Last_Name = @LastName, Adress = @Address, Email = REPLACE(@Email,'%40','@'), Contact_Number = @Contact_Number, Username=@Username WHERE School_ID = (SELECT School_ID FROM Users WHERE Email=@reference)
	SELECT 1
END
GO
/****** Object:  StoredProcedure [dbo].[spUploadAssignment]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spUploadAssignment]
@Email NVARCHAR(50),
@Course VARCHAR(20),
@Assignment_Name VARCHAR(50),
@Assignment_Type VARCHAR(50),
@Assignment_Data VARCHAR(MAX)
AS
BEGIN

	UPDATE [dbo].[COURSES] SET [Assignment_Name] = @Assignment_Name, [Assignment_Type] = @Assignment_Type, [Assignment_Data] = @Assignment_Data
	WHERE  (SchoolId = (SELECT School_ID FROM Users WHERE Email=REPLACE(@Email,'%40','@')) AND COURSES.Course =@Course)														
END
GO
/****** Object:  StoredProcedure [dbo].[spuserIdentify]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spuserIdentify] 
@Email NVARCHAR(40)
AS
BEGIN
	SELECT * FROM Users WHERE School_ID =  (SELECT School_ID FROM Users WHERE Email=REPLACE(@Email,'%40','@'))

END
GO
/****** Object:  StoredProcedure [dbo].[spuserSignup]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spuserSignup]
@Email VARCHAR(40),
@FirstName VARCHAR(20),
@LastName VARCHAR(20),
@Address VARCHAR(80),
@SchoolId INT,
@Contact_Number VARCHAR(12),
@Password VARCHAR(20)
AS
DECLARE @ResultValue int 

If(SELECT 1 FROM Users WHERE Email = @Email) > 0
BEGIN
	SET  @ResultValue = 0
END
ELSE
BEGIN
	INSERT INTO Users(School_ID,First_Name,Last_Name,Adress,Email,Contact_Number)
	VALUES (@SchoolId,@FirstName,@LastName,@Address,@Email,@Contact_Number)
	INSERT INTO Roles(Email,[Role],[Password])
	VALUES (@Email,'Student',@Password)
--	INSERT INTO messsages(Username,[Message])
--	VALUES (@EmployeeCode,'')
	SET  @ResultValue = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spViewAllStudents]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spViewAllStudents]
AS
BEGIN

		SELECT * FROM [All students]

END
GO
/****** Object:  StoredProcedure [dbo].[spViewAllTeachers]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spViewAllTeachers]
AS
BEGIN
		SELECT * FROM [All Teachers]
END
GO
/****** Object:  StoredProcedure [dbo].[VerifyUser]    Script Date: 11/19/2020 7:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[VerifyUser]
@ID INT,
@Password VARCHAR(10)
AS
BEGIN
	SELECT [Role] FROM Roles WHERE (ID=@ID AND [Password]=@Password)
END
GO
