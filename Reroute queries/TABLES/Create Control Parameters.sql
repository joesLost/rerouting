CREATE TABLE control_parameters (
	[Branch Id] VARCHAR(5) PRIMARY KEY,
	[Branch] VARCHAR(50),
	[Valid Routes] VARCHAR(MAX),
	[Current Iteration] VARCHAR(50),
	[GO-Live Date] DATE,
	[Time Study Start] DATE,
	[Time Study End] DATE
)