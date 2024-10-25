--Reading the file
SELECT *
FROM ..CovidDeaths
ORDER BY 3,4;

--SELECT *
--FROM ..CovidVaccinations
--ORDER BY 3, 4

-- Select columns of interest
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM ..CovidDeaths
ORDER BY 1, 2;

--Total Cases vs Total Deaths
SELECT 
    location, 
    date, 
    total_cases, 
    total_deaths, 
    ROUND((total_deaths / NULLIF(total_cases, 0)) * 100, 2) AS death_rate_perentage
FROM CovidDeaths
ORDER BY 1, 2;

--Infection death rate for Nigeria (Total Cases v Total Deaths)
SELECT 
    location, 
    date, 
    total_cases, 
    total_deaths, 
    ROUND((total_deaths / NULLIF(total_cases, 0)) * 100, 2) AS death_rate_perentage
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1, 2;

--Infection death rate for united states (Total Cases v Total Deaths)
SELECT 
    location, 
    date, 
    total_cases, 
    total_deaths, 
    ROUND((total_deaths / NULLIF(total_cases, 0)) * 100, 2) AS death_rate_perentage
FROM CovidDeaths
WHERE location = 'united states'
ORDER BY 1, 2;

--countries with highest infection rate (Total Cases V Country Population)
SELECT
	location,
    population, 
    MAX(total_cases) AS Highest_infection_count, 
    ROUND(MAX((total_cases/population)) * 100, 2) AS Percent_Population_infected
FROM CovidDeaths
GROUP BY location, population
ORDER BY Percent_Population_infected DESC

-- countries with highest death counts
-- because where continent is not null are the actual unique countries;
SELECT
	location,
    MAX(total_deaths) AS top_total_death
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY top_total_death DESC


----ANALYSIS BY CONTINENTS

--continents with highest death count
-- where continent is null is the unique continent stats
SELECT
	location,
	continent,
    MAX(total_deaths) AS top_total_death
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY location, continent
ORDER BY top_total_death DESC

--continent with highest infection rate (Total Cases V Country Population)
SELECT
    continent, 
    MAX(total_cases) AS Highest_infection_count, 
    ROUND(MAX((total_cases/population)) * 100, 2) AS Percent_Population_infected
FROM CovidDeaths
GROUP BY continent
ORDER BY Percent_Population_infected DESC


-- GLOBAL NUMBERS
--global cases v global deathrate
SELECT 
    date, 
    SUM(new_cases) AS daily_global_cases, 
    SUM(new_deaths) AS daily_global_deaths,
    ROUND((SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100, 2) AS Global_deathrate
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

--Global deathrate
SELECT 
    SUM(new_cases) AS total_cases, 
    SUM(new_deaths) AS total_deaths,
    ROUND((SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100, 2) AS Global_deathrate
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2













