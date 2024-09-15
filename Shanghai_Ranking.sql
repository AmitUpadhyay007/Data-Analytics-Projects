create database shanghai_ranking;

use shanghai_ranking;

select *
from ranking;

-- Basic SELECT Queries:

-- Q1. Retrieve the names of the top 10 universities based on their world rank.

select University_Name, `Rank`
from ranking
order by `Rank` asc
limit 10;

-- Q2. List all universities that have a world rank greater than 50.

select University_Name, `Rank`
from ranking
where `Rank` > 50
order by `Rank` asc
limit 10;

-- Filtering with WHERE Clause:

-- Q3. Retrieve universities with an Alumni score greater than 80.

select University_Name, Alumni
from ranking
where Alumni > 80;

-- Sorting with ORDER BY:

-- Q4. Display the top 5 universities with the highest Award score.

select University_Name, Award
from ranking
order by Award desc
limit 5;


-- Q5. List the top 10 universities sorted by Publications (PUB) score in descending order.

select University_Name,PUB
from ranking
order by PUB desc
limit 10;

## Aggregate Functions:

-- Q6. Calculate the average Alumni score across all universities.

select round(avg(Alumni),2) as Average_Alumni_Score
from ranking;

-- Q7. Find the maximum Hici (Highly Cited Researchers) score and the university associated with it.

select University_Name , max(Hici) as maximum_Hici
from ranking
group by University_Name;

## Grouping and Aggregation:

-- Q8. Find the average Award score for universities in the top 50 ranks.

select round(avg(Award),2) as Avg_Award_top50
from ranking
where  `Rank` >=50;

-- Q9. Group universities by their national/regional rank and calculate the average PCP score for each group.

select `National/Regional Rank`, round(avg(PCP),2) as Avg_PCP
from ranking
group by `National/Regional Rank`;

## String Matching:

-- Q10. Find all universities that contain "University" in their name.

select University_Name
from ranking
where University_Name like '%University%';

-- Q11. Find all universities that contain "Technology" in their name.

select University_Name
from ranking
where University_Name like '%Technology%' ;







