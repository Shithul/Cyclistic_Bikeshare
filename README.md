# Cyclistic_Bikeshare
A capstone project for the *Google Data Analytics certificate*.
## Scenario
In this project I'm acting as a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. 
Companies Bike-share program features more than 5,800 bicycles and 600 docking stations. Cyclistic users are more likely to ride for leisure,
but about 30% use them to commute to work each day.

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that
are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime. flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders.Rather than creating a marketing campaign that targets all-new customers, Moreno(The director of marketing) believes there is a very good chance to *convert casual riders into members*. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs. 

My Assignment is work with past data and finding how do annual members and casual riders use Cyclistic bikes differently

## Deliverables
1. A clear statement of the business task
2. A description of all data sources used
3. Documentation of any cleaning or manipulation of data
4. A summary of analysis
5. Supporting visualizations and key findings
6. Top three recommendations based on analysis

To succeed in the deliverables, we are going to follow the data analysis process: ask, prepare, process, analyze, share and act

## Ask
*Business task* : To find how annual members and casual riders used Cyclistic bike over the span of 12 months and provide recommandations
*Main stakeholders* :
* Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns  and initiatives to promote the bike-share program.
* Cyclistic executive team: executive team will decide whether to approve the recommended marketing program.

## Prepare
In this project Iam using Cyclistic’s historical trip data to analyze and identify trends downloaded from [Divvy_Tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html).The data were 12 months historical trip data saved in a zip file as a CSV structure.The data has been made available by
Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).
The data is relevant but I do have some concerns about our task.

Since we have to analyze the data over the past 12 months, I'm afraid we might miss out on some key trends that could be available with more data over a longer timeframe especially due to the influence of pandemic situation may be effected the overall trend.

## Process
The data, which includes the 12 months of April 2020 through March 2021 is downloaded. The .zip files convert to CSV text files, and we import these files to tables housed in an Azure Data Studio database, which runs Microsoft SQL Server (MSSQL). The SQL tables are combined into a larger table and cleaned it afterwards.

[Click Here](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/SQLQuery_Portfolio.sql) To see all the Data cleaning Steps

## Analysis
We will be using pivot tables and charts from Excel to get a summary of our findings. The results from the following SQL statements will create our data viz in Excel
### Total No of rides in Day hours
To analyze and visualize the average number of bike trip  per day for casual and member riders, we used the results from this SQL statement to create the visualization in Excel

```
 SELECT   DATEPART(hour, started_at) AS 'Hour', 
          COUNT(*) AS 'Count',
          member_casual
 FROM     [dbo].[Cycle_trip]
 WHERE    start_station_name IS NOT NULL
 GROUP BY DATEPART(hour, started_at), member_casual
 ORDER BY DATEPART(hour, started_at)
``` 
 ![Avg_NoOf_RidesPerDay](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/AVG_No_of_RidesPerDay.jpg)
 
This chart illustrating the Subscription members are more frequently using the service in a day, were evening 5 o Clock being the peak time for both casual as well as subscrition members. From the graph it is understandable that the subscription members usage is mainly focused on the working hours in a day. After 5 o clock subscription members usage significantly decreases.We can summarise that most of the subscription members using bike as a main commute for work. 

### Average Trip Duration by riders Weekly
To analyze and visualize the average Trip Duration weekly for casual and member riders, we used the results from this SQL statement to create the visualization 
```
 SELECT	  CAST (CAST( AVG(CAST(CAST(Trip_Duration AS DATETIME) AS FLOAT))AS DATETIME)AS TIME) AS Average_Ride_Length ,
          member_casual,
          DATEPART(dw, started_at) as Weeksday
 FROM     [dbo].[Cycle_trip]
 GROUP BY DATEPART(dw, started_at),member_casual
 ```
![Avg_trip](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/AVG_TripDuration_PerWeek.jpg)

This data viz reiterates the trend from the average monthly analysis casual riders tends to take longer trips than members. However, members are more consistent with their rides throughout the week.

### Rides per Week
Result from this SQL statement were used to create visualization in Excel
```

 SELECT   DATEPART(WEEKDAY, started_at) AS 'WEEKDAY',
          COUNT(*) AS 'Count',
          member_casual
 FROM     [dbo].[Cycle_trip]
 WHERE    start_station_name IS NOT NULL
 GROUP BY DATEPART(WEEKDAY, started_at), member_casual
 ORDER BY DATEPART(WEEKDAY, started_at)
 ```
 ![Rides_Week](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/RidePer_Week.jpg)
 
 Casual riders are more active in weekends they have more trips than the subscribe members, where the Members riders are consitent with their utilization throughout the week.
 
 ### Rides per Month
 For the analysis of Total No of rides by both Casual and Subscription members for each month, following SQL query were used to create Data Visualization
 ```
 SELECT   DATEPART(MONTH, started_at) AS 'MONTH', 
          COUNT(*) AS 'Count',
          member_casual
 FROM     [dbo].[Cycle_trip]
 WHERE    start_station_name IS NOT NULL
 GROUP BY DATEPART(MONTH, started_at), member_casual
 ORDER BY DATEPART(MONTH, started_at)
 ```
 ![Rides_Month](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/RidesPer_Month.jpg)
 
The chart above illustrates how the seasonal changes directly effecting the Bike trips. A significant drop in bike trips during the winter months and then bike trips increase as the weather gets warmer . In warmer months there is a significant increase in Casual members using the service this is belive to be mainly due to Tourist season in Chicago.
 
 ### Preferance of Ride Type
 Before Dec 2020 there was only two types of bikes were available Docked and Electric. After Dec2020 the company introduced Classic type of bikes .Lets analyse how this new introduction changed the riders preference. Following are the SQL query helped for this analysation.
 
 ```
 SELECT   rideable_type,member_casual,
          COUNT(*) AS 'Count',
          CAST(started_at AS DATE) AS 'DATE'
 FROM     [dbo].[Cycle_trip]
 WHERE    start_station_name IS NOT NULL
 GROUP BY CAST(started_at AS DATE),rideable_type,member_casual
 
 ````
 ![Ride_ttypes](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/Ride_Types.jpg)
 
 As we can see from the chart Classic bike being most preferable among both Casual and Subscription Riders . Also electric bike preferences increased ,however the Docked bike being the least prefered among riders . May be pricing flexibility and convenience made the Classic bike a success.
 
 ### Geolocation of the Ride 
 With the help of tableau, plotted a map showing the trend of ride within Casual and Anuual member riders. It showing that people usig the ride more in beach area ,there is a high trend of longer rides in beaches  compare to short range rides in the city area. This may be illustarting in cities people using bike as a commute to work.
 [Tableau](https://public.tableau.com/app/profile/shithul.m/viz/Cyclistic_map/Geo_location)
 ![Map](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/Geo_location.png)
 
 
 # Summary
 My Assignment was work with past data and finding how do annual members and casual riders use Cyclistic bikes differently. Most significant analysis we found are :
 
 1. Subscription Members are taking more number of trips than the Casual riders.
 2. Casual riders taking longer trip length while Subscription members take shorter rides.And from analysing the time in a day were trips are more active we found out working hours being the peak time for subscription members usage. This illustrate Subscription members using bikes as a primary commute for work.
 3. While analysing Weekend trends for ride ,Casual members are more acive than subscription members.
 4. No of rides totally depend upon the sesonal changes in Chicago .A significant drop in bike trips during the winter months and then bike trips increase as the weather gets warmer.
 5. There is a significant increase in casual members using the rides in June ,July, August and September this is belive to be because of the Tourists using this service in tourist seasons.
 6. After analysing the preferance of riders regarding Ride type . The Classic bike being most preferable among both Casual and Subscription Riders, while Docked bikes being the least .
 
 # Recommendations
 
 1. Since Weekends are the time Casual riders excessively using the service it is good to have marketing campaigns on those days.

 2. From the analysis it is so clear that on average the casual riders tend to take longer bike trips than members. So it will be so much better to change the price rating and give better offer such a way that motivate the casual riders for an upgrade. 
 
 3. Introduction of Mobile app will really helpfull for marketing as well as notifying  the users about any promotion or advertisements. If there is a loyalty point based promotion introduced ie, Annual members gaining loyalty point for each rides and this point can be redeemed as a freeride or extra discount .This will motivate the riders to have more rides as well as motivate the Casual members to upgrade.
 
 4. Since weekends are most favorable ride time for casual members , a weekend membership program can be introduced targeting the weekend riding Casual members.
 
 5. Our analysis illustrate both Classic and Electric bikes are favourable among riders .So better price plan and availability can be given to anual members such a way that motivates the Casual riders for an Upgrade. 
