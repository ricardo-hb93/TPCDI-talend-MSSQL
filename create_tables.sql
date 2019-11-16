
create table Financial (
	SK_CompanyID numeric(11) NOT NULL PRIMARY KEY,
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