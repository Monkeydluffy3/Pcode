/*

    19. Cursors: (All types: Implicit, Explicit, Cursor FOR Loop, Parameterized Cursor) 
Write a PL/SQL block of code using parameterized Cursor, that will merge the data available 
in the newly created table N_RollCall with the data available in the table O_RollCall. 
If the data in the first table already exist in the second table then that data should be skipped.
*/
CREATE TABLE n_table(rollno int,name varchar(10));

CREATE TABLE o_table(rollno int,name varchar(10));

insert into n_table values(1,'rahul');
insert into n_table values(2,'rahul1');
insert into n_table values(3,'rahul2');
insert into n_table values(4,'rahul3');
insert into n_table values(5,'rahul4');
insert into n_table values(6,'rahul5');


set serveroutput on
declare 
roll n_table.rollno%type;
roll1 o_table.rollno%type;
name n_table.name%type;
name1 o_table.name%type;
cursor n_cur is select * from n_table;
cursor o_cur(roll_no o_table.rollno%type) is select * from o_table where roll_no=rollno;
begin
open n_cur;
loop 
fetch n_cur into roll,name;
exit when n_cur%notfound;
open o_cur(roll);
fetch o_cur into roll1,name1;
if o_cur%notfound then
insert into o_table values(roll,name);
end if;
close o_cur;
end loop;
close n_cur;
end;
/
