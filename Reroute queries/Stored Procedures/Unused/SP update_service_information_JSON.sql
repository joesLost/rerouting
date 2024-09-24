CREATE PROCEDURE update_service_information_json @json AS VARCHAR(MAX)

AS
BEGIN

MERGE service_information AS service
USING (SELECT *
FROM OPENJSON(@json)/*Convert JSON string to Tabular dataset*/
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
)) AS json
ON service.[cu_id]=json.[cu_id]
WHEN MATCHED THEN
UPDATE SET
    [Branch] =COALESCE(json.[Branch], service.[Branch]),
    [Earliest Time - Window 1] = COALESCE(json.[Earliest Time - Window 1], service.[Earliest Time - Window 1]),
    [Latest Time - Window 1] = COALESCE(json.[Latest Time - Window 1], service.[Latest Time - Window 1]),
    [Earliest Time - Window 2] = COALESCE(json.[Earliest Time - Window 2], service.[Earliest Time - Window 2]),
    [Latest Time - Window 2] = COALESCE(json.[Latest Time - Window 2], service.[Latest Time - Window 2]),
    [Outside Hours Access] = COALESCE(json.[Outside Hours Access], service.[Outside Hours Access]),
    [Available Delivery Days] = COALESCE(json.[Available Delivery Days], service.[Available Delivery Days]),
    [Average Stop Time] = COALESCE(json.[Average Stop Time], service.[Average Stop Time]),
    [RSP StopTime Override] = COALESCE(json.[RSP StopTime Override], service.[RSP StopTime Override]),
    [Service Notes] = COALESCE(json.[Service Notes], service.[Service Notes]);
END