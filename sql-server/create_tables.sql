create table DimBroker (
	SK_BrokerID int NOT NULL PRIMARY KEY,
	BrokerID int NOT NULL,
	ManagerID int,
	FirstName char(50) NOT NULL,
	LastName char(50) NOT NULL,
	MiddleInitial char(1),
	Branch char(50),
	Office char(50),
	Phone char(14),
	IsCurrent bit NOT NULL,
	BatchID numeric(5) NOT NULL,
	EffectiveDate date NOT NULL,
	EndDate date NOT NULL
);

create table DimCompany (
	SK_CompanyID int NOT NULL PRIMARY KEY,
	CompanyID int NOT NULL,
	Status char(10) NOT NULL, 
	Name char(60) NOT NULL,
	Industry char(50) NOT NULL,
	SPrating char(4),
	isLowGrade bit,
	CEO char(100) NOT NULL,
	AddressLine1 varchar(80),
	AddressLine2 varchar(80),
	PostalCode char(12) NOT NULL,
	City char(25) NOT NULL,
	StateProv char(20) NOT NULL,
	Country char(24),
	Description varchar(150) NOT NULL,
	FoundingDate DATE,
	IsCurrent bit NOT NULL,
	BatchID numeric(5) NOT NULL,
	EffectiveDate DATE NOT NULL,
	EndDate DATE NOT NULL
);

create table DimCustomer (
	SK_CustomerID int NOT NULL PRIMARY KEY,
	CustomerID int NOT NULL,
	TaxID char(20) NOT NULL,
	Status char(10) NOT NULL,
	LastName char(30) NOT NULL,
	FirstName char(30) NOT NULL,
	MiddleInitial char(1),
	Gender char(1),
	Tier numeric(1),
	DOB date NOT NULL,
	AddressLine1 varchar(80) NOT NULL,
	AddressLine2 varchar(80),
	PostalCode char(12) NOT NULL,
	City char(25) NOT NULL,
	StateProv char(20) NOT NULL,
	Country char(24),
	Phone1 char(30),
	Phone2 char(30),
	Phone3 char(30),
	Email1 char(50),
	Email2 char(50),
	NationalTaxRateDesc varchar(50),
	NationalTaxRate numeric(6,5),
	LocalTaxRateDesc varchar(50),
	LocalTaxRate numeric(6,5),
	AgencyID char(30),
	CreditRating numeric(5),
	NetWorth numeric(10),
	MarketingNameplate char(100),
	IsCurrent bit NOT NULL,
	BatchID numeric(5) NOT NULL,
	EffectiveDate date NOT NULL,
	EndDate date NOT NULL
);

create table DimAccount (
	SK_AccountID int PRIMARY KEY NOT NULL IDENTITY(1, 1),
	AccountID int NOT NULL,
	SK_BrokerID int NOT NULL,
	SK_CustomerID int NOT NULL,
	Status char(10) NOT NULL,
	AccountDesc char(50),
	TaxStatus numeric(1),
	IsCurrent bit NOT NULL,
	BatchID numeric(5) NOT NULL,
	EffectiveDate date NOT NULL,
	EndDate date NOT NULL,
	CONSTRAINT CK_DimAccount_TaxStatus
		CHECK (TaxStatus = 0 or TaxStatus = 1 or TaxStatus = 2),
	CONSTRAINT FK_DimAccount_BrokerID FOREIGN KEY (SK_BrokerID)
		REFERENCES DimBroker(SK_BrokerID),
	CONSTRAINT FK_DimAccount_CustomerID FOREIGN KEY (SK_CustomerID)
		REFERENCES DimCustomer(SK_CustomerID)
);

create table DimDate (
	SK_DateID int NOT NULL PRIMARY KEY,
	DateValue date NOT NULL,
	DateDesc char(20) NOT NULL,
	CalendarYearID numeric(4) NOT NULL,
	CalendarYearDesc char(20) NOT NULL,
	CalendarQtrID numeric(5) NOT NULL,
	CalendarQtrDesc char(20) NOT NULL,
	CalendarMonthID numeric(6) NOT NULL,
	CalendarMonthDesc char(20) NOT NULL,
	CalendarWeekID numeric(6) NOT NULL,
	CalendarWeekDesc char(20) NOT NULL,
	DayOfWeekNum numeric(1) NOT NULL,
	DayOfWeekDesc char(10) NOT NULL,
	FiscalYearID numeric(4) NOT NULL,
	FiscalYearDesc char(20) NOT NULL,
	FiscalQtrID numeric(5) NOT NULL,
	FiscalQtrDesc char(20) NOT NULL,
	HolidayFlag bit
);

create table DimSecurity (
	SK_SecurityID int NOT NULL PRIMARY KEY,
	Symbol char(15) NOT NULL,
	Issue char(6) NOT NULL,
	Status char(10) NOT NULL,
	Name char(70) NOT NULL,
	ExchangeID char(6) NOT NULL,
	SK_CompanyID int NOT NULL,
	SharesOutstanding int NOT NULL,
	FirstTrade DATE NOT NULL,
	FirstTradeOnExchange DATE NOT NULL,
	Dividend int NOT NULL,
	IsCurrent bit NOT NULL,
	BatchID numeric(5) NOT NULL,
	EffectiveDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	CONSTRAINT FK_DimSecurity_CompanyID FOREIGN KEY (SK_CompanyID)
		REFERENCES DimCompany (SK_CompanyID)
);

create table DimTime (
	SK_TimeID int NOT NULL PRIMARY KEY,
	TimeValue TIME NOT NULL,
	HourID numeric(2) NOT NULL,
	HourDesc char(20) NOT NULL,
	MinuteID numeric(2) NOT NULL,
	MinuteDesc char(20) NOT NULL,
	SecondID numeric(2) NOT NULL,
	SecondDesc char(20) NOT NULL,
	MarketHoursFlag bit,
	OfficeHoursFlag bit
);

create table DimTrade (
	TradeID int NOT NULL,
	SK_BrokerID int,
	SK_CreateDateID int NOT NULL,
	SK_CreateTimeID int NOT NULL,
	SK_CloseDateID int,
	SK_CloseTimeID int,
	Status char(10) NOT NULL,
	DT_Type char(12) NOT NULL,
	CashFlag bit NOT NULL,
	SK_SecurityID int NOT NULL,
	SK_CompanyID int NOT NULL,
	Quantity numeric(6,0) NOT NULL,
	BidPrice numeric(8,2) NOT NULL,
	SK_CustomerID int NOT NULL,
	SK_AccountID int NOT NULL,
	ExecutedBy char(64) NOT NULL,
	TradePrice numeric(8,2),
	Fee numeric(10,2),
	Commission numeric(10,2),
	Tax numeric(10,2),
	BatchID numeric(5) NOT NULL,
	CONSTRAINT FK_DimTrade_BrokerID FOREIGN KEY (SK_BrokerID)
		REFERENCES DimBroker(SK_BrokerID),
	CONSTRAINT FK_DimTrade_CreateDateID FOREIGN KEY (SK_CreateDateID)
		REFERENCES DimDate(SK_DateID),
	CONSTRAINT FK_DimTrade_CreateTimeID FOREIGN KEY (SK_CreateTimeID)
		REFERENCES DimTime(SK_TimeID),
	CONSTRAINT FK_DimTrade_CloseDateID FOREIGN KEY (SK_CloseDateID)
		REFERENCES DimDate(SK_DateID),
	CONSTRAINT FK_DimTrade_CloseTimeID FOREIGN KEY (SK_CloseTimeID)
		REFERENCES DimTime(SK_TimeID),
	CONSTRAINT FK_DimTrade_SecurityID FOREIGN KEY (SK_SecurityID)
		REFERENCES DimSecurity(SK_SecurityID),
	CONSTRAINT FK_DimTrade_CompanyID FOREIGN KEY (SK_CompanyID)
		REFERENCES DimCompany(SK_CompanyID),
	CONSTRAINT FK_DimTrade_CustomerID FOREIGN KEY (SK_CustomerID)
		REFERENCES DimCustomer(SK_CustomerID),
	CONSTRAINT FK_DimTrade_AccountID FOREIGN KEY (SK_AccountID)
		REFERENCES DimAccount(SK_AccountID)
);

create table DImessages (
	MessageDateAndTime DATETIME NOT NULL,
	BatchID numeric(5) NOT NULL,
	MessageSource char(30),
	MessageText char(50) NOT NULL,
	MessageType char(12) NOT NULL,
	MessageData char(100)
);

create table FactCashBalances (
	SK_CustomerID int NOT NULL,
	SK_AccountID int NOT NULL,
	SK_DateID int NOT NULL,
	Cash numeric(15,2) NOT NULL,
	BatchID numeric(5) NOT NULL
	CONSTRAINT FK_FactCashBalances_CustomerId FOREIGN KEY (SK_CustomerID)
		REFERENCES DimCustomer(SK_CustomerID),
	CONSTRAINT FK_FactCashBalances_AccountID FOREIGN KEY (SK_AccountID)
		REFERENCES DimAccount(SK_AccountID),
	CONSTRAINT FK_FactCashBalances_DateID FOREIGN KEY (SK_DateID)
		REFERENCES DimDate(SK_DateID)
);

create table FactHoldings (
	TradeID int NOT NULL,
	CurrentTradeID int NOT NULL,
	SK_CustomerID int NOT NULL,
	SK_AccountID int NOT NULL,
	SK_SecurityID int NOT NULL,
	SK_CompanyID int NOT NULL,
	SK_DateID int NOT NULL,
	SK_TimeID int NOT NULL,
	CurrentPrice int,
	CurrentHolding numeric(6) NOT NULL,
	BatchID numeric(5),
	CONSTRAINT CK_CurrentPrice
		CHECK (CurrentPrice > 0),
	CONSTRAINT FK_FactHoldings_CustomerID FOREIGN KEY (SK_CustomerID)
		REFERENCES DimCustomer(SK_CustomerID),
	CONSTRAINT FK_FactHoldings_AccountID FOREIGN KEY (SK_AccountID)
		REFERENCES DimAccount(SK_AccountID),
	CONSTRAINT FK_FactHoldings_SecurityID FOREIGN KEY (SK_SecurityID)
		REFERENCES DimSecurity(SK_SecurityID),
	CONSTRAINT FK_FactHoldings_CompanyID FOREIGN KEY (SK_CompanyID)
		REFERENCES DimCompany(SK_CompanyID),
	CONSTRAINT FK_FactHoldings_DateID FOREIGN KEY (SK_DateID)
		REFERENCES DimDate(SK_DateID),
	CONSTRAINT FK_FactHoldings_TimeID FOREIGN KEY (SK_TimeID)
		REFERENCES DimTime(SK_TimeID)
);

create table FactMarketHistory (
	SK_SecurityID int NOT NULL,
	SK_CompanyID int NOT NULL,
	SK_DateID int NOT NULL,
	PERatio numeric(10,2),
	Yield numeric(5,2) NOT NULL,
	FiftyTwoWeekHigh numeric(8,2) NOT NULL,
	SK_FiftyTwoWeek int NOT NULL,
	FiftyTwoWeekLow numeric(8,2) NOT NULL,
	SK_FiftyTwoWeekL int NOT NULL,
	ClosePrice numeric(8,2) NOT NULL,
	DayHigh numeric(8,2) NOT NULL,
	DayLow numeric(8,2) NOT NULL,
	Volume numeric(12) NOT NULL,
	BatchID numeric(5),
	CONSTRAINT FK_FactMarketHistory_SecurityID FOREIGN KEY (SK_SecurityID)
		REFERENCES DimSecurity(SK_SecurityID),
	CONSTRAINT FK_FactMarketHistory_CompanyID FOREIGN KEY (SK_CompanyID)
		REFERENCES DimCompany(SK_CompanyID),
	CONSTRAINT FK_FactMarketHistory_DateID FOREIGN KEY (SK_DateID)
		REFERENCES DimDate(SK_DateID)
);

create table FactWatches (
	SK_CustomerID int NOT NULL,
	SK_SecurityID int NOT NULL,
	SK_DateID_DatePlaced int,
	SK_DateID_DateRemoved int,
	BatchID numeric(5) NOT NULL,
	CONSTRAINT FK_FactWatches_CustomerID FOREIGN KEY (SK_CustomerID)
		REFERENCES DimCustomer(SK_CustomerID),
	CONSTRAINT FK_FactWatches_SecurityID FOREIGN KEY (SK_SecurityID)
		REFERENCES DimSecurity(SK_SecurityID),
	CONSTRAINT FK_FactWatches_DatePlaced FOREIGN KEY (SK_DateID_DatePlaced)
		REFERENCES DimDate(SK_DateID),
	CONSTRAINT FK_FactWatches_DateRemoved FOREIGN KEY (SK_DateID_DateRemoved)
		REFERENCES DimDate(SK_DateID)
);

create table Industry (
	IN_ID char(2) NOT NULL,
	IN_NAME char(50) NOT NULL,
	IN_SC_ID char(4) NOT NULL
);

create table Financial (
	SK_CompanyID int NOT NULL,
	FI_YEAR numeric(4) NOT NULL,
	FI_QTR numeric(1) NOT NULL,
	FI_QTR_START_DATE date NOT NULL,
	FI_REVENUE numeric(15, 2) NOT NULL,
	FI_NET_EARN numeric(15, 2) NOT NULL,
	FI_BASIC_EPS numeric(10, 2) NOT NULL,
	FI_DILUT_EPS numeric(10, 2) NOT NULL,
	FI_MARGIN numeric(10, 2) NOT NULL,
	FI_INVENTORY numeric(15, 2) NOT NULL,
	FI_ASSETS numeric(15, 2) NOT NULL,
	FI_LIABILITY numeric(15, 2) NOT NULL,
	FI_OUT_BASIC numeric(12) NOT NULL,
	FI_OUT_DILUT numeric(12) NOT NULL,
	CONSTRAINT FK_Financial_CompanyID FOREIGN KEY (SK_CompanyID)
		REFERENCES DimCompany(SK_CompanyID)
);

create table Prospect (
	AgencyID char(30) NOT NULL,  
	SK_RecordDateID int NOT NULL, 
	SK_UpdateDateID int NOT NULL,
	BatchID numeric(5) NOT NULL,
	IsCustomer bit NOT NULL,
	LastName char(30) NOT NULL,
	FirstName char(30) NOT NULL,
	MiddleInitial char(1),
	Gender char(1),
	AddressLine1 varchar(80),
	AddressLine2 varchar(80),
	PostalCode char(12),
	City char(25) NOT NULL,
	State char(20) NOT NULL,
	Country char(24),
	Phone char(30), 
	Income numeric(9),
	NumberCars numeric(2), 
	NumberChildren numeric(2), 
	MaritalStatus char(1), 
	Age numeric(3),
	CreditRating numeric(4),
	OwnOrRentFlag char(1), 
	Employer char(30),
	NumberCreditCards numeric(2), 
	NetWorth numeric(12),
	MarketingNameplate char(100),
	CONSTRAINT FK_Prospect_UpdateDateID FOREIGN KEY (SK_UpdateDateID)
		REFERENCES DimDate(SK_DateID)
);

create table StatusType (
	ST_ID char(4) NOT NULL PRIMARY KEY,
	ST_NAME char(10) NOT NULL
);

CREATE TABLE TaxRate (
    TX_ID char(4) NOT NULL PRIMARY KEY,
    TX_NAME char(50) NOT NULL,
    TX_RATE numeric(6,5) NOT NULL
);

create table TradeType (
	TT_ID char(3) NOT NULL PRIMARY KEY,
	TT_NAME char(12) NOT NULL,
	TT_IS_SELL numeric(1) NOT NULL,
	TT_IS_MRKT numeric(1) NOT NULL
);

create table AuditTable ( 
	DataSet char(20) NOT NULL,
	BatchID numeric(5),
	Date DATE,
	Attribute char(50) NOT NULL,
	Value numeric(15),
	DValue numeric(15,5)
);
