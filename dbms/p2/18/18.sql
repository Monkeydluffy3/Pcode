/*
    18. Unnamed PL/SQL code block: Use of Control structure and Exception handling is mandatory. 
    Write a PL/SQL block of code for the following requirements:- Schema: 
1. Borrower(Rollin, Name, DateofIssue, NameofBook, Status) 
2. Fine(Roll_no,Date,Amt) 
    I. Accept roll_no & name of book from user. 
    II. Check the number of days (from date of issue), if days are between 15 to 30 then fine amount will be Rs 5per day. 
    III. If no. of days>30, per day fine will be Rs 50 per day & for days less than 30, Rs. 5 per day. 
    IV. After submitting the book, status will change from I to R. 
    V. If condition of fine is true, then details will be stored into fine table. 
*/

create table Borrower(Rollin int, Name varchar(15), DateofIssue date, NameofBook varchar(15), Status varchar(2));
insert into Borrower values(101, 'tks', '01-06-2016', 'phy', 'I');
insert into Borrower values(102, 'vps', '01-08-2017', 'chem', 'I');
insert into Borrower values(103, 'vs', '01-08-2017', 'chem', 'I');
insert into Borrower values(104, 'vs', '01-08-2017', 'chem', 'I');

create table Fine(Roll_no int, dateOfFine Date,Amt numeric(7,2));

DECLARE
  roll integer:=&roll;
  bookname varchar(20):=&bookname;
  duration integer:=0;
  fine float :=0.0;
  issue_date date;
BEGIN
  select DateofIssue into issue_date from Borrower where Rollin=roll and NameofBook=bookname;
  duration:=sysdate - issue_date;
  
  if duration>=15 and duration<=30 then
    fine:=duration*5;
  elsif duration>30 then
    fine:=(duration-30)*50;
  end if;
  
  update Borrower set status='R' where Rollin=roll and NameofBook=bookname;
  if fine>0 then
    insert into Fine values(roll,sysdate,fine);
  end if;
  dbms_output.put_line('FINE : '||fine||' duration: '||duration);
EXCEPTION
  when no_data_found then
    dbms_output.put_line('record not found');
  when others then
    dbms_output.put_line('error');

END;
/