--creating a new database
create database CUSTOMERSERVICE

--creating a table about customer details
create table CustomerDetails(
CustomerID char(4),
CustomerName varchar(100),
City varchar(100),
MobileNo char(100),
[Address] varchar(1000))

--creating a table about product details
create table ProductDetails(
ProductID int IDENTITY(1001,1),
ProductName varchar(100),
ProductImage varbinary(max),
Price money,
Quantity smallint,
ProductAddDate Date,
ProductModifiedDate Date,
AvailableStatus bit)

--adding email id column
alter table Customerdetails add EmailID varchar(200) not null

--adding Pin Code column
alter table Customerdetails add PinCode char(6) 
--adding the constraint to check pin
alter table Customerdetails add constraint checkpin
Check(PinCode LIKE('[0-9][0-9][0-9][0-9][0-9][0-9]'))

--altering customerID column to not null
alter table CustomerDetails alter column CustomerID char(4) not null

--adding the primary key for customerID in CustomerDetails
alter table CustomerDetails
add Constraint pkCustomerID Primary Key(CustomerID)

--adding the primary key for ProductID in ProductDetails
alter table ProductDetails add Constraint pkProductID Primary Key(ProductID)

--altering table to make CustomerID in ProductDetails table not null
alter table ProductDetails add CustomerID char(4) not null

--Defining a foreign key on CustomerID in Product Details and referencing it to CustomerDetails
alter table ProductDetails add Constraint fkCustomerID Foreign Key(CustomerID) references CustomerDetails(CustomerID)

--adding a constraint to check the mobile number
alter table CustomerDetails add constraint chkCustomerMobNo
Check(MobileNo LIKE('[6-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))

--defining a default constraint for the productadddate date column
alter table ProductDetails add constraint dfProductDate Default Getdate() for ProductAddDate

--adding a column for registration date in customerDetails table and giving it a default constraint
alter table CustomerDetails add registrationdate date
alter table CustomerDetails add constraint dfregistrationdate Default Getdate() for registrationdate

select GETDATE()


--creating a table for OrderDetails with the constraints

create table OrderDetails(
OrderID int identity(10001,1) constraint pkOrderID Primary Key,
CustomerID char(4) constraint fkCustomerID1 Foreign key(CustomerID) references CustomerDetails(CustomerID),
ProductID int constraint fkProductID1 foreign key(ProductID) references ProductDetails(ProductID),
OrderDate Datetime constraint dfOrderDate Default Getdate(),
TotalQty int not null Constraint chkqty check(TotalQty Between 1 and 10),
ExpectedDeliveryDate Datetime,
TotalPrice money not null)


--Alter table CustomerDetails add CustomerJoinDate date constraint 

--Inserting in CustomerDetails
Insert into CustomerDetails(CustomerID,CustomerName,City,MobileNo,[Address],EmailID)
values ('C001','Aditya','Bangalore','7360563506','B-11','adi@gmail.com')

--Inserting in ProductDetails
Insert into ProductDetails(ProductName,Price,Quantity,AvailableStatus,CustomerID) values ('LG',10000.00,6,1,'C001')

select * from ProductDetails

--Inserting in OrderDetails
Insert into OrderDetails(CustomerID, ProductID,TotalQty,TotalPrice) values ('C001',1002,3,10000.00)

select * from CustomerDetails, ProductDetails, OrderDetails

--Updating Customer Details
update CustomerDetails set MobileNo='7000000000' where City = 'Bangalore'

-- deleting an entry from OrderDetails where the name of the customer is given.
delete from OrderDetails where CustomerID = (select CustomerID from CustomerDetails where CustomerName = 'Aditya')
