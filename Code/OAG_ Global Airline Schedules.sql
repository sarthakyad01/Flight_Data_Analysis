-- Total number of flights
SELECT COUNT(*) FROM OAG_SCHEDULE;

-- Number of unique carriers
SELECT COUNT(DISTINCT CARRIER) FROM OAG_SCHEDULE;

-- Airlines operating most flights
SELECT CARRIER, COUNT(*) as nums FROM OAG_SCHEDULE
GROUP BY CARRIER
ORDER BY nums DESC
LIMIT 1;

-- Departure Airport ranking by number of outbound flights
SELECT DEPAPT, COUNT(*) as nums FROM OAG_SCHEDULE
GROUP BY DEPAPT
ORDER BY nums DESC;

-- Arrival Airport ranking by number of inbound flights
SELECT ARRAPT, COUNT(*) as nums FROM OAG_SCHEDULE
GROUP BY ARRAPT
ORDER BY nums DESC;

-- Routes appearing most often
SELECT CONCAT(DEPAPT||'-'||ARRAPT) as route, COUNT(*) as nums FROM OAG_SCHEDULE
GROUP BY route
ORDER BY nums DESC;

-- Number of domestic and international flights
WITH vals AS (SELECT DOMINT, COUNT(*) as nums FROM OAG_SCHEDULE
WHERE DOMINT IN ('DD','II')
GROUP BY DOMINT)
SELECT DOMINT, nums, nums/(SELECT COUNT(*) FROM OAG_SCHEDULE) as prop FROM vals;

-- Airline offering the most seat capacity
SELECT CARRIER, ROUND(AVG(TOTAL_SEATS),0) as seat_cap
FROM OAG_SCHEDULE
WHERE TOTAL_SEATS IS NOT NULL
GROUP BY CARRIER
ORDER BY seat_cap DESC;

-- Routes by seat capacity
SELECT CONCAT(DEPAPT,'-',ARRAPT) as route, ROUND(AVG(TOTAL_SEATS),0) as seat_cap FROM OAG_SCHEDULE
WHERE TOTAL_SEATS IS NOT NULL
GROUP BY route
ORDER BY seat_cap DESC;

-- Aircraft types used most often
SELECT CARRIER, INPACFT, COUNT(INPACFT) as counter FROM OAG_SCHEDULE
GROUP BY CARRIER, INPACFT
ORDER BY counter DESC;

-- Average Elapsed time by route
SELECT CONCAT(DEPAPT, '-', ARRAPT) as route, AVG(ELPTIM) as time_spent
FROM OAG_SCHEDULE
GROUP BY route
ORDER BY time_spent DESC;

-- Countries generating the most outbound seat capacity
SELECT DEPCTRY, SUM(COALESCE(TOTAL_SEATS,0)) as seat_cap FROM OAG_SCHEDULE 
GROUP BY DEPCTRY 
ORDER BY seat_cap DESC;

-- Countries receiving the most inbound seat capacity
SELECT ARRCTRY, SUM(COALESCE(TOTAL_SEATS,0)) as seat_cap FROM OAG_SCHEDULE
GROUP BY ARRCTRY
ORDER BY seat_cap DESC;

-- Airline operating most international capacity
SELECT CARRIER, SUM(COALESCE(TOTAL_SEATS,0)) as seat_cap, COUNT(*) as num_flt
FROM OAG_SCHEDULE
WHERE DEPCTRY<>ARRCTRY
GROUP BY CARRIER
ORDER BY seat_cap DESC;

-- Airports which are strong hubs
WITH airport_activity AS (
    SELECT DEPAPT AS airport, COUNT(*) AS flights
    FROM OAG_SCHEDULE
    GROUP BY DEPAPT
    UNION ALL
    SELECT ARRAPT AS airport, COUNT(*) AS flights
    FROM OAG_SCHEDULE
    GROUP BY ARRAPT
)
SELECT
    airport,
    SUM(flights) AS total_airport_activity
FROM airport_activity
GROUP BY airport
ORDER BY total_airport_activity DESC;

-- Airlines dominating each route by seat share
WITH route_airline_capacity AS (
    SELECT
        DEPAPT || '-' || ARRAPT AS route,
        CARRIER,
        SUM(TOTAL_SEATS) AS seats
    FROM OAG_SCHEDULE
    GROUP BY 1, 2
),
ranked AS (
    SELECT
        route,
        CARRIER,
        seats,
        ROW_NUMBER() OVER (PARTITION BY route ORDER BY seats DESC) AS rn
    FROM route_airline_capacity
)
SELECT
    route,
    CARRIER,
    seats
FROM ranked
WHERE rn = 1
ORDER BY seats DESC;

-- High frequency routes with low seat share
SELECT
    DEPAPT || '-' || ARRAPT AS route,
    COUNT(*) AS flights,
    SUM(TOTAL_SEATS) AS total_seats,
    AVG(TOTAL_SEATS) AS avg_seats_per_flight
FROM OAG_SCHEDULE
GROUP BY 1
HAVING COUNT(*) >= 10
ORDER BY flights DESC, avg_seats_per_flight ASC;

-- Routes with low frequency but large aircraft
SELECT
    DEPAPT || '-' || ARRAPT AS route,
    COUNT(*) AS flights,
    AVG(TOTAL_SEATS) AS avg_seats_per_flight
FROM OAG_SCHEDULE
GROUP BY 1
HAVING COUNT(*) >= 3
ORDER BY avg_seats_per_flight DESC, flights ASC;

-- Network of airlines across countries
SELECT
    CARRIER,
    DEPCTRY,
    COUNT(*) AS flights,
    SUM(TOTAL_SEATS) AS seats
FROM OAG_SCHEDULE
GROUP BY CARRIER, DEPCTRY
ORDER BY CARRIER, seats DESC;

-- Longest routes by distance
SELECT
    DEPAPT || '-' || ARRAPT AS route,
    CARRIER,
    DISTANCE,
    ELPTIM,
    TOTAL_SEATS
FROM OAG_SCHEDULE
ORDER BY DISTANCE DESC
LIMIT 50;

-- Seat mix by cabin class across network of flights
SELECT
    SUM(FIRST_CLASS_SEATS) AS first_class_seats,
    SUM(BUSINESS_CLASS_SEATS) AS business_class_seats,
    SUM(PREMIUM_ECONOMY_CLASS_SEATS) AS premium_economy_seats,
    SUM(ECONOMY_PLUS_CLASS_SEATS) AS economy_plus_seats,
    SUM(ECONOMY_CLASS_SEATS) AS economy_class_seats,
    SUM(TOTAL_SEATS) AS total_seats
FROM OAG_SCHEDULE;

-- Airlines providing highest share of premium seats
SELECT
    CARRIER,
    SUM(FIRST_CLASS_SEATS + BUSINESS_CLASS_SEATS + PREMIUM_ECONOMY_CLASS_SEATS) AS premium_seats,
    SUM(TOTAL_SEATS) AS total_seats,
    ROUND(
        100.0 * SUM(FIRST_CLASS_SEATS + BUSINESS_CLASS_SEATS + PREMIUM_ECONOMY_CLASS_SEATS)
        / NULLIF(SUM(TOTAL_SEATS), 0),
        2
    ) AS premium_seat_share_pct
FROM OAG_SCHEDULE
GROUP BY CARRIER
ORDER BY premium_seat_share_pct DESC;

-- Airlines using widest variety of aircraft
SELECT
    CARRIER,
    COUNT(DISTINCT INPACFT) AS aircraft_type_count
FROM OAG_SCHEDULE
GROUP BY CARRIER
ORDER BY aircraft_type_count DESC;
