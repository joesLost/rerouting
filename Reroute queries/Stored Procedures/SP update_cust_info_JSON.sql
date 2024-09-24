CREATE OR ALTER PROCEDURE update_cust_info_json @json AS VARCHAR(MAX)
/*
Example JSON:
[{"cu_id":"10","Cust #":"00000","Cust Name":null,"Tue Stop Seq":null,"Frequency":null,"# of Assigned Garments":null,"Garment Inventory":null,"# of Wearers":null,"Mon Stop Seq":null,"Wed Stop Seq":null,"Street Address 1":null,"Current Delivery Day":null,"Current Rt #":null,"Fri Stop Seq":null,"Acct #":null,"Street Address 2":null,"City":null,"State":null,"Zip":null,"Thu Stop Seq":null}]
Note null values, these are columns that did not change (Alliant vs Reroute Db) 
*/
AS
BEGIN
DECLARE @localjson AS VARCHAR(MAX)
SET @localjson = @json

BEGIN TRANSACTION;
BEGIN TRY
	MERGE customer_information AS cust
	USING (SELECT *
	FROM OPENJSON(@localjson)/*Convert JSON string to Tabular dataset*/
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
	[Garment Underwash] DECIMAL(5,4),
	[Average Weekly Garment Soil Scans] VARCHAR(50),
	[Wearer Count] VARCHAR(50),
	[Total Assigned Garments] VARCHAR(50),
	[Hold/Seasonal] VARCHAR(50)
	)) AS json
	ON cust.[cu_id]=json.[cu_id]
	WHEN MATCHED THEN
	UPDATE SET
	cust.[Branch] = COALESCE(json.[Branch], cust.[Branch]),
	cust.[Current Route] = COALESCE(json.[Current Route],cust.[Current Route]),
	cust.[Current Delivery Day] = COALESCE(json.[Current Delivery Day], cust.[Current Delivery Day]),
	cust.[Account] = COALESCE(json.[Account], cust.[Account]),
	cust.[Customer] = COALESCE(json.[Customer], cust.[Customer]),
	cust.[Customer Name] = COALESCE(json.[Customer Name], cust.[Customer Name]),
	cust.[Street Address 1] = COALESCE(json.[Street Address 1], cust.[Street Address 1]),
	cust.[Street Address 2] = COALESCE(json.[Street Address 2], cust.[Street Address 2]),
	cust.[City] = COALESCE(json.[City], cust.[City]),
	cust.[State] = COALESCE(json.[State], cust.[State]),
	cust.[Zip] = COALESCE(json.[Zip], cust.[Zip]),
	cust.[Frequency] = COALESCE(json.[Frequency], cust.[Frequency]),
	cust.[Stop] = COALESCE(json.[Stop], cust.[Stop]),
	cust.[Invoice Count] = COALESCE(json.[Invoice Count], cust.[Invoice Count]),
	cust.[Garment Inventory] = COALESCE(json.[Garment Inventory], cust.[Garment Inventory]),
	cust.[Average Weekly Garment Soil Scans] = COALESCE(json.[Average Weekly Garment Soil Scans], cust.[Average Weekly Garment Soil Scans]),
	cust.[Wearer Count] = COALESCE(json.[Wearer Count], cust.[Wearer Count]),
	cust.[Total Assigned Garments] = COALESCE(json.[Total Assigned Garments], cust.[Total Assigned Garments]),
	cust.[Hold/Seasonal] = COALESCE(json.[Hold/Seasonal], cust.[Hold/Seasonal]);
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