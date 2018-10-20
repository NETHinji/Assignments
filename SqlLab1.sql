use Training_19Sep18_Pune
go
select DB_NAME()
go
sp_help
go
use master
go
select DB_NAME()
go
sp_help
go
use Northwind
go
select DB_NAME()
go
sp_help
go
select @@VERSION
go
select GETDATE()
go
use Northwind
go
sp_help Categories
go
sp_help Products
go
sp_help Orders
go
sp_help Orders_Details
go
sp_help Employees
go
use Training_19Sep18_Pune
go
create table Customer_160919
(CustomerId int  Unique not null,
CustomerName varchar(20) not null,
Address1 varchar(30),
Address2 varchar(30),
ContactNumber varchar(12) not null,
Postalcode varchar(10))
go
create table Employees_160919
(EmployeeId int not null primary key,
	Name nvarchar(255) null)

create table Contractors_160919
(ContractorId int not null primary key,
	Name nvarchar(255) null)

CREATE TABLE dbo.TestRethrow
(
ID INT PRIMARY KEY)

create type  Region_160919 from char(15) 

create default D160919 as 'NA'

use sp_bindefault
exec sp_bindefault D160919, 'Region_160919'

ALter table Customer_160919
add  Customer_Region Region_160919

Alter table Customer_160919
add Gender char(1)

alter table Customer_160919
add constraint chk_gender check(Gender='M' or Gender='F' or Gender='T')

create table Orders_160919 
(OrdersId int not null Identity(1000,1),
CustomerId int not null,
Ordersdate datetime,
Orders_State char(1) check(Orders_State='P' or Orders_State='C'))

alter table Orders_160919
add constraint fk_CustOrders
foreign key(CustomerId) references Customer_160919(CustomerId)

sp_help Orders_160919

create sequence IdSequence_160919 as int
start with 10000
increment by 1

INSERT INTO Employees_160919 (EmployeeId, Name)
VALUES (NEXT VALUE FOR IdSequence_160919, 'Shashank');

INSERT INTO Contractors_160919 (ContractorId, Name)
VALUES (NEXT VALUE FOR IdSequence_160919, 'Aditya');

select * from Employees_160919
select * from Contractors_160919

sp_help Student_Master

select Stud_Code,Stud_Name,Dept_Code from Student_master

 sp_help Staff_Master
 select Staff_Code,Staff_Name,Dept_Code from Staff_Master

 select Staff_Name,Salary,Dept_Code from Staff_Master where Dept_Code=20 or Dept_Code=30 or Dept_Code=40

sp_help Student_Marks

 select Stud_Code,Subject1,Subject2,Subject3,Subject1+Subject2+Subject3 as Total_Marks from Student_Marks order by Total_Marks desc

 select * from Employee

 sp_help Book_Master
select Book_name from Book_Master where Book_name like 'An%'

select Dept_Code from Student_master,Student_Marks where Student_Marks.Stud_Code=Student_master.Stud_Code and Student_Marks.Stud_Year=2018

select * from Student_Master

select Stud_Name,Stud_Dob from Student_master where DATEPART(day,Stud_Dob)!=1 or  DATEPART(day,Stud_Dob)!=6
union
select Stud_Name,(DATENAME(dw, DATEPART(m, Stud_Dob)/DATEPART(d, Stud_Dob)/ DATEPART(yyyy, Stud_Dob))) as DOB from Student_master where DATEPART(day,Stud_Dob)=1 or  DATEPART(day,Stud_Dob)=6

select Staff_Code,Staff_Name,Dept_Code,Hiredate from Staff_Master

select Staff_Name from Staff_Master where HireDate<'2000-01-01'

select Stud_Name,Dept_Code,Stud_Dob from Student_Master where Stud_Dob>'1981-01-01' and Stud_Dob<'1983-03-31'

select stud_Code from Student_Marks where Subject2 is null

CREATE TABLE Employee_Tamal1
(
Employee_Number INT NOT NULL PRIMARY
KEY,
Employee_Name VARCHAR(30) NULL,
Salary FLOAT NULL,
Department_Number INT NULL,
Region VARCHAR(30) NULL
)

insert into Employee_Tamal1 values(1,'Tamal',17000,34,'Kolkata')
insert into Employee_Tamal1 values(2,'Soumik',17000,33,'Pune')
insert into Employee_Tamal1 values(3,'Soumya',17000,30,'Mumbai')
insert into Employee_Tamal1 values(4,'Sumana',17000,31,'Delhi')
insert into Employee_Tamal1 values(5,'Aditi',17000,32,'Chennai')

SELECT Region, Department_Number, AVG (Salary)
Average_Salary
From Employee_Tamal1
Group BY GROUPING SETS
( (Region, Department_Number),
(Region),
(Department_Number)
)

sp_help Department_Master

select Staff_Name,s.Dept_Code,Dept_Name,Salary from Staff_Master as s,Department_master as d where Salary>20000 and s.Dept_code=d.Dept_Code

select Staff_Name,s.Dept_Code,Dept_Name from Staff_Master as s,Department_master as d where  s.Dept_code=d.Dept_Code and s.Dept_code!=10

select * from Book_Transaction

select * from Book_Master

select count(Book_Master.Book_Code),Book_Master.Book_name  as No_of_times_issued from Book_Transaction join Book_Master on Book_Master.Book_code=Book_Transaction.Book_code group by Book_Master.Book_Code,Book_Master.Book_name 

select * from Student_Marks

select  count(Subject1) as No_Of_Time_Issued  from Student_Marks 
union 
select count(Subject2)from Student_Marks
union
select count(Subject3) from Student_Marks 

select * from Staff_Master

select e.Staff_Code,e.Staff_Name,s.Staff_Name,s.Staff_Code from Staff_Master as s inner join Staff_Master as e on s.Staff_Code=e.Mgr_code 

select Staff_Name,Hiredate,DATENAME(weekday,HireDate) as Day  from Staff_Master order by DATENAME(weekday,HireDate)

select b.Staff_Code,Staff_name,Dept_Name from Staff_Master s inner join Department_master d  on s.Dept_Code=d.Dept_code inner join Book_Transaction b on s.Staff_Code=b.Staff_code group by b.Staff_code,Staff_name,Dept_name having count(b.Staff_Code)>1

select * from Student_Marks

select s1.Stud_name,s1.Stud_code from Student_Marks s inner join Student_master s1 on s.Stud_Code=s1.Stud_code where Subject1=(select max(Subject1) from Student_Marks)

select Book_Name,Author,Book_code,book_category from Book_Master where not exists (select Book_Code from  Book_Transaction)

select Staff_Code,Staff_name from Staff_Master where dept_Code=20
union
select Stud_Code,Stud_Name  from Student_master  where dept_Code=20

select s.Stud_Name from Student_master s inner join Student_Marks s1 on s.Stud_Code=s1.Stud_Code where s1.Subject1 is null or s1.Subject2 is null or s1.Subject3 is null

select Stud_code from Student_master
except
select Stud_code from Student_master where  Stud_Code in (select Stud_Code from Book_Transaction)

select * from Customer_160919

delete from Customer_160919
insert into Customer_160919 values(1,'Alfreds Futterkiste','Obere Str 57','Berlin Germany','4321,12209','12209',null,null)
insert into Customer_160919 values(2,'Ana Trujilio','Avda.Dela','Mexico DF Mexico','555-4729','5021',null,null)
insert into Customer_160919 values(3,'Antonio Moreno','matadero2312','Mexico DF Mexico','555-3932','5023',null,null)
insert into Customer_160919 values(4,'Around the','120Hanover','London UK','555-7788','WA1UDP',null,null)
insert into Customer_160919 values(5,'Bergu','Bergusuvagent8','Lulea Sweaden','0921-1234','S-95822',null,null)
insert into Customer_160919 values(6,'Blauer See','Forstrer. 57','Manherim Germany','0621-08460','68306','NA',null)
insert into Customer_160919 values(7,'Bolido','C/Araquil 67','Madrid Spain','555-2282','28023','EU',null)
insert into Customer_160919 values(8,'Bon App','12 Rio de bouchers','Marchilies France','91.24.4.50','13008',null,null)
insert into Customer_160919 values(9,'Bottom Dollar','23 Swasee','Tsawaasen Canada','555-4729','T2F 8M4','BC',null)
update Customer_160919 set ContactNumber='333 2345' where CustomerId=2
update Customer_160919 set Address1='19/2 12th Block, Spring Fields',Address2='Ireland - UK',Customer_region='EU' where CustomerId=9
sp_help Orders_160919
insert into Orders_160919 values(4,'4- jul-96','P')
insert into Orders_160919 values(1,'5-jul-96','P')
insert into Orders_160919 values(7,'8-jul-96','P')
insert into Orders_160919 values(3,'8-jul-96','P')
insert into Orders_160919 values(3,'9-jul-96','P')
insert into Orders_160919 values(9,'10-jul-96','C')
insert into Orders_160919 values(8,'11-jul-96','P')
insert into Orders_160919 values(2,'12-jul-96','P')
insert into Orders_160919 values(6,'15-jul-96','C')
insert into Orders_160919 values(10,'16-jul-96','P')
select * from Orders_160919
delete from Orders_160919 where  Orders_State='P'
delete from Orders_160919
update Orders_160919 set Orders_State='C' where Ordersdate <'15-jul-96'
sp_help Customer_160919 

create unique index un_index on Department_Master(Dept_name)

sp_help Department_master

insert into Department_master values(100,'Home Science')
insert into Department_master values(200,'Home Science')
insert into Department_master values(300,null)
insert into Department_master values(400,null)

create nonclustered index non_index on Book_Transaction(Book_code,Staff_code,Stud_code,Issue_date)

select * from sys.indexes

create view Staff_Details as select s.Staff_code,s.Staff_Name,d1.Design_Code,d.Dept_name from Staff_Master s inner join Department_master d on s.Dept_Code=d.Dept_code inner join Desig_master d1 on s.Des_Code=d1.Design_Code

select * from Staff_Details

insert into Staff_Details values(10002,'Tamal',110,'Computer Science')

create nonclustered columnstore index C1 on Employee_160919(EmployeeId)