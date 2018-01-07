/*

    20. PL/SQL Stored Procedure 
Write a Stored Procedure namely proc_Grade for the categorization of student. 
If marks scored by students in examination is <=1500 and marks>=990 then student 
will be placed in distinction category if marks scored are between 989 and900 category 
is first class, if marks 899 and 825 category is Higher Second Class Write a PL/SQL block 
for using procedure created with above requirement. Stud_Marks(name, total_marks) Result(Roll,Name, Class). 
*/
create table stud_marks(rollno int, name varchar(10), marks int);
insert into stud_marks values(1,'Varun',1000);
insert into stud_marks values(2,'Nayal',950);
insert into stud_marks values(3,'Ajil',850);
insert into stud_marks values(4,'Atul',650);

create table result(roll int, name varchar(10), class varchar(30));


CREATE OR REPLACE PROCEDURE proc_grade AS
 cursor c is select * from stud_marks;
 class varchar(20);
 record c%rowtype;
BEGIN
 open c;
 loop
   FETCH c into record;
   EXIT when c%notfound;
   if record.marks>=990 and record.marks<=1500 then
    class:='Distinction';
   elsif record.marks>=900 and record.marks<=989 then
    class:='First Class';
   elsif record.marks>=825 and record.marks<=899 then
    class:='Second Class';
   else
    class:='Third Class';
   END if;  
   insert into result values(record.rollno,record.name,class);
   END loop;
END;
/


set serveroutput on;
DECLARE
BEGIN
proc_grade();
END;
/