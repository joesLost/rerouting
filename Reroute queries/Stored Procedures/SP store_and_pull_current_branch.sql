CREATE OR ALTER PROCEDURE store_and_pull_current_branch @branch VARCHAR(50)
AS
BEGIN

BEGIN TRANSACTION;
BEGIN TRY
	DELETE FROM  current_branch
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
	INSERT INTO current_branch
	VALUES(@branch)
	COMMIT TRANSACTION
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
Select *
FROM current_branch
END