/*
Implicit Cursor 
    3. The bank manager has decided to activate all those accounts which were previously 
    marked as inactive for performing no transaction in last 365 days. Write a PL/SQ block
     (using implicit cursor) to update the status of account, display an approximate 
     message based on the no. of rows affected by the update. (Use of %FOUND, %NOTFOUND, %ROWCOUNT).
*/

create table account1(accno int,cust_name varchar(20),status varchar(2));
insert into account1 values(1,'saurav','I');
insert into account1 values(2,'sachin','I');
insert into account1 values(3,'gourab','A');
insert into account1 values(4,'sen','I');
insert into account1 values(5,'goku','A');


set serveroutput on;
DECLARE
 noofrows int;
BEGIN
 update account1 set status='A' where status='I';
 if sql%notfound then
  dbms_output.put_line('no record found');
 elsif sql%found then
  noofrows:=sql%rowcount;
  dbms_output.put_line('no of records updated : '|| noofrows);
 END if;
END;
/
