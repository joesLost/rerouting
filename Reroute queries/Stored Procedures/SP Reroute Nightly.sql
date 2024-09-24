USE Reroute
GO
CREATE OR ALTER PROCEDURE Reroute_Nightly
AS
BEGIN

	EXECUTE [Reroute].[DBO].Alliant_Loop_Calculate_stop_times;
	EXECUTE [Reroute].[DBO].Alliant_Customer_Listing_Reroute_Table;
	EXECUTE [Reroute].[DBO].Alliant_Reroute_Revenue_Table;

END