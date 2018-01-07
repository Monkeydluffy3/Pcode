/*
    8. Write PL/SQL block using explicit cursor: Cursor FOR Loop for following requirements: 
    College has decided to mark all those students detained (D) who are having attendance less than 75%.
     Whenever such update takes place, a record for the same is maintained in the D_Stud table.
      create table stud21(roll number(4), att number(4), status varchar(1)); 
      create table d_stud(roll number(4), att number(4));
*/

create table stud2(roll int, att int, status varchar(2));
insert into stud2 values(1,85,'ND');
insert into stud2 values(2,65,'ND');
insert into stud2 values(3,55,'ND');
insert into stud2 values(4,80,'ND');
insert into stud2 values(5,50,'ND');
insert into stud2 values(6,56,'ND');


create table d_stud2(roll int, att int);

set serveroutput on
declare 
cursor exp_cur is select * from stud2;
count1 int;
record exp_cur%rowtype;
begin
open exp_cur;
select count(roll) into count1 from stud2;
for i in 1..count1 LOOP            --used for loop
fetch exp_cur into record;
if record.att<75 then
update stud2 set status='D' where record.roll=roll;
insert into d_stud2 values(record.roll,record.att);
end if;
end loop;
close exp_cur;
end;
/