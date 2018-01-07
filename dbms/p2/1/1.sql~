/*
    1. Write a stored function in PL/SQL for given requirement and use the same in PL/SQL block.
     Account no. and branch name will be accepted from user. The same will be searched in table 
     acct_details. If status of account is active then display appropriate message and also
      store the account details in active_acc_details table, otherwise display message on 
      screen “account is inactive”.
*/

create table acct_details(accno int,cust_name varchar(20),branch_name varchar(20),status varchar(2));

insert into acct_details values(1,'dighi','saurav','I');
insert into acct_details values(2,'wadi','sen','A');
insert into acct_details values(3,'hadapsar','sachin','A');

create table active_acc_details(accno int,branchname varchar(20),cust_name varchar(20));

CREATE OR REPLACE FUNCTION activebankusers(accountno IN int,branchname IN varchar) 
RETURN varchar 
AS
  customername varchar(20);
  statusofuser varchar(2);
  x varchar(20);
BEGIN
 select cust_name,status into customername,statusofuser from acct_details where accno=accountno and branch_name=branchname;
 if statusofuser='I' then
 	x:='Inactive User';
 else
 	x:='Active User';
 	insert into active_acc_details values (accountno,branchname,customername); 
 END if;
 return x;
END;
/

set serveroutput on;
DECLARE
 accountno int;
 branchname varchar(20);
 x varchar(20);
BEGIN
 accountno:=&accountno;
 branchname:=&branchname;
 x:=activebankusers(accountno,branchname);
 dbms_output.put_line('output : '||x);
END;
/



