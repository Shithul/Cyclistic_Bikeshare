-- DATA cleaning
--WE uploaded all the data tables into SQL under Data base 'PortfolioProject'
--For this project we are taking 12 tables each containing Each months Tripdata
-- To conmbine all the datas into one table we need to clean the data .currently end_station_id for tables T9,T10,T11 AND T12
--are float  we need to convert it into varchar(225) so we can do the UNION operation

ALTER TABLE[PortfolioProject].[dbo].[T8]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T7]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T6]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T5]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T4]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T3]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T2]
ALTER COLUMN [end_station_id] varchar(225)

ALTER TABLE[PortfolioProject].[dbo].[T1]
ALTER COLUMN [end_station_id] varchar(225)

--Now lets combine all the tables into one 

SELECT *
INTO[PortfolioProject].dbo.Cycle_trip
FROM
  (SELECT *
  FROM [PortfolioProject].[dbo].[T1]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T2]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T3]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T4]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T5]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T6]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T7]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T8]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T9]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T10]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T11]
  UNION
  SELECT *
  FROM [PortfolioProject].[dbo].[T12] ) AS Trip_Data
  
 SELECT TOP (1000) *
 FROM  [PortfolioProject].[dbo].[Cycle_trip]

--For further analysis we required Trip_duration ,so we can create a new Column showing Trip duration or Length of trip

 ALTER TABLE [PortfolioProject].[dbo].[Cycle_trip]
 ADD Trip_Duration time
 GO

--UPDATE the table with Trip_Duration

 UPDATE [dbo].[Cycle_trip]
 SET [Trip_Duration] = [ended_at]-[started_at]

--To check the Trip_Duration

 SELECT *
 FROM[dbo].[Cycle_trip]
 WHERE [Trip_Duration] <= '00:00:00.0000000'

-- check any null values in started_at and ended_at
 SELECT *
 FROM[dbo].[Cycle_trip]
 WHERE ended_at IS NULL OR ended_at IS NULL

--There are some rides where tripduration shows up as negative,
--including several hundred rides where Divvy took bikes out of circulation for Quality Control reasons. 
--We will want to delete these rides.
--Check is there any values that started_at > ended_at 

 SELECT *
 FROM[dbo].[Cycle_trip]
 WHERE started_at > ended_at

--Removing such rows

 DELETE
 FROM [dbo].[Cycle_trip]
 WHERE started_at > ended_at

--Lets see what are types of memberships in the data set

 SELECT DISTINCT(member_casual)
 FROM[dbo].[Cycle_trip]


--Lets Analyse the Trip_Duration data
 SELECT MAX(Trip_Duration)
 FROM[dbo].[Cycle_trip]

 SELECT MIN(Trip_Duration)
 FROM[dbo].[Cycle_trip]

--lets find out Averge Trip_duration which is around from the below Query as "24 min and 24 seconds"
 SELECT CAST (CAST( AVG(CAST(CAST(Trip_Duration AS DATETIME) AS FLOAT))AS DATETIME)AS TIME)
 FROM[dbo].[Cycle_trip]

--Lets add a new column showing the Weekday of trips this will help in further analysis of the Cycle trip
--Here 1 is Sunday upto 7 is Saturday 

 ALTER TABLE [dbo].[Cycle_trip]
 ADD Week_Day int

 UPDATE [dbo].[Cycle_trip]
 SET Week_Day = DATEPART(WEEKDAY , started_at)


--To find no.of rides in each hour per day
--This result can be used for Visualizaion to find out which type of rider using the service in a day hours.

 SELECT DATEPART(hour, started_at) AS 'Hour', COUNT(*) AS 'Count',member_casual
 FROM[dbo].[Cycle_trip]
 WHERE start_station_name IS NOT NULL
 GROUP BY DATEPART(hour, started_at), member_casual
 ORDER BY DATEPART(hour, started_at)

--To find no.of rides per weeks
--This result can be used for Visualizaion to find out the trends of each type of rider is most active in Weekdays.


 SELECT  DATEPART(WEEKDAY, started_at) AS 'WEEKDAY', COUNT(*) AS 'Count',member_casual
 FROM[dbo].[Cycle_trip]
 WHERE start_station_name IS NOT NULL
 GROUP BY DATEPART(WEEKDAY, started_at), member_casual
 ORDER BY DATEPART(WEEKDAY, started_at)

--To find no.of rides per Months by each rider type
--This result can be used for Visualizaion to find out the trends of each type rider through overall year.

 SELECT  DATEPART(MONTH, started_at) AS 'MONTH', COUNT(*) AS 'Count',member_casual
 FROM[dbo].[Cycle_trip]
 WHERE start_station_name IS NOT NULL
 GROUP BY DATEPART(MONTH, started_at), member_casual
 ORDER BY DATEPART(MONTH, started_at)

--Lets Find out popular Bikes among people

 SELECT rideable_type,member_casual, COUNT(*) AS 'Count', CAST(started_at AS DATE) AS 'DATE'
 FROM[dbo].[Cycle_trip]
 WHERE start_station_name IS NOT NULL
 GROUP BY  CAST(started_at AS DATE),rideable_type,member_casual


--Average ride time by riders through out a Week.

 SELECT	CAST (CAST( AVG(CAST(CAST(Trip_Duration AS DATETIME) AS FLOAT))AS DATETIME)AS TIME) AS Average_Ride_Length
       ,member_casual,DATEPART(dw, started_at) as Weeksday
 FROM[dbo].[Cycle_trip]
 GROUP BY DATEPART(dw, started_at),member_casual