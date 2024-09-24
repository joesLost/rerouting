CREATE OR ALTER PROCEDURE delete_cust_info_json @json AS VARCHAR(MAX)
AS
BEGIN
DECLARE @localjson AS VARCHAR(MAX)
SET @localjson = @json

BEGIN TRANSACTION;
BEGIN TRY
	DELETE FROM  customer_information
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
	RETURN
END CATCH
BEGIN TRANSACTION
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
BEGIN TRANSACTION
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
BEGIN TRANSACTION
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