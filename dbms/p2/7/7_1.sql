/*
Parameterized Cursor 
7. Write the PL/SQL block for following requirements using parameterized Cursor: Consider table EMP(e_no, d_no, Salary), department wise average salary should be inserted into new table dept_salary(d_no, Avg_salary)

*/

create table emp1(e_no int,d_no int,salary float);

insert into emp1 values(1,100,12000);
insert into emp1 values(2,101,19000);
insert into emp1 values(3,100,3000);
insert into emp1 values(4,101,22000);
insert into emp1 values(5,100,30000);
insert into emp1 values(6,100,40000);
insert into emp1 values(7,101,30000);

create table dept_salary(d_no int,Avg_salary float);

set serveroutput on;
declare
cursor o_cur is select * from emp1;
cursor n_cur(dno dept_salary.d_no%type) is select * from dept_salary where dno=d_no;
record o_cur%rowtype;
record1 n_cur%rowtype;
average float;
begin
open o_cur;
loop 
fetch o_cur into record;
exit when o_cur%notfound;
open n_cur(record.d_no);
fetch n_cur into record1;
if n_cur%notfound then
select avg(salary) into average from emp1 group by d_no having d_no=record.d_no;
insert into dept_salary values(record.d_no,average);
else
select avg(salary) into average from emp1 group by d_no having d_no=record.d_no;
update dept_salary set Avg_salary=average where record.d_no=d_no;
end if;
close n_cur;
end loop;
close o_cur;
end;
/




