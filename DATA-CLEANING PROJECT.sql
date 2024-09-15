-- DATA CLEANING PROJECT

-- 1. Remove Dulplicates
-- 2. Standardize the data
-- 3. Null Values or blank values
-- 4. Remove Any Row or Column

create database world_layoffs;

use world_layoffs;

select * 
from layoffs;

-- Removing Duplicates

create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;

select * 
from layoffs_staging;

select *,
row_number() over (partition by company, location, industry, total_laid_off,
 percentage_laid_off, `date`, country, funds_raised_millions) as row_num
from layoffs_staging;

with duplicates_cte as
(
select *,
row_number() over (partition by company, location, industry, total_laid_off,
 percentage_laid_off, `date`, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * 
from duplicates_cte
where row_num >1;

select * 
from layoffs_staging
where company='casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over (partition by company, location, industry, total_laid_off,
 percentage_laid_off, `date`, country, funds_raised_millions) as row_num
from layoffs_staging;

delete 
from layoffs_staging2
where row_num > 1;

select * 
from layoffs_staging2
where row_num > 1;

-- Standardizing data

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select *
from layoffs_staging2
where industry like 'Crypto%';

select distinct country
from layoffs_staging2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select *
from layoffs_staging2;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date`
from layoffs_staging2;

alter table layoffs_staging2
modify column `date` date;

-- Null values or Blank values

select *
from layoffs_staging2
where industry is NULL
or industry = '';

update layoffs_staging2
set industry = null
where industry ='';

select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where t1.industry is null 
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2 
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null; 

-- Removing unnecessary rows or column

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2;
