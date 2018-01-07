/*
    9. Consider table Stud(Roll, Att,Status) Write a PL/SQL block for following requirement and
     handle the exceptions. Roll no. of student will be entered by user. Attendance of roll no. 
     entered by user will be checked in Stud table. If attendance is less than 75% then display 
     the message “Term not granted” and set the status in stud table as “D”. Otherwise display 
     message “Term granted” and set the status in stud table as “ND”.
*/

create table student(rollno int,att int,status varchar(2));
insert into student values(1,67,'ND');
insert into student values(2,76,'ND');
insert into student values(3,60,'ND');
insert into student values(4,50,'ND');
insert into student values(5,89,'ND');


set serveroutput on;
DECLARE
 s_roll student.rollno%type:=&s_roll;
 s_att student.att%type;
 invalid_roll EXCEPTION;
BEGIN
 if s_roll<=0 then
  RAISE invalid_roll;
 else
   select att into s_att from student where rollno=s_roll;
   if s_att<75 then
     dbms_output.put_line('Term not granted '||s_roll);
     update student set status = 'D' where rollno=s_roll;
   else
     dbms_output.put_line('Term ganted to '||s_roll);
   END if;
   END if;
   
EXCEPTION
  when invalid_roll then
    dbms_output.put_line('rollno must be greater than zero');
  when no_data_found then
    dbms_output.put_line('no data found');
  when others then 
    dbms_output.put_line('Error!');
END;
/