/*

    11. Account(Acc_no, branch_name,balance)
branch(branch_name,branch_city,assets)
customer(cust_name,cust_street,cust_city)
Depositor(cust_name,acc_no)
      Loan(loan_no,branch_name,amount)
      Borrower(cust_name,loan_no)
Solve following query
Q1. Find all customers who have both account and loan at bank.
      Q2. Find all customer who have account but no loan at the bank.
Q3. Find average account balance at Akurdi branch.
     Q4. Find the average account balance at each branch
     Q5. Find no. of depositors at each branch.
*/
create table account(acc_no int,branch_name varchar(20) NOT NULL,balance int,PRIMARY KEY(acc_no));

create table branch(branch_name varchar(20) NOT NULL,branch_city varchar(20),assets bigint);

create table customer(cust_name varchar(20) PRIMARY KEY,cust_street varchar(20),cust_city varchar(20));

create table depositor(cust_name varchar(20),acc_no int,FOREIGN KEY(acc_no) references account(acc_no));

create table loan(loan_no int PRIMARY KEY,branch_name varchar(20),amount int);

create table borrower(cust_name varchar(20) NOT NULL,loan_no int,FOREIGN KEY(loan_no) references loan(loan_no));


    insert into account(acc_no, branch_name, balance) values (15206, 'SBI',2332.72);
	insert into account(acc_no, branch_name, balance) values (15209, 'HDFC',8376.14);
	insert into account(acc_no, branch_name, balance) values (15200, 'SBI',2213.13);
	insert into account(acc_no, branch_name, balance) values (15111, 'HDFC',12313.13);
	insert into account(acc_no, branch_name, balance) values (15211, 'HDFC',19712.13);

    insert into branch values ('SBI', 'Pune', 142221.91);
	insert into branch values ('HDFC', 'Pune', 298732.12);
	insert into branch values ('AXIS', 'Pune', 193841.21);
	
	insert into customer values ('Reshav', 'AIT', 'Pune');
	insert into customer values ('Navneet', 'PICT', 'Pune');
	insert into customer values ('Suresh', 'COEP', 'Jhansi');
	insert into customer values ('Kartik', 'AIT', 'Gwalior');
	insert into customer values ('Mohan', 'AIMS', 'Daund');
	insert into customer values ('Goku', 'IIT', 'Delhi');
	insert into customer values ('Naruto', 'IIT', 'Bombay');
	
	
	insert into depositor values ('Reshav', 15206);
	insert into depositor values ('Navneet', 15209);
	insert into depositor values ('Kartik', 15200);
	insert into depositor values ('Goku', 15111);
	insert into depositor values ('Naruto', 15211);
	
	insert into loan values (60251, 'SBI', 1000);
	insert into loan values (90251, 'HDFC', 2000);
	insert into loan values (10251, 'SBI', 1500);
	insert into loan values (50251, 'AXIS', 1001);
	insert into loan values (80251, 'AXIS', 1721);

	insert into borrower(cust_name, loan_no) values ('Reshav', 60251);
	insert into borrower(cust_name, loan_no) values ('Suresh', 10251);
	insert into borrower(cust_name, loan_no) values ('Navneet', 90251);
	insert into borrower(cust_name, loan_no) values ('Mohan', 50251);
	insert into borrower(cust_name, loan_no) values ('Kartik', 80251);

--queries
1.select cust_name from borrower where cust_name in (select cust_name from depositor);
2.select cust_name from depositor where cust_name not in (select cust_name from borrower);
3.select avg(balance) from account where branch_name = 'HDFC';
4.select avg(balance), branch_name from account group by branch_name;
5.select count(*), branch_name from account group by branch_name;