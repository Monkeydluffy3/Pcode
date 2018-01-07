/*
    21. Write a PL/SQL block for following requirement using user defined exception handling. 
    The account_master table records the current balance for an account, which is updated whenever, 
    any deposits or withdrawals takes place. If the withdrawal attempted is more than the current 
    balance held in the account. The user defined exception is raised, displaying an appropriate message. 
    Write a PL/SQL block for above requirement using user defined exception handling.
*/

create table account_master(accountno int,balance int);
insert into account_master values(1,100);
insert into account_master values(2,4000);
insert into account_master values(3,900);
insert into account_master values(4,8000);
insert into account_master values(5,500);

DECLARE
 operation varchar(20) := &operation;
 account_no int := &account_no;
 amount int := &amount;
 invalid_op EXCEPTION;
 bal int;
BEGIN
 select balance into bal from account_master where accountno=account_no;
 if operation='Withdrawl' and amount>bal then
  RAISE invalid_op;
 elsif operation='Withdrawl' then
  update account_master set balance=bal-amount where accountno=account_no;
  dbms_output.put_line('withdrawl success');
  
 elsif operation='Deposit' then
  update account_master set balance=bal+amount where accountno=account_no;
  dbms_output.put_line('deposit success');
 END if;
EXCEPTION
 WHEN invalid_op then
  dbms_output.put_line('insuffcient balance');
 WHEN no_data_found then
  dbms_output.put_line('no record found');
 WHEN others then
  dbms_output.put_line('Error');
END;
/
