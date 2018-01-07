/*
    16. 
a) Create View on borrower table by selecting any two columns and perform insert update delete operations
b) Create view on borrower and depositor table by selecting any one column from each table perform insert update delete operations
c) create updateable view on borrower table by selecting any two columns and perform insert update delete operations
*/

-- table are same as in q.12

create view b_view as select cust_name,loan_no from borrower;
insert into b_view values("rah",6);
select * from b_view;
select * from borrower;
update b_view set loan_no=9 where loan_no=5;
delete from b_view where loan_no=1;


create view v2 as select borrower.cust_name,depositor.acc_no from borrower,depositor where borrower.cust_name=depositor.cust_name;
--aliter
create view v as ( select i.cust_name,i.loan_no,f.acc_no from borrower i left join depositor f on i.cust_name=f.cust_name);
desc v;
insert into v values("rahul",4,5);
update v set cust_name='pain'where cust_name='Reshav';
