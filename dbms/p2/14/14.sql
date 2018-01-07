/*

    14. CREATE TABLE countries (
  code CHAR(2) NOT NULL,
  year INT NOT NULL,
  gdp_per_capita DECIMAL(10, 2) NOT NULL,
  govt_debt DECIMAL(10, 2) NOT NULL
)

Solve following query
    1. What are the top 3 average government debts in percent of the GDP for those countries whose GDP per capita was over 40’000 dollars in every year in the last four years
    2. Are there any countries at all with a GDP per capita of more than 50’000 dollars?
*/

create table countries(code varchar(20) NOT NULL,year int NOT NULL,gdp_per_capita decimal(10,2) NOT NULL,govt_debt decimal(10,2) NOT NULL);

	select * from countries;

insert into countries values ('CHN', 2013, 45000, 1200);

insert into countries values ('IND', 2014, 4700.12, 12323);

insert into countries values ('JAP', 2015, 45566.12, 15612.33);

insert into countries values ('IND', 2016, 42231.352, 23412.33);

insert into countries values ('AUS', 2015, 75756.352, 12523.33);

insert into countries values ('NZL', 2013, 73422.352, 12532.33);

insert into countries values ('JAP', 2015, 56733.13, 21334.21);

insert into countries values ('NZL', 2016, 45736.12, 21324.21);

--queries
1. select code, avg(govt_debt) from countries where year >= 2013 and gdp_per_capita > 40000 group by code order by 2 desc limit 3;

2. select code from countries where gdp_per_capita > 50000;