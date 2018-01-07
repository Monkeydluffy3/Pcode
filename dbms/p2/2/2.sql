/*
    2. Write a PL/SQL stored Procedure for following requirements and call the procedure 
    in appropriate PL/SQL block. 1. Borrower(Rollin, Name, DateofIssue, NameofBook, Status)
     2. Fine(Roll_no,Date,Amt)  Accept roll_no & name of book from user.  Check the number
      of days (from date of issue), if days are between 15 to 30 then fine amount will be
       Rs 5per day.  If no. of days>30, per day fine will be Rs 50 per day & for days
        less than 30, Rs. 5 per day.  After submitting the book, status will change 
        from I to R.  If condition of fine is true, then details will be stored into fine table.
*/

create table Borrower(Rollin int, Name varchar(15), DateofIssue date, NameofBook varchar(15), Status varchar(2));
insert into Borrower values(101, 'tks', '01-06-2016', 'phy', 'I');
insert into Borrower values(102, 'vps', '01-08-2017', 'bio', 'I');
insert into Borrower values(103, 'vs', '01-08-2017', 'history', 'I');
insert into Borrower values(104, 'vs', '01-08-2017', 'chem', 'I');

create table Fine(Roll_no int, dateOfFine Date,Amt numeric(7,2));

CREATE OR REPLACE PROCEDURE bookreturn(roll IN int,bookname IN varchar) 
AS
 duration int:=0;
 fine float:=0.0;
 issuedate date;
BEGIN
 select DateofIssue into issuedate from Borrower where Rollin=roll and NameofBook=bookname;
 duration:=sysdate - issuedate;

 if duration>=15 and duration<=30 then
    fine:=duration*5;
  elsif duration>30 then
    fine:=(duration-30)*50;
  END if;

 update Borrower set Status='R' where Rollin=roll and NameofBook=bookname;
 if fine>0 then
  insert into Fine values (roll,sysdate,fine);
 END if; 
 dbms_output.put_line('FINE'||fine||' duration: '||duration);
EXCEPTION
 when no_data_found then
  dbms_output.put_line('no record found');
END;
/


set serveroutput on;
DECLARE
 roll int;
 bookname varchar(15);
BEGIN
 roll:=&roll;
 bookname:=&bookname;
 bookreturn(roll,bookname);
END;
/
