CREATE OR ALTER PROCEDURE delete_rev_analysis_json @json AS VARCHAR(MAX)
AS
BEGIN

BEGIN TRANSACTION
BEGIN TRY
	DELETE FROM  revenue_analysis
	WHERE [cu_id] IN 
	(
		SELECT *
		FROM OPENJSON(@json)
		WITH (
			[cu_id] VARCHAR(50)
		)
	)
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
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

END