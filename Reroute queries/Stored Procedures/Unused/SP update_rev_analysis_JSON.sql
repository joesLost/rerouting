CREATE PROCEDURE update_rev_analysis_json @json AS VARCHAR(MAX)
/*
Example JSON:
[{"cu_id":"10","Cust #":"00000","Cust Name":null,"Tue Stop Seq":null,"Frequency":null,"# of Assigned Garments":null,"Garment Inventory":null,"# of Wearers":null,"Mon Stop Seq":null,"Wed Stop Seq":null,"Street Address 1":null,"Current Delivery Day":null,"Current Rt #":null,"Fri Stop Seq":null,"Acct #":null,"Street Address 2":null,"City":null,"State":null,"Zip":null,"Thu Stop Seq":null}]
Note null values, these are columns that did not change (Alliant vs Reroute Db) 
*/
AS
BEGIN

MERGE revenue_analysis AS rev
USING (SELECT *
FROM OPENJSON(@json)/*Convert JSON string to Tabular dataset*/
WITH (
    [cu_id] VARCHAR(50),
	[Q1 Average] VARCHAR(50),
	[Q1 Average Deviation] VARCHAR(50),
	[Q1 High Deviation] VARCHAR(50),
	[Q1 Low Deviation] VARCHAR(50),
	[Q2 Average] VARCHAR(50),
	[Q2 Average Deviation] VARCHAR(50),
	[Q2 High Deviation] VARCHAR(50),
	[Q2 Low Deviation] VARCHAR(50),
	[Q3 Average] VARCHAR(50),
	[Q3 Average Deviation] VARCHAR(50),
	[Q3 High Deviation] VARCHAR(50),
	[Q3 Low Deviation] VARCHAR(50),
	[Q4 Average] VARCHAR(50),
	[Q4 Average Deviation] VARCHAR(50),
	[Q4 High Deviation] VARCHAR(50),
	[Q4 Low Deviation] VARCHAR(50)
)) AS json
ON rev.[cu_id]=json.[cu_id]
WHEN MATCHED THEN
UPDATE SET
	rev.[Q1 Average] = COALESCE(json.[Q1 Average], rev.[Q1 Average]),
	rev.[Q1 Average Deviation] = COALESCE(json.[Q1 Average Deviation], rev.[Q1 Average Deviation]),
	rev.[Q1 High Deviation] = COALESCE(json.[Q1 High Deviation], rev.[Q1 High Deviation]),
	rev.[Q1 Low Deviation] = COALESCE(json.[Q1 Low Deviation], rev.[Q1 Low Deviation]),
	rev.[Q2 Average] = COALESCE(json.[Q2 Average], rev.[Q2 Average]),
	rev.[Q2 Average Deviation] = COALESCE(json.[Q2 Average Deviation], rev.[Q2 Average Deviation]),
	rev.[Q2 High Deviation] = COALESCE(json.[Q2 High Deviation], rev.[Q2 High Deviation]),
	rev.[Q2 Low Deviation] = COALESCE(json.[Q2 Low Deviation], rev.[Q2 Low Deviation]),
	rev.[Q3 Average] = COALESCE(json.[Q3 Average], rev.[Q3 Average]),
	rev.[Q3 Average Deviation] = COALESCE(json.[Q3 Average Deviation], rev.[Q3 Average Deviation]),
	rev.[Q3 High Deviation] = COALESCE(json.[Q3 High Deviation], rev.[Q3 High Deviation]),
	rev.[Q3 Low Deviation] = COALESCE(json.[Q3 Low Deviation], rev.[Q3 Low Deviation]),
	rev.[Q4 Average] = COALESCE(json.[Q4 Average], rev.[Q4 Average]),
	rev.[Q4 Average Deviation] = COALESCE(json.[Q4 Average Deviation], rev.[Q4 Average Deviation]),
	rev.[Q4 High Deviation] = COALESCE(json.[Q4 High Deviation], rev.[Q4 High Deviation]),
	rev.[Q4 Low Deviation] = COALESCE(json.[Q4 Low Deviation], rev.[Q4 Low Deviation]);
END