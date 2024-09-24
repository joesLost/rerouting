CREATE OR ALTER PROCEDURE store_and_pull_control_parameters_json @json AS VARCHAR(MAX)
AS
DECLARE @localjson AS VARCHAR(MAX)
SET @localjson = @json
BEGIN

BEGIN TRY
	BEGIN TRANSACTION
	DELETE FROM  control_parameters
	WHERE [Branch Id] IN 
	(
		SELECT *
		FROM OPENJSON(@localjson)
		WITH (
			[Branch Id] VARCHAR(5)
		)
	)

	INSERT INTO control_parameters
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[Branch Id] VARCHAR(5),
		[Branch] VARCHAR(50),
		[Valid Routes] VARCHAR(MAX),
		[Current Iteration] VARCHAR(50),
		[GO-Live Date] DATE,
		[Time Study Start] DATE,
		[Time Study End] DATE,
		[Go-Live Week Code] VARCHAR(5)
	)
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
FROM control_parameters
END