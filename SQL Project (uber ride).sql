	create database rider;
	
	use rider;
	
	select * from pass;
	select * from dri;
	select * from rider;
	-- 1.           What are & how many unique pickup locations are there in the dataset?
			select count(distinct pickup_location) as pickup_loc from rider;
	-- 
	-- 2.           What is the total number of rides in the dataset?
					select count(total_rides) as Total_rides from pass; 
	-- 3.           Calculate the average ride duration.
	 select avg(ride_duration) as avg_ride from rider;
	-- 4.           List the top 5 drivers based on their total earnings.
	 select driver_name,driver_id, sum(earnings) as total_eaarning from dri
	group by driver_id, driver_name
	 order by total_eaarning desc limit 5;
	
	-- 5.           Calculate the total number of rides for each payment method.
		select payment_method, count(*) as total_rides  from rider
		group by payment_method ;
	-- 6.           Retrieve rides with a fare amount greater than 20.
	select * from rider
	where fare_amount>20;
				
	-- 7.           Identify the most common pickup location.
	 select pickup_location, count(*) as total_pickup from rider
	group by pickup_location
	order by total_pickup desc;
	-- 8.           Calculate the average fare amount.
	 select avg(fare_amount) from rider;
	-- 9.           List the top 10 drivers with the highest average ratings.
	select driver_id,driver_name, avg(rating) as avg_rating from dri
	group by driver_id , driver_name
	order by avg_rating  desc limit 10;
	-- 10.      Calculate the total earnings for all drivers.
	select driver_name, sum(earnings) from dri
	group by driver_name;
	-- 11.      How many rides were paid using the "Cash" payment method?
	 select count(*), payment_method from rider
	where payment_method = "cash";
	-- 12.      Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
	 select count(*) , avg(ride_distance) from rider
	where pickup_location = "Dhanbad";
	-- 13.      Retrieve rides with a ride duration less than 10 minutes.
	select * from rider
	where ride_duration <10;
	
	-- 14.      List the passengers who have taken the most number of rides.
	select * from pass 
	order by total_rides desc;
	-- 15.      Calculate the total number of rides for each driver in descending order.
				 select driver_name, count(*) as sum_ride from dri
				 group by driver_name
				 order by sum_ride desc;
	-- 16.      Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
	            select distinct payment_method from rider
				where pickup_location = "Gandhinagar";
				
	-- 17.      Calculate the average fare amount for rides with a ride distance greater than 10.
				select avg(fare_amount) as avg_amount, ride_distance from rider
				where ride_distance >10
				group by ride_distance;
	
	-- 18.      List the drivers in descending order accordinh to their total number of rides.
				select driver_name, total_rides from dri
				order by total_rides desc; 
	-- 19.      Calculate the percentage distribution of rides for each pickup location.
				SELECT pickup_location, COUNT(*) AS ride_count, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rider), 2) AS percentage 
				FROM rider
				GROUP BY pickup_location
				order by percentage desc;
	
	-- 20.      Retrieve rides where both pickup and dropoff locations are the same.
				select * from rider			
				where pickup_location = dropoff_location;
	-- 
	-- 
	-- Intermediate Level:     
	
	select * from pass;
	select * from dri;
	select * from rider;
	-- 1.           List the passengers who have taken rides from at least 300 different pickup locations.
	SELECT passenger_id, COUNT(DISTINCT pickup_location) AS distinct_locations
	FROM rider 
	GROUP BY passenger_id
	HAVING distinct_locations >= 300;
	-- 2.           Calculate the average fare amount for rides taken on weekdays.
	
	SELECT AVG(fare_amount)
	FROM rider 
	WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;
	-- 3.           Identify the drivers who have taken rides with distances greater than 19.
	select distinct driver_id, ride_distance from rider
	where ride_distance>=19;
	-- 4.           Calculate the total earnings for drivers who have completed more than 100 rides.
	select driver_id, total_rides,sum(earnings) as total_earninng from dri
	where driver_id in 
	group by driver_id;
	-- 5.           Retrieve rides where the fare amount is less than the average fare amount.
	select * from rider
	where fare_amount < (select avg(fare_amount) from rider);
	-- 6.           Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
	select avg(rating) as avg_rating from dri d
	join rider r on r.driver_id = d.driver_id
	group by d.driver_id
	having count(distinct r.payment_method) = 2
			and sum(case when r.payment_method = "Credit Card" then 1 else 0 end)>0
			and SUM(CASE WHEN r.payment_method = 'Cash' THEN 1 ELSE 0 END) > 0;
	-- 7.           List the top 3 passengers with the highest total spending.
	select passenger_id, sum(total_spent) as total_spent from pass
	group by passenger_id 
	order by total_spent desc limit 3;
	-- 8.           Calculate the average fare amount for rides taken during different months of the year.
	select extract (month from ride_timestamp) as month,
	ROUND(AVG(fare_amount), 2) AS average_fare from rider
	group by extract (month from ride_timestamp)
	order by month;
	-- 9.           Identify the most common pair of pickup and dropoff locations.
	select pickup_location, dropoff_location, count(*) as trip_count from rider
	group by pickup_location, dropoff_location 
	order by trip_count desc 
	limit 3;
	-- 10.      Calculate the total earnings for each driver and order them by earnings in descending order.
	select driver_name, sum(earnings) as total_ear from dri
	group by driver_name 
	order by total_ear desc
	limit 5;
	-- 11.      List the passengers who have taken rides on their signup date.
	SELECT p.passenger_id, p.passenger_name
	FROM pass p
	JOIN rider r ON p.passenger_id = r.passenger_id
	WHERE DATE(p.signup_date) = DATE(r.ride_timestamp);
	-- 12.      Calculate the average earnings for each driver and order them by earnings in descending order.
	select driver_id, avg(earnings) as avg_earning from dri
	group by driver_id 
	order by avg_earning  desc;
	-- 13.      Retrieve rides with distances less than the average ride distance.
	select  ride_id, avg(ride_distance) as avg_ride_distance from rider
	where ride_distance<(select avg(ride_distance) from rider)
	group by ride_id;
	-- 14.      List the drivers who have completed the least number of rides.
	select driver_name, count(driver_id) as rider_count from dri
	group by driver_name 
	order by rider_count  asc 
	limit 5;
	-- 15.      Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
	SELECT AVG(fare_amount)
	FROM rider 
	WHERE passenger_id IN (SELECT passenger_id FROM rider GROUP BY passenger_id HAVING COUNT(*) >= 20);
	-- 16.      Identify the pickup location with the highest average fare amount.
	select pickup_location, avg(fare_amount) as avg_fare_amount from rider
	group by pickup_location 
	order by avg_fare_amount  desc limit 5;
	-- 17.      Calculate the average rating of drivers who completed at least 100 rides.
	select driver_id,total_rides, avg(rating) as avg_rating from dri
	where total_rides >= 100
	group by driver_id, total_rides ;
	-- 18.      List the passengers who have taken rides from at least 5 different pickup locations.
	
	SELECT passenger_id, 
	COUNT(DISTINCT pickup_location) AS distinct_locations
	FROM rider
	GROUP BY passenger_id;
	
	-- 19.      Calculate the average fare amount for rides taken by passengers with ratings above 4.
	select avg(fare_amount) as avg_fare_amount from rider
	where passenger_id in (select passenger_id from pass
	where rating > 4);
	
	-- 20.      Retrieve rides with the shortest ride duration in each pickup location.
	select distinct pickup_location, min(ride_duration) as min_ride_duration from rider
	group by pickup_location;
	 
	-- Advanced Level:
	-- 1.           List the drivers who have driven rides in all pickup locations.
	SELECT driver_id
	FROM Dri
	WHERE driver_id NOT IN (
	    SELECT DISTINCT driver_id
	    FROM rider
	    WHERE pickup_location NOT IN (
	        SELECT DISTINCT pickup_location
	        FROM rider
	    )
	);
	-- 2.           Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
	select avg(fare_amount) as avg_fare_amount from rider
	where passenger_id  in (select passenger_id from pass
	where total_spent >300);
	-- 3.           List the bottom 5 drivers based on their average earnings.
	select driver_name, avg(earnings) as avg_earnings from dri
	group by driver_name
	order by avg_earnings asc limit 5;
	-- 4.           Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
	SELECT SUM(fare_amount)
	FROM rider 
	WHERE passenger_id IN (SELECT passenger_id FROM rider 
	GROUP BY passenger_id
	HAVING COUNT(DISTINCT payment_method) > 1);
	
	-- 5.           Retrieve rides where the fare amount is significantly above the average fare amount.
	select * from rider
	where fare_amount > (select avg(fare_amount)as avg_fair_amount from rider);
	-- 6.           List the drivers who have completed rides on the same day they joined.
	SELECT dc.driver_id, dc.driver_name
	FROM dri dc JOIN rider rdc
	ON dc.driver_id = rdc.driver_id
	WHERE dc.join_date = rdc.ride_timestamp;
	
	-- 7.           Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
	select  avg(fare_amount) as avg_fare_amount from rider
	where passenger_id in (select passenger_id from rider
							group by passenger_id
							having count(distinct payment_method) >1);
	-- 8.           Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.
	select pickup_location, avg(fare_amount) as avg_fare_amount, 
	(avg(fare_amount) - (select avg(fare_amount) from rider)) * 100/(select avg(fare_amount)) as percentage_increse
	from rider
	group by pickup_location
	order by  percentage_increse desc limit 5;
	-- 9.           Retrieve rides where the dropoff location is the same as the pickup location.
	select * from rider
	where dropoff_location  = pickup_location;
	-- 10.           Calculate the average rating of drivers who have driven rides with varying pickup locations.
	SELECT driver_id, AVG(rating) AS avg_rating
	FROM dri
	WHERE driver_id IN (
	    SELECT driver_id
	    FROM rider
	    GROUP BY driver_id
	    HAVING COUNT(DISTINCT pickup_location) > 1
	)
	GROUP BY driver_id;
	
	
