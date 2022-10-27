SELECT ride_length
FROM Cyclistic..may2022_trip_data



ALTER TABLE Cyclistic..sep2022_trip_data
ALTER COLUMN ride_length ntext;


SELECT TOP 10 ride_length
FROM Cyclistic..may2022_trip_data ORDER BY DESC


--Merge tables into one
--Insert first table, August

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..aug2022_trip_data

--Verify if table is inserted

SELECT COUNT (ride_id)
FROM Cyclistic..sep2022_trip_data

--Insert July

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..jul2022_trip_data

--Inset June

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..jun2022_trip_data

--Insert May 2022

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..may2022_trip_data

--Insert April 2022

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..apr2022_trip_data

--Insert March 2022

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..mar2022_trip_data

--Insert February 2022

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..feb2022_trip_data

--Insert January 2022

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..jan2022_trip_data

--Insert December 2021

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..dec2021_trip_data

--Insert November 2021

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..nov2021_trip_data

--Insert October 2021

INSERT INTO Cyclistic..sep2022_trip_data
SELECT *
FROM Cyclistic..oct2021_trip_data


SELECT TOP (100) [ride_id]
      ,[rideable_type]
      ,[started_at]
      ,[ended_at]
      ,[ride_length]
      ,[day_of_week]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
  FROM [Cyclistic].[dbo].[sep2022_trip_data]


  --Modify Data Type in Ride_length column and make it uniform

  SELECT TOP 10 (ride_length) 
FROM Cyclistic..sep2022_trip_data


ALTER TABLE Cyclistic..sep2022_trip_data
DROP COLUMN ride_length


SELECT 
 ride_id,
 started_at,
 ended_at,
 CONVERT(decimal, datediff (minute, started_at, ended_at))
 FROM Cyclistic..sep2022_trip_data

 SELECT TOP 10
  started_at,
  ended_at,
 CONVERT(smalldatetime, datediff (minute, started_at, ended_at), 108) as trip_duration
 FROM Cyclistic..sep2022_trip_data


  SELECT TOP 10
  started_at,
  ended_at,
  CONVERT(varchar, ride_length, 8),
 CONVERT(varchar, datediff (minute, started_at, ended_at), 108) as trip_duration
 FROM Cyclistic..sep2022_trip_data

   SELECT TOP 10
  started_at,
  ended_at,
  TRY_CONVERT(varchar, ride_length, 8), 
 CONVERT(varchar, datediff (minute, started_at, ended_at), 8) as trip_duration
 FROM Cyclistic..sep2022_trip_data

 


 SELECT TOP 100 *
 FROM Cyclistic..sep2022_trip_data

 SELECT CAST(ride_length AS nvarchar) AS  ride_length
 FROM Cyclistic..sep2022_trip_data

  SELECT (ride_length AS decimal) AS  ride_length
 FROM Cyclistic..sep2022_trip_data

 
 --Add new column called ride length from the difference of ended_at and started_at, as Time

 ALTER TABLE Cyclistic..TripData2
 ADD trip_hour int;

 --Create Table named Trip_Info

 CREATE TABLE TripData2
 (	   [ride_id] nvarchar (50) not null
      ,[rideable_type] nvarchar (50) null
      ,[started_at] datetime
      ,[ended_at] datetime
      ,[ride_length] int null
      ,[day_of_week] int null 
      ,[start_station_name] nvarchar(100) null
      ,[start_station_id] nvarchar (50) null
      ,[end_station_name] nvarchar(100) null
      ,[end_station_id] nvarchar (50) null
      ,[start_lat] float null
      ,[start_lng] float null
      ,[end_lat] float null
      ,[end_lng] float null
      ,[member_casual] nvarchar (50) null
)

 SELECT TOP 100 *
 FROM Cyclistic..TripData2


SELECT ROWCOUNT_BIG ()

 INSERT INTO Cyclistic..TripData2
 (	   [ride_id]
	  ,[rideable_type]
      ,[started_at]
      ,[ended_at]
	  ,[trip_hour]
      ,[ride_length]
      ,[day_of_week]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
 )
 SELECT 

      [ride_id]
	  ,[rideable_type]
      ,[started_at]
      ,[ended_at]
	  ,DATEPART(hour, started_at) AS trip_hour
      ,datediff(minute, started_at, ended_at) as [ride_length]
      ,[day_of_week]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
 FROM Cyclistic..sep2022_trip_data
  
SELECT ROWCOUNT_BIG ()

--Delete Nulls in Table

  SELECT Count(*)
 FROM Cyclistic..TripData2
  WHERE ride_id is Null


  SELECT ride_id, Count(*)
 FROM Cyclistic..TripData
 GROUP BY ride_id
 HAVING Count(*) > 1

DELETE FROM Cyclistic..TripData
 WHERE ride_id is Null

 DELETE FROM Cyclistic..Trip_Info
 WHERE ride_id is Null

-- Verifying that I created the correct table



SELECT DISTINCT 
 	   [ride_id]
	  ,[rideable_type]
      ,[started_at]
      ,[ended_at]
      ,[ride_length]
      ,[day_of_week]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
FROM Trip_Info
ORDER BY started_at


--Creating a view 
 
CREATE VIEW ViewTripData
 AS 
 SELECT  
 	   [ride_id]
	  ,[rideable_type]
      ,[started_at]
      ,[ended_at]
	  ,DATEPART(hour, started_at) AS trip_hour
      ,[ride_length]
      ,[day_of_week]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
FROM TripData



--View Created View


 SELECT TOP 100 *
 FROM Cyclistic..ViewTripData

 --Convert Started_at to hour-Datepart 

 SELECT  
DATEPART(hour, started_at) AS trip_hour
 FROM Cyclistic..TripData

