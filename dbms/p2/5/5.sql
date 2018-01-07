/*
    5. Write PL/SQL block using explicit cursor for following requirements: 
    College has decided to mark all those students detained (D) who are having 
    attendance less than 75%. Whenever such update takes place, a record for the 
    same is maintained in the D_Stud table. create table stud21(roll number(4), 
    att number(4), status varchar(1)); create table d_stud(roll number(4), att number(4)).
*/

create table stud1(roll int, att int, status varchar(2));
insert into stud1 values(1,85,'ND');
insert into stud1 values(2,65,'ND');
insert into stud1 values(3,55,'ND');
insert into stud1 values(4,80,'ND');
insert into stud1 values(5,50,'ND');

create table d_stud1(roll int, att int);

set serveroutput on;
DECLARE
 s_roll stud1.roll%type;
 s_att stud1.att%type;
 CURSOR c IS select roll,att from stud1;
BEGIN
 open c;
 loop 
  FETCH c into s_roll,s_att;
  EXIT when c%notfound;
  if s_att<75 then
   update stud1 set status='D' where roll=s_roll;
   insert into d_stud1 values(s_roll,s_att);
  END if;
  END loop;
  CLOSE c;
END;
/