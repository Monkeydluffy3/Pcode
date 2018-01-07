/*

    15. Consider the above table and solve the query 
    • List the number of customers in each country. Only include countries with more than 10 customers. 
    • List the number of customers in each country, except the USA, sorted high to low. Only include countries
    with 9 or more customers
*/
create table customer(id int not null,firstname varchar(20) not null,lastname varchar(20),city varchar(20),country varchar(20),phone varchar(20));

insert into customer values(1,"rahul","singh","pune","india",12345);
insert into customer values(2,"rahul1","singh1","pune1","india1",12345);
insert into customer values(3,"rahul1","singh1","pune1","india",12345)
insert into customer values(4,"rahul2","singh2","pune1","india1",12345);
insert into customer values(5,"rahul2","singh2","pune1","india1",1236545);

--add more insert to make count more than 9
--queries
1.select count(*),country from customer group by country having count(*)>2;
2.select count(*),country from customer where country!='USA' group by country having count(*)>=9 order by 1 desc;