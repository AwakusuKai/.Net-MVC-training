USE [master]
GO
/****** Object:  Database [projectsdb]    Script Date: 24.06.2021 14:44:42 ******/
CREATE DATABASE [projectdb]
GO

USE [projectdb]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 24.06.2021 14:44:42 ******/
CREATE TABLE [dbo].[employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[Position] [nvarchar](50) NULL,
 CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[projects]    Script Date: 24.06.2021 14:44:42 ******/
CREATE TABLE [dbo].[projects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ShortName] [nchar](10) NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_projects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[statuses]    Script Date: 24.06.2021 14:44:42 ******/
CREATE TABLE [dbo].[statuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_statuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * from statuses WHERE Name = 'Не начата')
begin
	INSERT INTO statuses(Name) values('Не начата')
end

IF NOT EXISTS (SELECT * from statuses WHERE Name = 'В процессе')
begin
	INSERT INTO statuses(Name) values('В процессе')
end


IF NOT EXISTS (SELECT * from statuses WHERE Name = 'Завершена')
begin
	INSERT INTO statuses(Name) values('Завершена')
end

IF NOT EXISTS (SELECT * from statuses WHERE Name = 'Отложена')
begin
	INSERT INTO statuses(Name) values('Отложена')
end

/****** Object:  Table [dbo].[tasks]    Script Date: 24.06.2021 14:44:42 ******/
CREATE TABLE [dbo].[tasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[WorkTime] [int] NULL,
	[StartDate] [date] NULL,
	[CompletionDate] [date] NULL,
	[StatusId] [int] NULL,
	[ProjectId] [int] NULL,
	[EmployeeId] [int] NULL,
 CONSTRAINT [PK_tasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tasks]  WITH CHECK ADD  CONSTRAINT [FK_tasks_employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[employees] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tasks] CHECK CONSTRAINT [FK_tasks_employees]
GO
ALTER TABLE [dbo].[tasks]  WITH CHECK ADD  CONSTRAINT [FK_tasks_projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[projects] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tasks] CHECK CONSTRAINT [FK_tasks_projects]
GO
ALTER TABLE [dbo].[tasks]  WITH CHECK ADD  CONSTRAINT [FK_tasks_statuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[statuses] ([Id])
GO
ALTER TABLE [dbo].[tasks] CHECK CONSTRAINT [FK_tasks_statuses]
GO
/****** Object:  StoredProcedure [dbo].[spCreateEmployee]    Script Date: 24.06.2021 14:44:42 ******/
create procedure [dbo].[spCreateEmployee]   
(    
@Name nvarchar(50),    
@Surname nvarchar(50),    
@MiddleName nvarchar(50),
@Position nvarchar(50)
)    
as    
begin    
    insert into employees(Name,Surname,MiddleName,Position)    
    values(@Name,@Surname,@MiddleName,@Position)    
end       
GO
/****** Object:  StoredProcedure [dbo].[spCreateProject]    Script Date: 24.06.2021 14:44:42 ******/
   
create procedure [dbo].[spCreateProject]    
(    
@Name nvarchar(50),    
@ShortName nvarchar(50),    
@Description ntext   
)    
as    
begin    
    insert into projects(Name,ShortName,Description)    
    values(@Name,@ShortName,@Description)    
end       
GO
/****** Object:  StoredProcedure [dbo].[spCreateTask]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spCreateTask]   
(    
@Name nvarchar(50),    
@WorkTime int,    
@StartDate date,
@CompletionDate date,
@StatusId int,
@ProjectId int,
@EmployeeId int
)    
as    
begin    
    insert into tasks(Name,WorkTime,StartDate,CompletionDate, StatusId, ProjectId, EmployeeId)    
    values(@Name,@WorkTime,@StartDate,@CompletionDate, @StatusId, @ProjectId, @EmployeeId)    
end     
GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployeeById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spDeleteEmployeeById]   
(    
@Id int        
)    
as    
begin    
    delete from employees where Id = @Id  
end    
GO
/****** Object:  StoredProcedure [dbo].[spDeleteProjectById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spDeleteProjectById]   
(    
@Id int        
)    
as    
begin    
    delete from projects where Id = @Id  
end    
GO
/****** Object:  StoredProcedure [dbo].[spDeleteTaskById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spDeleteTaskById]   
(    
@Id int        
)    
as    
begin    
    delete from tasks where Id = @Id  
end     
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spGetEmployeeById]   
(    
@Id int        
)    
as    
begin    
    select * from employees where Id = @Id  
end     
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployees]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spGetEmployees]  
as    
begin     
select * from employees    
end      
GO
/****** Object:  StoredProcedure [dbo].[spGetProjectById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spGetProjectById]    
(    
@Id int        
)    
as    
begin    
    select * from projects where Id = @Id  
end    
GO
/****** Object:  StoredProcedure [dbo].[spGetProjects]    Script Date: 24.06.2021 14:44:42 ******/   
create procedure [dbo].[spGetProjects]    
as    
begin     
select * from projects  
end     
GO
/****** Object:  StoredProcedure [dbo].[spGetStatusById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spGetStatusById]   
(    
@Id int        
)    
as    
begin    
    select * from statuses where Id = @Id  
end   
GO
/****** Object:  StoredProcedure [dbo].[spGetStatuses]    Script Date: 24.06.2021 14:44:42 ******/

CREATE procedure [dbo].[spGetStatuses]      
as    
begin    
    select * from statuses
end   
GO
/****** Object:  StoredProcedure [dbo].[spGetTaskById]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spGetTaskById]   
(    
@Id int        
)    
as    
begin    
    select * from tasks where Id = @Id  
end    
GO
/****** Object:  StoredProcedure [dbo].[spGetTasks]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spGetTasks]   
as    
begin  
select  tasks.Id as taskID, tasks.Name as taskName, tasks.*, 
		employees.Id as EmployeeId, employees.Name as EmployeeName, employees.*,
		projects.Id as ProjectId, projects.Name as ProjectName, projects.*,
		statuses.Id as StatusId, statuses.Name as StatusName, statuses.*
from tasks
INNER JOIN employees ON [tasks].EmployeeId = employees.Id
INNER JOIN projects ON [tasks].ProjectId = projects.Id
INNER JOIN statuses ON [tasks].StatusId = statuses.Id
end  
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployee]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spUpdateEmployee] 
(    
@Id int,    
@Name nvarchar(50),    
@Surname nvarchar(50),    
@MiddleName nvarchar(50), 
@Position nvarchar(50)
)    
as    
begin    
    update employees     
    set Name=@Name,Surname=@Surname,MiddleName=@MiddleName,Position=@Position    
    where Id=@Id    
end         
GO
/****** Object:  StoredProcedure [dbo].[spUpdateProject]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spUpdateProject]    
(    
@Id int,    
@Name nvarchar(50),    
@ShortName nvarchar(50),    
@Description ntext    
)    
as    
begin    
    update projects     
    set Name=@Name,ShortName=@ShortName,Description=@Description    
    where Id=@Id    
end    
GO
/****** Object:  StoredProcedure [dbo].[spUpdateTask]    Script Date: 24.06.2021 14:44:42 ******/

create procedure [dbo].[spUpdateTask]   
(    
@Id int,       
@Name nvarchar(50),    
@WorkTime int,    
@StartDate date,
@CompletionDate date,
@StatusId int,
@ProjectId int,
@EmployeeId int
)      
as    
begin    
    update tasks     
    set Name=@Name,WorkTime=@WorkTime,StartDate=@StartDate,CompletionDate=@CompletionDate,StatusId = @StatusId, ProjectId=@ProjectId,EmployeeId=EmployeeId    
    where Id=@Id    
end  

