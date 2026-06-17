
 create database Course_Details;
 use Course_Details;
 
 -- To Create Learners Table 
 create table learner (
 Learner_Id int Primary Key,
 Full_Name varchar(50) Not Null Unique,
 Country varchar(25) );
 
 -- To Retrieve the learners Table
 select * from learner;


 -- To Create Course Table 
 Create table course (
 Course_Id int Primary Key,
 Course_Name varchar(30) Not Null Unique,
 Category varchar(30),
 Unit_Price Decimal(10,2)
 );
 
 -- To Retrieve the Course Table
 select * from Course;
 
 
  -- To Create Purchase Table 
  Create table Purchase ( 
  Purchase_Id int auto_increment Primary Key,g
  Quantity int,
  Purchase_Date Date ,
  Foreign Key(Learner_ID) References learner(Learner_Id),
  Foreign Key(Course_ID) References course(Course_Id)
  );
  
   -- To Retrieve the Purchase Table
   select * from Purchase;
   
   -- To Insert values in Learner Table
   insert  into learner (Learner_Id, Full_Name, Country) values 
   (101, 'Arun Kumar', 'India'),
   (102, 'Priya Sharma', 'India'),
   (104, 'Emma Wilsom', 'UK'),
   (105, 'Rahul Verma', 'India'),
   (106, 'Sophia Brown', 'Canada');
   
select * from learner;


-- To Insert values in Course Table
insert into course (Course_Id, Course_Name, Category, Unit_Price) values
(201, 'SQL Fundamentals', 'Intermediate', 2500),
(202, 'Python Programming', 'Advanced', 3500),
(203, 'Power BI', 'Intermediate', 3000),
(204, 'Excel Advanced', 'Beginner', 2000),
(205, 'Machine Learning Basics', 'Advanced', 5000),
(206, 'Tableau Essentials', 'Beginner', 3200);

select * from course;
  
  
-- To Insert values in Purchase Table  
insert into Purchase (Learner_Id, Course_Id, Quantity, Purchase_Date) values
(101, 201, 1, '2025-01-10'),
(102, 202, 1, '2025-01-15'),
(103, 203, 2, '2025-02-05'),
(104, 204, 1, '2025-02-20'),
(105, 205, 1, '2025-03-01'),
(106, 206, 1, '2025-03-12'),
(101, 202, 1, '2025-03-18'),
(102, 203, 1, '2025-04-02'),
(105, 201, 2, '2025-04-10'),
(103, 205, 1, '2025-04-25');

select * from Purchase;


-- 2) Data Exploration using Joins
-- Combine learner, course, and purchase data & Sort by the highest total amount 

select 
 l.Full_Name as Learner_Name,
 c.Course_Name,
 c.Category,
 p.Quantity,
 c.Unit_Price,
 p.Quantity * c.Unit_Price as Total_Amount,
 p.Purchase_Date
 from Purchase as p
 inner join learner as l
 on l.Learner_Id = p.Learner_Id
 inner join course as c
 on c.Course_Id = p.Course_Id
 order by Total_Amount Desc;
 

 
 -- 3. Core Analytical Queries
 -- Q1) Display each learner’s total spending with their country. 
 select
 l.Learner_Id,
 l.Full_Name as Learner_Name,
 l.Country,
 sum(p.Quantity * c.Unit_Price) as Total_Spending
 from Purchase as p
 join learner as l
 on l.Learner_Id = p.Learner_Id
 join course as c
 on c.Course_Id = p.Course_Id
 group by l.Learner_Id, Learner_Name, l.Country;
 
 
 -- Q2) Find the top 3 most purchased courses by quantity. 
 select c.Course_Id, c.Course_Name,
 sum(p.Quantity) as Total_Quantity
 from Purchase as p
 join course as c
 on p.Course_Id = c.Course_Id
 group by c.Course_Id, c.course_Name
 order by Total_Quantity Desc
 Limit 3;
 
 -- Q3)  Show each category’s:  Total revenue & Number of unique learners 
 select c.Category, 
 count(Distinct p.Learner_Id) as No_of_Unique_Learners,
 sum(c.Unit_Price*p.Quantity) as Total_Revenue
 from Purchase as p
 join course as c
 on c.Course_Id = p.Course_Id
 group by c.Category;
 
 select c.Category, 
 count(*) as No_of_Unique_Learners,
 sum(c.Unit_Price*p.Quantity) as Total_Revenue
 from Purchase as p
 join course as c
 on c.Course_Id = p.Course_Id
 group by c.Category;

-- Q4) List learners who purchased from more than one category. 
select 
l.Full_Name,
p.Learner_Id
from Purchase as p
join course as c
on p.Course_Id = c.Course_Id
join learner as l
on p.Learner_Id = l.Learner_Id
group by p.Learner_Id,l.Full_Name
having count( Distinct c.Category)>1;

-- Q5) Identify courses never purchased. 
select c.Course_Id, c.Course_Name
from course as c
left join Purchase as p
on c.Course_Id = p.Course_Id
where p.Course_Id is null;


-- 4. Subqueries & Correlated Subqueries 
-- Q6) Find learners whose total spending is above the average learner spending.
with Learners_Spending as (
select p.Learner_Id, 
l.Full_Name,
sum(p.Quantity * c.Unit_Price) as Total_Spending
from Purchase as p
join learner as l
on p.Learner_Id = l.Learner_Id
join course as c
on c.Course_Id = p.Course_Id 
group by l.Full_Name, p.Learner_Id 
)
select * from Learners_Spending
where Total_Spending >
( select Avg(Total_Spending) from Learners_Spending
); 


-- Q7)  Display courses whose price is higher than any course in the ‘Beginner’ category. 
Select * from course
where Unit_Price > any
 (
 select  Unit_Price from course where Category ='Beginner');
 

-- Q8) Find learners who spent more than the average spending in their country.
with Tot_Spend as (
select  
l.Full_Name,
l.Country,
sum(p.Quantity * c.Unit_Price) as Tot_Spending
from Purchase as p
join learner as l
on p.Learner_Id = l.Learner_Id
join course as c
on c.Course_Id = p.Course_Id 
group by l.Country, l.Full_Name
)
select * from Tot_Spend as t1
where t1.Tot_Spending >
(select Avg(t2.Tot_Spending) from Tot_Spend as t2 where t2.Country = t1.Country );


-- 5. CTE, CASE, View, and NULL Handling 
-- Q9) Use a CTE to calculate total spending per learner, then:  Display learners with spending above 10,000. 
with Learners_Tot_Spending as (
select 
l.Learner_Id,
l.Full_Name,
sum(p.Quantity * c.Unit_Price) as Tot_Spending
from Purchase as p
join learner as l
on p.Learner_Id = l.Learner_Id
join course as c
on c.Course_Id = p.Course_Id 
group by l.Full_Name, p.Learner_Id 
)
select * from Learners_Tot_Spending 
where Tot_Spending > 10000;


-- Q10) CASE Expression: Classify learners based on spending:  Above 10,000 → “High Value”, 8,000–10,000 → “Medium Value”, 
-- Below 8,000 → “Low Value”. 
with Course_Spending as (
select 
l.Learner_Id,
l.Full_Name,
sum(p.Quantity * c.Unit_Price) as Tot_Spending
from Purchase as p
join learner as l
on p.Learner_Id = l.Learner_Id
join course as c
on c.Course_Id = p.Course_Id 
group by l.Full_Name, p.Learner_Id
)
select *,
case 
when Tot_Spending > 10000 then 'High Value'
when Tot_Spending BETWEEN 8000 AND 10000 THEN 'Medium Value'
else 'Low Value'
end as Spending_Category 
from Course_Spending;

-- Q11) NULL Handling:
-- To Insert new Records in Course Table
insert  into course (Course_Id, Course_Name, Category, Unit_Price) values
(207, 'Java Script', 'Intermediate', 3000);
select * from course;

-- Display all courses and replace NULL purchase counts with 0 using: IFNULL() or COALESCE() 
select c.Course_Name,
IFNULL(count(p.Purchase_Id),0) as Purchase_Count
from course as c
Left join Purchase as p
on c.Course_Id = p.Course_Id
group by c.Course_Name;

-- Another Example
insert  into course (Course_Id, Course_Name, Category, Unit_Price) values
(208, 'Data Scientist', 'Advanced', NUll);
select * from course;
 
select Course_Id, Course_Name, Unit_Price,
COALESCE(Unit_Price, 6000) as Clean_Name
from course;


-- Q12) View: Create a view: category_performance_view 
-- Showing: Category & Total revenue & Number of purchases & Average revenue per purchase 
create view category_performance_view2 as (
select
c.Category,
sum(c.Unit_Price * p.Quantity) as Total_Revenue,
count(p.Quantity) as Number_of_Purchase,
round(sum(c.Unit_Price * p.Quantity) / count(p.Quantity), 2) as Average_revenue_per_purchase 
from Purchase as p
join Course as c
on p.Course_ID = c.Course_ID
group by c.Category
);

select * from category_performance_view2;



 


  