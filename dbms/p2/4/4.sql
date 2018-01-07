/*
EXPLICIT CURSOR: 
    4. Organization has decided to increase the salary of employees by 10% of existing salary, 
    who are having salary less than average salary of organization, Whenever such salary 
    updates takes place, a record for the same is maintained in the increment_salary table.
     EMP (E_no , Salary) increment_salary(E_no , Salary).

*/

create table emp(e_no int,salary int);

insert into emp values(1,10000);
insert into emp values(2,20000);
insert into emp values(3,15000);
insert into emp values(4,9000);

create table increment_salary(e_no int,salary int);

set serveroutput on;
DECLARE
 t_emp int:=0;
 sal int;
 avg_sal float:=0;
 t_sal float:=0;
 empno int;
 CURSOR c IS select e_no,salary from emp;
BEGIN
 open c;
 loop
  FETCH c into empno,sal;
  EXIT when c%notfound;
  t_sal:=t_sal+sal;
  t_emp:=t_emp+1;
 END loop;
 avg_sal:=t_sal/t_emp;
 dbms_output.put_line('Average Salary : '|| avg_sal);
 CLOSE c;

 open c;
 loop
 FETCH c into empno,sal;
 EXIT when c%notfound;
 if sal<avg_sal then
  sal:=sal+0.1*sal;
  dbms_output.put_line(empno||' '||sal);
  update emp set salary=sal where e_no=empno;
  insert into increment_salary values(empno,sal);
 END if;
 END loop;
 CLOSE c;
 dbms_output.put_line('Salaries Updated'); 
END;
/