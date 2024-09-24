CREATE OR ALTER PROCEDURE store_rev_analysis_json @json AS VARCHAR(MAX)
AS
BEGIN
DECLARE @localjson AS VARCHAR(MAX)
SET @localjson = @json

BEGIN TRANSACTION;
BEGIN TRY

	DELETE FROM  revenue_analysis
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
	INSERT INTO revenue_analysis 
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Q1 Average] MONEY,
		[Q1 Average Deviation] MONEY,
		[Q1 High Deviation] MONEY,
		[Q1 Low Deviation] MONEY,
		[Q2 Average] MONEY,
		[Q2 Average Deviation] MONEY,
		[Q2 High Deviation] MONEY,
		[Q2 Low Deviation] MONEY,
		[Q3 Average] MONEY,
		[Q3 Average Deviation] MONEY,
		[Q3 High Deviation] MONEY,
		[Q3 Low Deviation] MONEY,
		[Q4 Average] MONEY,
		[Q4 Average Deviation] MONEY,
		[Q4 High Deviation] MONEY,
		[Q4 Low Deviation] MONEY
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
END