CREATE OR ALTER PROCEDURE store_stop_times_json @json AS VARCHAR(MAX)
AS
BEGIN
DECLARE @localjson AS VARCHAR(MAX)
SET @localjson = @json

BEGIN TRANSACTION;
BEGIN TRY
	DELETE FROM  stop_times
	WHERE [cu_id] IN 
	(
		SELECT *
		FROM OPENJSON(@localjson)
		WITH (
			[cu_id] VARCHAR(50)
		)
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
END CATCH

BEGIN TRANSACTION;
BEGIN TRY
	INSERT INTO stop_times 
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Current Route] VARCHAR(50),
		[Account] VARCHAR(50),
		[Customer] VARCHAR(50),
		[Customer Name] VARCHAR(50),
		[Average Stop Time] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.1] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.2] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.3] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.4] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.5] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.6] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.7] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.8] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.9] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.10] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.11] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.12] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.13] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.14] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.15] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.16] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.17] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.18] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.19] VARCHAR(50),
		[Date :: Start / Stop :: StopTime :: TravelTime.20] VARCHAR(50)
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
END CATCH

SELECT * 
FROM stop_times

END