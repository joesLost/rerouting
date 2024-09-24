CREATE OR ALTER PROCEDURE store_and_pull_alliant_sequences_json @json AS VARCHAR(MAX), @branch as VARCHAR(5)
AS
BEGIN
DECLARE @localjson AS VARCHAR(MAX), @localbranch AS VARCHAR(5)
SET @localjson = @json
SET @localbranch = @branch

BEGIN TRANSACTION;
BEGIN TRY
	DELETE FROM  sequence_dictionary
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
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Alliant Sequence] VARCHAR(50)
	)
	RETURN;
END CATCH

BEGIN TRANSACTION
BEGIN TRY
	INSERT INTO sequence_dictionary
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Alliant Sequence] VARCHAR(50)
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
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
		[cu_id] VARCHAR(50),
		[Branch] VARCHAR(50),
		[Alliant Sequence] VARCHAR(50)
	)
	RETURN;
END CATCH

Select 
	[cu_id],
	[Branch],
	[Alliant Sequence]

FROM sequence_dictionary
Where [Branch] = @localbranch
END