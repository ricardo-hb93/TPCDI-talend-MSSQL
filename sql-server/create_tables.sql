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

CREATE TABLE DimCompany (
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
	SK_AccountID int NOT NULL PRIMARY KEY,
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
	constraint CK_TaxStatus
		CHECK (TaxStatus = 0 or TaxStatus = 1 or TaxStatus = 2),
	constraint FK_BrokerID FOREIGN KEY (SK_BrokerID)
		REFERENCES DimBroker(SK_BrokerID),
	constraint FK_CustomerID FOREIGN KEY (SK_CustomerID)
		REFERENCES DimCustomer(SK_CustomerID)
);

create table DimDate (
	SK_DateID int NOT NULL PRIMARY KEY,
	DateValue DATE NOT NULL,
	DateDesc char(20) NOT NULL,
	CalendarYearID numeric(4) NOT NULL,
	CalendarYearDesc char(20) NOT NULL,
	CalendarQtrID numeric(5) NOT NULL,
	CalendarQtrDesc char(20) NOT NULL,
	CalendarMonthID numeric(6) NOT NULL,
	CalendarMonthDesc char(20) NOT NULL,
	CalendarWeekID numeric(6) NOT NULL,
	CalendarWeekDesc char(20) NOT NULL,
	DayOfWeeknumeric numeric(1) NOT NULL,
	DayOfWeekDesc char(10) NOT NULL,
	FiscalYearID numeric(4) NOT NULL,
	FiscalYearDesc char(20) NOT NULL,
	FiscalQtrID numeric(5) NOT NULL,
	FiscalQtrDesc char(20) NOT NULL,
	HolidayFlag bit
);

create table Financial (
	SK_CompanyID int NOT NULL PRIMARY KEY,
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
	FI_OUT_DILUT numeric(12) NOT NULL
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