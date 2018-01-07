/*
Parameterized Cursor 
    7. Write the PL/SQL block for following requirements using parameterized Cursor:
     Consider table EMP(e_no, d_no, Salary), department wise average salary should be
      inserted into new table dept_salary(d_no, Avg_salary).
*/

create table dept_salary(d_no int,avg_salary float);

create table emp(e_no int,d_no int,salary int);

insert into emp values (1,101,10000);
insert into emp values (1,102,10500);
insert into emp values(1,103,11000);
insert into emp values(1,101,14000);
insert into emp values(1,102,11200);
insert into emp values(1,101,11400);

set serveroutput on;
DECLARE
 t_dept int;
 aveg float:=0.0;
 sal int;
 iterate int:=0;
 found int:=0;
 CURSOR c(dno int) IS select d_no,salary from emp where d_no=dno;
 CURSOR c1 IS select d_no from emp;
BEGIN
  open c1;
  loop
	   FETCH c1 into t_dept;
	   EXIT when c1%notfound;
     aveg:=0;
	   select count(*) into iterate from emp where d_no=t_dept;
	   dbms_output.put_line(iterate);
	   FOR emp_rec IN c(t_dept)
	   LOOP
	    aveg:=aveg+emp_rec.salary;
	   END LOOP;
	     aveg := aveg/iterate;
	     select count(*) into found from dept_salary where d_no=t_dept;
	    IF found=0 then
	     insert into dept_salary values(t_dept,aveg);
	    END if;
   END loop;
   CLOSE c1;
END;
/
