
CREATE OR ALTER PROCEDURE Alliant_Loop_Calculate_stop_times
AS
BEGIN
	DROP TABLE IF EXISTS [Reroute].[DBO].[Alliant_Time_Tracking_Information];
	DROP TABLE IF EXISTS [Reroute].[dbo].[tempStopTimes];

	CREATE TABLE [Reroute].[DBO].[Alliant_Time_Tracking_Information] (
		cu_id VARCHAR(50),
		Branch VARCHAR(50),
		[Current Route] VARCHAR(50),
		[Current Delivery Day] VARCHAR(50),
		[Frequency] VARCHAR(50),
		[Account] VARCHAR(50), 
		[Customer] VARCHAR(50), 
		[Customer Name] VARCHAR(50),
		[Date] VARCHAR(50),
		[Start Time] VARCHAR(50),
		[Stop Time] VARCHAR(50),
		[Calculated Time] VARCHAR(50),
		[Time Between Stops] VARCHAR(50),
	);

	DECLARE @branch_id VARCHAR(10), @date1 DATE, @date2 DATE, @routes VARCHAR(50)

	SELECT @branch_id = min([Branch Id]) 
	FROM [Reroute].[dbo].[control_parameters]-- Select the first (smallest) branch id in control parms

	WHILE @branch_id IS NOT NULL -- As long as we have a branch id do the following

	BEGIN

		SELECT @date1 = [Time Study Start], @date2 = [Time Study End], @routes = [Valid Routes]
		FROM [Reroute].[dbo].[control_parameters]
		WHERE [Branch Id] = @branch_id --Get the time study dates for our currently selected branch from control parms

		EXECUTE Calculate_Alliant_Stop_Times @branch_id, @date1, @date2, @routes -- leverage the alliant db to create our stop time information

		INSERT INTO Nightly_run_log ([Proc name],[DateTime],[Rows Affected])
		SELECT 
			OBJECT_NAME(@@PROCID),
			GETDATE(),
			@@ROWCOUNT

		INSERT INTO [Reroute].[DBO].[Alliant_Time_Tracking_Information]
		SELECT * FROM [Reroute].[dbo].[tempStopTimes]
		DROP TABLE [Reroute].[dbo].[tempStopTimes] -- #tempStopTimes is a temperary table created by the SP Calculate_Alliant_Stop_Times, once we have this info in our new table we drop this temp table

		SELECT @branch_id = min([Branch Id]) 
		FROM [Reroute].[dbo].[control_parameters]
		WHERE [Branch Id] > @branch_id -- Get the next smallest branch id and repeat


	END
		
END