select * from PortfolioProject..CovidDeaths
order by 3,4

select * from PortfolioProject..CovidVaccinations
order by 3,4

--Select Data that we are going to be using

Select Location,date,total_cases,new_cases,total_deaths, Population
FROM PortfolioProject..CovidDeaths
order by 1,2

-- Looking at Total Cases Vs Total Deaths
-- shows the likelihood of dying if you are infected in your country
Select Location,date,total_cases,total_deaths, (total_deaths/total_cases) *100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
Where location like 'Poland'
order by 1,2


--Looking at total cases VS Population
-- SHows what Percentage of the Population got Covid
Select Location,date,population,total_cases, (total_cases/population) *100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like 'Poland'
order by 1,2

-- Looking at Counteries with Highest infection rate based on population
Select Location,population,MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population)) *100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like 'Poland'
GROUP BY location,population
order by PercentPopulationInfected DESC

--Showing the Counteries with the Highest Death Count per Population

Select Location,MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not NUll --to avoid grouping by continents!
--Where location like 'Poland'
GROUP BY location
order by TotalDeathCount DESC

-- let's break it down by continent

Select continent,MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not NUll --to avoid grouping by continents!
--Where location like 'Poland'
GROUP BY continent
order by TotalDeathCount DESC

-- The right way for the accurate numbers is this one to be frank!!!!:
Select location,MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is  NUll --to avoid grouping by continents we use NOT NULL!
--Where location like 'Poland'
GROUP BY location
order by TotalDeathCount DESC


-- Showing the continenets with the highest death counts
Select continent,MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is  NUll --to avoid grouping by continents we use NOT NULL!
--Where location like 'Poland'
GROUP BY continent
order by TotalDeathCount DESC


-- Global Numbers

select SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as int)) AS total_deaths,
SUM(CAST(new_deaths as int)) / SUM(new_cases)  * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is NOT NULL
order by 1,2

--COVID VAccination Table wrangling

SELECT * FROM PortfolioProject..CovidDeaths AS dea
join PortfolioProject..CovidVaccinations AS vac
	on dea.location = vac.location
	and dea.date = vac.date

--Looking at the totla Pop. VS Vaccination

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(try_Cast(Ltrim(rtrim(vac.new_vaccinations)) as bigint)) OVER (Partition by dea.Location order by dea.location,dea.Date) as RollingPeopleVaccinated

FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is  not NULL 
order by 2,3

-- USE CTE

with popvsVac (continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(try_Cast(Ltrim(rtrim(vac.new_vaccinations)) as bigint)) OVER (Partition by dea.Location order by dea.location,dea.Date) as RollingPeopleVaccinated

FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is  not NULL 
--order by 2,3

)
select *,(RollingPeopleVaccinated / population) * 100
from popvsVac


--TEMP TABLE

drop Table if exists #percentPopulationVaccinated
Create Table #percentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #percentPopulationVaccinated

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(try_Cast(Ltrim(rtrim(vac.new_vaccinations)) as bigint)) OVER (Partition by dea.Location order by dea.location,dea.Date) as RollingPeopleVaccinated

FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is  not NULL 
--order by 2,3

select *,(RollingPeopleVaccinated / population) * 100
from #percentPopulationVaccinated


-- Creating view to store data for later vissualization

create view percentPopulationVaccinated   as
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(try_Cast(Ltrim(rtrim(vac.new_vaccinations)) as bigint)) OVER (Partition by dea.Location order by dea.location,dea.Date) as RollingPeopleVaccinated

FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is  not NULL 
--order by 2,3