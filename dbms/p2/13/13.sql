/*

    13. Create following Tables
emp_mstr(e_mpno,f_name,l_name,m_name,dept,desg,branch_no)
branch_mstr(name,b_no)
List the employee details along with branch names to which they belong
 Create following Tables
emp_mstr(emp_no,f_name,l_name,m_name,dept)
cntc_dets(code_no,cntc_type,cntc_data)
List the employee details along with contact details using left outer join & right join.
*/
create table emp_mstr (emp_no integer, fname varchar(20), lname varchar(20), dept varchar(20), desg varchar(20), branch_no integer);

create table branch_mstr (name varchar(20), b_no integer);

create table cntc_dets(code_no integer,cntc_type varchar(30), cntc_data integer);

insert into emp_mstr  values (15206, 'Reshav', 'Kumar', 'Computer', 'Developer', 3);
insert into emp_mstr  values (15689, 'Saurav', 'Sen', 'IT', 'Scientist', 2);
insert into emp_mstr  values (15209, 'Navneet', 'Kumar', 'Computer', 'Developer', 3);

insert into branch_mstr values ('Akatsuki', 1);
insert into branch_mstr values ('Hidden Mist', 2);
insert into branch_mstr values ('Hidden Leaf', 3);
insert into branch_mstr values ('Hidden Cloud', 4);

insert into cntc_dets values (15200, 'Mobile', '8007863621');
insert into cntc_dets values (15206, 'Mobile', '8007680311');
insert into cntc_dets values (15209, 'Phone', '011-4222323');
insert into cntc_dets values (15032, 'Mobile', '9405955734');

--queries
1.  select emp_no, fname, lname, dept, desg, branch_mstr.name from emp_mstr, branch_mstr where branch_mstr.b_no = emp_mstr.branch_no;
2a. select * from emp_mstr left join cntc_dets on emp_mstr.emp_no = cntc_dets.code_no;
2b. select * from emp_mstr right join cntc_dets on emp_mstr.emp_no = cntc_dets.code_no;