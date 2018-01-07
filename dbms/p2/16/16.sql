/*

    16. Account(Acc_no, branch_name,balance)
branch(branch_name,branch_city,assets)
customer(cust_name,cust_street,cust_city)
Depositor(cust_name,acc_no)
      Loan(loan_no,branch_name,amount)
      Borrower(cust_name,loan_no)
    • Solve following query
Q1. Find the branches where average account balance > 12000.
Q2. Find number of tuples in customer relation.
Q3. Calculate total loan amount given by bank.
Q4. Delete all loans with loan amount between 1300 and 1500.
Q5. Delete all tuples at every branch located in Nigdi.
*/

1.select branch_name from account  group by branch_name having avg(balance)>1200;
2.select count(*) from customer;
3.select sum(amount) from loan;
4.delete from loan where amount>100 and amount<123445;
5.delete from branch where branch_city='Nigdi';