/*
Parameterized Cursor 
    6. Write a PL/SQL block of code using parameterized Cursor, that will merge
     the data available in the newly created table N_RollCall with the data available
      in the table O_RollCall. If the data in the first table already exist in the 
      second table then that data should be skipped.

theory

PL/SQL Parameterized cursor pass the parameters into a cursor and use them in to query.PL/SQL
 Parameterized cursor define only datatype of parameter and not need to define it's length.

Parameterized cursors are also saying static cursors that can passed parameter value when cursor are opened.
*/

CREATE TABLE n_stud(rollno int,name varchar(10));

CREATE TABLE o_stud(rollno int,name varchar(10));

insert into o_stud values(1,'rahul');
insert into o_stud values(2,'had');
insert into o_stud values(3,'rah');
insert into o_stud values(4,'ulu');
insert into o_stud values(5,'rul');
insert into o_stud values(6,'raul');

set serveroutput on;
DECLARE
 s_roll int;
 s_name varchar(10);
 found int:=0;
 CURSOR c(r int) IS select rollno,name from o_stud where rollno=r;
 CURSOR c1 IS select rollno,name from o_stud;
 stud_rec c%rowtype;
BEGIN
 open c1;
  loop
   FETCH c1 into s_roll,s_name;
   EXIT when c1%notfound;
   open c(s_roll);
   FETCH c into stud_rec; 
     select count(*) into found from n_stud where rollno=s_roll;
     IF found=0 then
       insert into n_stud values(stud_rec.rollno,stud_rec.name);
     ELSE
        dbms_output.put_line('record already exists');
  END IF;
  CLOSE c;
 END loop;
 CLOSE c1;
END;
/

