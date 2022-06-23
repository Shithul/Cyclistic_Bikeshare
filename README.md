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
 SELECT DATEPART(hour, started_at) AS 'Hour', COUNT(*) AS 'Count',member_casual
 FROM[dbo].[Cycle_trip]
 WHERE start_station_name IS NOT NULL
 GROUP BY DATEPART(hour, started_at), member_casual
 ORDER BY DATEPART(hour, started_at)
``` 
 ![Avg_NoOf_RidesPerDay](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/AVG_No_of_RidesPerDay.jpg)
 
This chart illustrating the Subscription members are more frequently using the service in a day, were evening 5 o Clock being the peak time for both casual as well as subscrition members. From the graph it is understandable that the subscription members usage is mainly focused on the working hours in a day. After 5 o clock subscription members usage significantly decreases.We can summarise that most of the subscription members using bike as a main commute for work. 

### Average Trip Duration by riders Weekly
To analyze and visualize the average Trip Duration weekly for casual and member riders, we used the results from this SQL statement to create the visualization 

![Avg_trip](https://github.com/Shithul/Cyclistic_Bikeshare/blob/main/AVG_TripDuration_PerWeek.jpg)

