/*Alliant Revenue Query*/
CREATE OR ALTER PROCEDURE Alliant_Reroute_Revenue_Table
AS
BEGIN
	DROP TABLE IF EXISTS [Reroute].[DBO].Alliant_Raw_Revenue;
	DECLARE @65WeekBegin date, @65WeekEnd date
	SET @65WeekBegin = DATEADD(WEEK, -65, CURRENT_TIMESTAMP)
	SET @65WeekEnd = CURRENT_TIMESTAMP

	SELECT			hh_cuid [cu_id],
					hh_branch [Branch],
					hh_route [Current Route],
					REPLACE(TRIM(hh_deldays), 'H', 'R') [Current Delivery Day],
					TRIM(hh_freq) [Frequency],
					hh_date [Invoice Date], 
					hh_invoice [Invoice #],
					[Alliant].[DBO].ipcfn_inv_ttl(hh_invoice, hh_date, 0, 1) [Revenue]

	INTO			[Reroute].[DBO].Alliant_Raw_Revenue

	FROM			[Alliant].[DBO].rainvhhd INNER JOIN 
					[Alliant].[DBO].ricustmr
					ON rainvhhd.hh_cuid = ricustmr.cu_ID
	WHERE			hh_date BETWEEN @65WeekBegin AND @65WeekEnd
					AND rainvhhd.hh_redtdt IS NULL
					AND cu_stopdt = '1/1/1900'
	ORDER BY		hh_cuid, hh_date, hh_invoice


	INSERT INTO Nightly_run_log ([Proc name],[DateTime],[Rows Affected])
		SELECT 
			OBJECT_NAME(@@PROCID),
			GETDATE(),
			@@ROWCOUNT
END