CREATE TABLE service_information (
	[cu_id] VARCHAR(50) PRIMARY KEY,
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
)