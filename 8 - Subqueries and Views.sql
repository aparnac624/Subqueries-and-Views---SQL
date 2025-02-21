use country_person_details;
select * from Country;
select * from Persons;

-- Subqueries-------------------------------------
-- Questions--------------------------------------
-- 1. Find the number of persons in each country. 
select Country_name, count(Country_name) as 'No: of Persons' from Persons GROUP BY Country_name;


-- 2. Find the number of persons in each country sorted from high to low. 
-- number of persons sorted in descending order
select Country_name, count(Country_name) as 'No: of Persons' from Persons GROUP BY Country_name ORDER BY count(Country_name) DESC;
-- country name sorted in descending order
select Country_name, count(Country_name) as 'No: of Persons' from Persons GROUP BY Country_name ORDER BY Country_name DESC;


-- 3. Find out an average rating for Persons in respective countries if the average is greater than 3.0 
-- inserted a new country Pakistan with rating < 3.0
INSERT INTO Country (Id, Country_name, Population, Area)
VALUES (11, 'Pakistan', 67886011, 881913);
insert into Persons (Id, Fname, Lname, Population, Rating, Country_Id, Country_name, DOB)
values
(11, 'Jack','Daniel', 67886011,2.0, 11, 'Pakistan', '1999-01-25');

select Country_name, round(avg(Rating),2) as 'Average Rating' from Persons GROUP BY Country_name HAVING round(avg(Rating),2) > 3.0;


-- 4. Find the countries with the same rating as the USA. (Use Subqueries) 
-- inserted an entry with country USA
insert into Country (Id, Country_name, Population, Area)
values (12, 'USA', 1267886011, 9914256);
insert into Persons (Id, Fname, Lname, Population, Rating, Country_Id, Country_name, DOB)
values
(12, 'Emma','Jackson', 1267886011, 4.7, 12, 'USA', '1997-03-22');

-- query to find countries with same rating as USA 
-- displays all countries other than USA with same rating as that of USA
select Country_name, Rating from Persons where Rating = (select Rating from Persons where Country_name ='USA') and Country_name!= 'USA'; 


-- 5. Select all countries whose population is greater than the average population of all nations. 
-- query to find out the average population
select avg(Population) from Country;

-- average population is '398944419.3333'
-- query to find out all countries whose population > average population
select Country_name, Population from Country where Population > ( select avg(Population) from Country );


-- Views-----------------------------------------------------------------------
-- Questions ------------------------------------------------------------------
-- Create a database named Product and create a table called Customer with the following fields in the Product database: Customer_Id - Make PRIMARY KEY First_name Last_name Email Phone_no Address City State Zip_code Country 
-- create database Product
create database Product;

-- use the Product database
use Product;

-- create the Customer table
create table Customer (
Customer_Id int PRIMARY KEY, 
First_name varchar(50),
Last_name varchar(50), 
Email varchar(100),
Phone_no varchar(50),
Address varchar(250),
City varchar(50),
State varchar(50),
Zip_code varchar(50),
Country varchar(50)
);

select * from Customer;

-- inserting values to Customer table
insert into Customer (Customer_Id, First_name, Last_name, Email, Phone_no, Address, City, State, Zip_code, Country)
values
(1, 'Swathi', 'Padmanabhan', 'swathi@gmail.com', '6278645376', 'A-137, Elamkom Gardens, Sasthamangalam P.O, Trivandrum, Kerala', 'Trivandrum', 'Kerala', '695010', 'India'),
(2, 'Arjun', 'Nair', 'arjun.nair@example.com', '900-123-4567', '123 Coconut Rd', 'Kochi', 'Kerala', '682001', 'India'),
(3, 'Anjali', 'Ravi', 'anjali.ravi@example.com', '901-234-5678', '456 Banana St', 'Thiruvananthapuram', 'Kerala', '695001', 'India'),
(4, 'Vishnu', 'Krishnan', 'vishnu.krishnan@example.com', '902-345-6789', '789 Mango Rd', 'Kottayam', 'Kerala', '686001', 'India'),
(5, 'Priya', 'Menon', 'priya.menon@example.com', '903-456-7890', '101 Palm St', 'Thrissur', 'Kerala', '680001', 'India'),
(6, 'Suresh', 'Kumar', 'suresh.kumar@example.com', '904-567-8901', '202 Spices St', 'Alappuzha', 'Kerala', '688001', 'India');


-- 6. Create a view named customer_info for the Customer table that displays Customer’s Full name and email address. Then perform the SELECT operation for the customer_info view. 
create view Customer_info as
select concat(First_name," ", Last_name) as 'Full Name' from Customer;

select * from Customer_info;

-- 7. Create a view named US_Customers that displays customers located in the US. 
-- inserting entries with USA
insert into Customer (Customer_Id, First_name, Last_name, Email, Phone_no, Address, City, State, Zip_code, Country)
values
(7, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Elm St', 'Los Angeles', 'California', '90001', 'USA'),
(8, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St', 'San Francisco', 'California', '94102', 'USA'),
(9, 'Carlos', 'Gomez', 'carlos.gomez@example.com', '345-678-9012', '789 Pine St', 'Miami', 'Florida', '33101', 'USA'),
(10, 'Maria', 'Johnson', 'maria.johnson@example.com', '456-789-0123', '101 Maple St', 'New York', 'New York', '10001', 'USA');

create view US_Customers as
select concat(First_name," ", Last_name) as 'Full Name', Country from Customer where Country = 'USA';

select * from US_Customers;

-- 8. Create another view named Customer_details with columns full name(Combine first_name and last_name), email, phone_no, and state.
create view Customer_details as
select concat(First_name," ", Last_name) as 'Full Name', Email, Phone_no, State from Customer;

select * from Customer_details;
 
-- 9. Update phone numbers of customers who live in California for Customer_details view. 
SET SQL_SAFE_UPDATES = 0;

update Customer_details
set Phone_no ='222-222-2222'
where State = 'California';
select * from Customer_details;
select * from Customer;


-- 10. Count the number of customers in each state and show only states with more than 5 customers.
-- displays number of customers in each state
select State, count(*) as 'Count of Customers' from Customer GROUP BY State;
-- displays count of customers of states with more than 5 
select State, count(*) as 'Count of Customers' from  Customer GROUP BY State having count(*) > 5;


-- 11. Write a query that will return the number of customers in each state, based on the "state" column in the "customer_details" view. 
select State, count(*) as 'Count of Customers' from Customer_details GROUP BY State;

-- 12. Write a query that returns all the columns from the "customer_details" view, sorted by the "state" column in ascending order.
select * from Customer_details order by State asc;