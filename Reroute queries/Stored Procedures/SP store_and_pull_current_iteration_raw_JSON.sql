USE Reroute
GO
CREATE OR ALTER PROCEDURE store_and_pull_current_iteration_raw_json @json AS VARCHAR(MAX)
AS
DECLARE @localjson AS VARCHAR(MAX)
SET @localjson = @json
BEGIN

BEGIN TRANSACTION;
BEGIN TRY
	DELETE FROM  current_iteration_raw
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	Insert into Errortable (ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage, ErrorTime)
		Values (
			ERROR_NUMBER()  
			,ERROR_SEVERITY()   
			,ERROR_STATE() 
			,ERROR_PROCEDURE()  
			,ERROR_LINE()
			,ERROR_MESSAGE()
			,CURRENT_TIMESTAMP
	)
	RETURN
END CATCH

BEGIN TRANSACTION;
BEGIN TRY
	INSERT INTO current_iteration_raw
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Account] VARCHAR(50),
		[Customer] VARCHAR(50),
		[Week] VARCHAR(50),
		[New Route] VARCHAR(50),
		[New Delivery Day] VARCHAR(50),
		[New Stop] VARCHAR(50),
		[Old Route] VARCHAR(50),
		[Old Delivery Day] VARCHAR(50),
		[Old Stop] VARCHAR(50),
		[Customer Name] VARCHAR(50),
		[Frequency] VARCHAR(50),
		[Address] VARCHAR(50),
		[X_Longitude] VARCHAR(50),
		[Y_Latitude] VARCHAR(50),
		[Garment Inventory] VARCHAR(50),
		[Wearer Count] VARCHAR(50),
		[Total Assigned Garments] VARCHAR(50),
		[Average Weekly Garment Soil Scans] VARCHAR(50),
		[Garment Underwash] VARCHAR(50),
		[Invoice Count] VARCHAR(50),
		[Q1 Average] money,
		[Q1 Weighted] money,
		[Q1 Low Deviation] money,
		[Q1 High Deviation] money,
		[Q2 Average] money,
		[Q2 Weighted] money,
		[Q2 Low Deviation] money,
		[Q2 High Deviation] money,
		[Q3 Average] money,
		[Q3 Weighted] money,
		[Q3 Low Deviation] money,
		[Q3 High Deviation] money,
		[Q4 Average] money,
		[Q4 Weighted] money,
		[Q4 Low Deviation] money,
		[Q4 High Deviation] money,
		[Service Notes] VARCHAR(MAX),
		[Earliest Time - Window 1] VARCHAR(50),
		[Latest Time - Window 1] VARCHAR(50),
		[Earliest Time - Window 2] VARCHAR(50),
		[Latest Time - Window 2] VARCHAR(50),
		[Outside Hours Access] VARCHAR(50),
		[Available Delivery Days] VARCHAR(50),
		[MilesFromPrevious] VARCHAR(50),
		[Service Minutes] VARCHAR(50),
		[MinutesFromPrevious] VARCHAR(50),
		[Wait Minutes] VARCHAR(50),
		[Estimated Arrival] VARCHAR(50),
		[Estimated Departure] VARCHAR(50),
		[Is Route Changing] VARCHAR(50),
		[Is Day Changing] VARCHAR(50),
		[Is new Day feasible?] VARCHAR(50),
		[Retape Needed?] VARCHAR(50),
		[Hold/Seasonal] VARCHAR(50)
	)
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	Insert into Errortable (ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage, ErrorTime)
		Values (
			ERROR_NUMBER()  
			,ERROR_SEVERITY()   
			,ERROR_STATE() 
			,ERROR_PROCEDURE()  
			,ERROR_LINE()
			,ERROR_MESSAGE()
			,CURRENT_TIMESTAMP
	)
	RETURN
END CATCH

Select 
	*
FROM current_iteration_raw;

RETURN;
END