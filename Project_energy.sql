-- Database and Table Creation
create database energy_consumption;
use energy_consumption;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- SQL Queries for Analysis

-- What is the total emission per country for the most recent year available? 
select country,sum(emission) as total_emission 
from emission_3
where year = (select max(year) from emission_3)
group by country
order by total_emission DESC;

-- What are the top 5 countries by GDP in the most recent year?
select country,Value 
from gdp_3
where year = (select max(year) from gdp_3)
order by value DESC
limit 5;

-- Compare energy production and consumption by country and year. 
select p.country,p.year,p.p_c,c.s_c
from (select year,country,sum(production) as p_c 
from production
group by year,country) as p
join (select year,country,sum(consumption) as s_c 
from consumption
group by year,country) as c
on (p.country = c.country and p.year = c.year)
order by p.p_c DESC;

-- Which energy types contribute most to emissions across all countries?
select energy_type,sum(emission) as emission_all 
from emission_3
group by energy_type
order by emission_all DESC;

-- How have global emissions changed year over year?
select year,sum(emission) as emission_all 
from emission_3
group by year
order by emission_all DESC;

-- What is the trend in GDP for each country over the given years?
select g1.country,g1.year,(g1.Value-g2.Value) as change_gdp
from gdp_3 as g1
left join gdp_3 as g2
on g1.country = g2.country and g1.year = g2.year+1
order by g1.country,g1.year;

-- How has population growth affected total emissions in each country?
select e.country,e.year,e.emission_all,p.value as Population
from (select country,year,sum(emission) as emission_all 
from emission_3
group by country,year) as e
join population p 
on p.countries = e.country and p.year = e.year
order by e.country,e.year;

-- Has energy consumption increased or decreased over the years for major economies?
select c.country,c.year,c.c_all,g.value
from (select country,year,sum(consumption) as c_all
from consumption
group by country,year) as c
join gdp_3 as g
on g.country = c.country and g.year = c.year
order by c.c_all DESC;

-- What is the average yearly change in emissions per capita for each country?
SELECT country, year, AVG(per_capita_emission) AS avg_yearly_change
FROM emission_3
GROUP BY country, year;


-- What is the emission-to-GDP ratio for each country by year?
select e.country,e.year,e.emi_all,ga.value,(e.emi_all/ga.value) as emission_to_gdp
from (select country,year,sum(emission) as emi_all
from emission_3
group by country,year) as e
join gdp_3 as ga
on ga.country = e.country and ga.year = e.year;

-- What is the energy consumption per capita for each country over the last decade?
select country,avg(consumption) as p_c
from consumption
group by country
order by p_c DESC;

-- How does energy production per capita vary across countries?
select country,avg(production) as p_c
from production
group by country
order by p_c DESC;

-- Which countries have the highest energy consumption relative to GDP?
select g.country,(c.consu_all/g.gdp_sum) as con_to_gdp
from (select country,sum(consumption) as consu_all
from consumption
group by country) as c
join (select country,sum(value) as gdp_sum
from gdp_3
group by country)as g
on g.country = c.country 
order by con_to_gdp DESC;

-- What is the correlation between GDP growth and energy production growth?
select g.country,g.year,g.gdp_growth,p.prod_change
from (select g1.country,g1.year,(g1.value - g2.value) as gdp_growth from gdp_3 as g1
join gdp_3 as g2
on g1.country = g2.country and g1.year = g2.year + 1) as g
join (select p1.country,p1.year,(p1.prod-p2.prod) as prod_change
from (select country,year,sum(production) as prod
from production
group by country,year) as p1
join (select country,year,sum(production) as prod
from production
group by country,year) as p2
on p1.country = p2.country and p1.year = p2.year + 1) as p
on p.country = g.country and p.year = g.year
order by g.country,g.year;

-- What are the top 10 countries by population and how do their emissions compare?
select e.country,sum(emission)as total_emission,p.population 
from emission_3 as e
join (select p.countries,MAX(p.value) as population 
from population as p
group by countries) as p
on e.country = p.countries
group by e.country
order by p.population DESC
limit 10;


select p.countries,MAX(p.value) as population 
from population as p
group by countries;

-- What is the global share (%) of emissions by country?
with total as(
select sum(emission) as t_e
from emission_3
)
select country,sum(emission) as c_e,((sum(emission)/(select t_e from total)))*100 as perc_c_e
from emission_3
group by country
order by c_e DESC;

-- What is the global average GDP, emission, and population by year?
SELECT 
    g.year,g.avg_gdp,e.avg_emission,p.avg_population
FROM
    (SELECT year, AVG(value) AS avg_gdp 
     FROM gdp_3 
     GROUP BY year) g
LEFT JOIN
    (SELECT year, AVG(emission) AS avg_emission 
     FROM emission_3 
     GROUP BY year) e
ON g.year = e.year
LEFT JOIN
    (SELECT year, AVG(value) AS avg_population 
     FROM population 
     GROUP BY year) p
ON g.year = p.year
ORDER BY g.year;