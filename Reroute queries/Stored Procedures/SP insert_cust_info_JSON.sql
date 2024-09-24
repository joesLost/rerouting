CREATE OR ALTER PROCEDURE insert_cust_info_json @json AS VARCHAR(MAX)
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
	return;
END CATCH

BEGIN TRANSACTION;
BEGIN TRY
	INSERT INTO customer_information 
	SELECT *
	FROM OPENJSON(@localjson)
	WITH (
	[cu_id] VARCHAR(50),
	[Branch] VARCHAR(50),
	[Current Route] VARCHAR(50),
	[Current Delivery Day] VARCHAR(50),
	[Account] VARCHAR(50),
	[Customer] VARCHAR(50),
	[Customer Name] VARCHAR(50),
	[Street Address 1] VARCHAR(50),
	[Street Address 2] VARCHAR(50),
	[City] VARCHAR(50),
	[State] VARCHAR(50),
	[Zip] VARCHAR(50),
	[Frequency] VARCHAR(50),
	[Stop] VARCHAR(50),
	[Invoice Count] VARCHAR(50),
	[Garment Inventory] VARCHAR(50),
	[Garment Underwash] VARCHAR(50),
	[Average Weekly Garment Soil Scans] VARCHAR(50),
	[Wearer Count] VARCHAR(50),
	[Total Assigned Garments] VARCHAR(50),
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
	Return;
END CATCH
END