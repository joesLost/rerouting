/* Alliant StopTimes query */
    SELECT
	ricustmr.cu_id,
	ricustmr.cu_branch [Branch],
	ricustmr.cu_route [Current Route],
	CASE WHEN cu_mon_route > 0 THEN 'M' ELSE '' END + 
	CASE WHEN cu_tue_route > 0 THEN 'T' ELSE '' END + 
	CASE WHEN cu_wed_route > 0 THEN 'W' ELSE '' END + 
	CASE WHEN cu_thu_route > 0 THEN 'R' ELSE '' END + 
	CASE WHEN cu_fri_route > 0 THEN 'F' ELSE '' END +
	CASE WHEN cu_sat_route > 0 THEN 'S' ELSE '' END +
	CASE WHEN cu_sun_route > 0 THEN 'U' ELSE '' END [Current Delivery Day],
	TRIM(ricustmr.cu_freq) [Frequency],
	ricustmr.cu_account [Account], 
	ricustmr.cu_dept [Customer], 
	ricustmr.cu_name [Customer Name],
    rainvhhd.hh_date [Date],
	CASE WHEN FORMAT(rainvhhd.hh_starttime, 'hh:mm:ss tt') <>'12:00:00 AM' AND FORMAT(rainvhhd.hh_stoptime, 'hh:mm:ss tt') <>'12:00:00 AM' THEN FORMAT(rainvhhd.hh_starttime, 'hh:mm:ss tt') ELSE 'NO TIME' END [Start Time], 
	CASE WHEN FORMAT(rainvhhd.hh_starttime, 'hh:mm:ss tt') <>'12:00:00 AM' AND FORMAT(rainvhhd.hh_stoptime, 'hh:mm:ss tt') <>'12:00:00 AM' THEN FORMAT(rainvhhd.hh_stoptime, 'hh:mm:ss tt') ELSE 'NO TIME' END [Stop Time],
	CAST(CAST((rainvhhd.hh_stoptime - rainvhhd.hh_starttime) AS Time) AS VARCHAR(50)) [Calculated Time],
	CASE WHEN ricustmr.cu_route = LAG(ricustmr.cu_route) OVER (ORDER BY cu_route,rainvhhd.hh_starttime) THEN CAST(CAST(CAST(rainvhhd.hh_starttime as datetime) - CAST(LAG(rainvhhd.hh_stoptime) OVER (ORDER BY cu_route, rainvhhd.hh_starttime) as datetime) AS Time) AS VARCHAR(50)) ELSE ' ' END [Time Between Stops]
FROM            
	rainvhhd INNER JOIN
	ricustmr ON rainvhhd.hh_cuid = ricustmr.cu_ID
WHERE			
	rainvhhd.hh_redtdt IS NULL
AND 
	cu_branch = @branch
AND 
	hh_date BETWEEN @date1 AND @date2
AND
    cu_route IN (SELECT value FROM STRING_SPLIT(@routes, ','))
ORDER BY
	cu_route, hh_stop,rainvhhd.hh_starttime