/*

    12. Create following Tables
cust_mstr(cust_no,fname,lname)
add_dets(code_no,add1,add2,state,city,pincode)
Retrieve the address of customer Fname as 'xyz' and Lname as 'pqr'
Create following Tables
cust_mstr(custno,fname,lname)
acc_fd_cust_dets(codeno,acc_fd_no)
fd_dets(fd_sr_no,amt)
List the customer holding fixed deposit of amount more than 5000
*/
create table cust_mstr(cust_no integer, fname varchar(30), lname varchar(30));

create table add_dets(cust_no integer,add1 varchar(30), add2 varchar(30), state varchar(30), city varchar(30), pincode integer);

create table acc_fd_dets (cust_no integer, acc_fd_no integer);

create table fd_dets (fd_sr_no integer, amount float);

insert into cust_mstr values (1, 'Reshav', 'Kumar');
insert into cust_mstr values (2, 'Tushar', 'Kumar');
insert into cust_mstr values (3, 'xyz', 'pqr');
	
insert into add_dets  values (1, 'AIT', 'Dighi', 'Maharashtra', 'Pune', 411015);
insert into add_dets  values (3, 'PICT', 'Vidyapeeth', 'Maharashtra', 'Nagpur', 435133);
insert into add_dets  values (2, 'COEP', 'Alandi', 'Maharashtra', 'Nashik', 423193);

insert into acc_fd_dets  values (2, 15032);
insert into acc_fd_dets  values (1, 15206);
insert into acc_fd_dets  values (3, 15001);

insert into fd_dets  values (15206, 2133.33);
insert into fd_dets  values (15001, 78642.02);
insert into fd_dets  values (15032, 23123.21);

--queries
1.select add1, add2, city, state, pincode from add_dets where cust_no = (select cust_no from cust_mstr where fname = 'xyz' and lname = 'pqr');
--aliter
1.select add1,add2,city,state,pincode from add_dets inner join cust_mstr on add_dets.cust_no = cust_mstr.cust_no where fname="xyz" and lname="pqr";



2.select fname, lname from cust_mstr where cust_no in (select cust_no from acc_fd_dets where acc_fd_no in (select fd_sr_no from fd_dets where amount > 5000));
--aliter
2.select fname,lname from cust_mstr inner join acc_fd_dets on cust_mstr.cust_no = acc_fd_dets.cust_no inner join fd_dets 
on acc_fd_dets.acc_fd_no = fd_dets.fd_sr_no where amount > 5000;



