CREATE OR ALTER PROCEDURE store_and_pull_service_information_json @json AS VARCHAR(MAX), @branch as VARCHAR(5)
AS
BEGIN
DECLARE @localjson AS VARCHAR(MAX), @localbranch AS VARCHAR(5)
SET @localjson = @json
SET @localbranch = @branch

BEGIN TRANSACTION;
BEGIN TRY
	DELETE FROM  service_information
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
	SELECT * FROM OPENJSON(@localjson)
	WITH(
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Earliest Time - Window 1] VARCHAR(50),
		[Latest Time - Window 1] VARCHAR(50),
		[Earliest Time - Window 2] VARCHAR(50),
		[Latest Time - Window 2] VARCHAR(50),
		[Outside Hours Access] VARCHAR(50),
		[Available Delivery Days] VARCHAR(50),
		[Average Stop Time] VARCHAR(50),
		[RSP StopTime Override] VARCHAR(50),
		[Service Notes] VARCHAR(MAX)
	)
	RETURN;
END CATCH

BEGIN TRANSACTION;
BEGIN TRY
	INSERT INTO service_information
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Earliest Time - Window 1] VARCHAR(50),
		[Latest Time - Window 1] VARCHAR(50),
		[Earliest Time - Window 2] VARCHAR(50),
		[Latest Time - Window 2] VARCHAR(50),
		[Outside Hours Access] VARCHAR(50),
		[Available Delivery Days] VARCHAR(50),
		[Average Stop Time] VARCHAR(50),
		[RSP StopTime Override] VARCHAR(50),
		[Service Notes] VARCHAR(MAX)
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
	SELECT * FROM OPENJSON(@localjson)
	WITH(
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Earliest Time - Window 1] VARCHAR(50),
		[Latest Time - Window 1] VARCHAR(50),
		[Earliest Time - Window 2] VARCHAR(50),
		[Latest Time - Window 2] VARCHAR(50),
		[Outside Hours Access] VARCHAR(50),
		[Available Delivery Days] VARCHAR(50),
		[Average Stop Time] VARCHAR(50),
		[RSP StopTime Override] VARCHAR(50),
		[Service Notes] VARCHAR(MAX)
	)
	RETURN;
END CATCH

Select 
	[cu_id],
	[Branch],
	[Earliest Time - Window 1],
	[Latest Time - Window 1],
	[Earliest Time - Window 2],
	[Latest Time - Window 2],
	[Outside Hours Access],
	[Available Delivery Days],
	[RSP StopTime Override],
	[Service Notes]
FROM service_information
Where [Branch] = @localbranch

END