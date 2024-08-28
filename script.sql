USE CBADigitalReceipt;

DECLARE @sql NVARCHAR(MAX) = N'';

-- Generate SQL to drop all foreign key constraints
SELECT @sql = @sql + 'ALTER TABLE ' + 
                QUOTENAME(OBJECT_SCHEMA_NAME(f.parent_object_id)) + '.' + 
                QUOTENAME(OBJECT_NAME(f.parent_object_id)) +
                ' DROP CONSTRAINT ' + QUOTENAME(f.name) + ';' + CHAR(13)
FROM sys.foreign_keys AS f;

-- Print the SQL statements (optional, for verification)
PRINT @sql;

-- Execute the generated SQL to drop the foreign key constraints
EXEC sp_executesql @sql;

-- Drop tables with CASCADE
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Transactions ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Batches ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.FileExports ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.AuditLogs ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.OneTimePasswords ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.UserConfigs ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Users ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Terminals ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Merchants ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Partners ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Permissions ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Roles ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.FailedSubmissions ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.RECEIPT_DETAILS ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.PUSHDEVICE_OPERATION ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.DEVICE_STATUS ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.PUSH_DEVICE ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.DEVICES ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.DEVICE_INFO ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.DeviceConfigs ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Devices ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.OPERATION ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.STATUS ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.SubscriptionResources ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Resources ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Subscriptions ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Currencies ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.email_config ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.ConsumingServices ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.MerchantCategoryCodes ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.DeviceModels ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.Venders ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.ApplicationSignatures ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.AppCodes ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.AggregatedTransactions ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.EReceipts ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.PAPER_ROLL_STATUS ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.TASK_CONFIG ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.FailedTransactions ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.SequelizeMeta ;
DROP TABLE IF EXISTS CBADigitalReceipt.dbo.TranSummary ;

CREATE TABLE CBADigitalReceipt.dbo.AppCodes (
	id bigint IDENTITY(1,1) NOT NULL,
	code varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	description varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	deletedRec bigint DEFAULT 0 NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__AppCodes__3213E83F8946867F PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.ApplicationSignatures (
	id bigint IDENTITY(1,1) NOT NULL,
	appVersion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	appSignature varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	packageFileSignature varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	sysFileSize bigint NULL,
	CONSTRAINT PK__Applicat__3213E83FC1A158CB PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.Venders (
	id bigint IDENTITY(1,1) NOT NULL,
	name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	img varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Venders__3213E83F39D8C1F4 PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.DeviceModels (
	id bigint IDENTITY(1,1) NOT NULL,
	name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	venderId bigint NULL,
	img varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__DeviceMo__3213E83F0DC441BD PRIMARY KEY (id),
	CONSTRAINT [uk-device-model] UNIQUE (name),
	CONSTRAINT FK__DeviceMod__vende__43F60EC8 FOREIGN KEY (venderId) REFERENCES CBADigitalReceipt.dbo.Venders(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.MerchantCategoryCodes (
	id bigint IDENTITY(1,1) NOT NULL,
	code varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	description varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Merchant__3213E83FE656862F PRIMARY KEY (id),
	CONSTRAINT UQ__Merchant__357D4CF9A1D5E303 UNIQUE (code)
);

CREATE TABLE CBADigitalReceipt.dbo.ConsumingServices (
	id bigint IDENTITY(1,1) NOT NULL,
	serviceName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Consumin__3213E83F64939184 PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.email_config (
	id bigint IDENTITY(1,1) NOT NULL,
	[action] varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	bcc varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cc varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	to_list varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__email_co__3213E83F908EF265 PRIMARY KEY (id),
	CONSTRAINT unique_action UNIQUE ([action])
);

CREATE TABLE CBADigitalReceipt.dbo.Currencies (
	id bigint IDENTITY(1,1) NOT NULL,
	code varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	displayName varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Currenci__3213E83F645DCE55 PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.Subscriptions (
	id bigint IDENTITY(1,1) NOT NULL,
	callbackUrl varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	retryCount bigint NOT NULL,
	mailOnSuccess varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	mailOnFaliure varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	consumingServiceId bigint NULL,
	CONSTRAINT PK__Subscrip__3213E83F82A1A04A PRIMARY KEY (id),
	CONSTRAINT FK__Subscript__consu__131DCD43 FOREIGN KEY (consumingServiceId) REFERENCES CBADigitalReceipt.dbo.ConsumingServices(id) ON DELETE SET NULL
);

CREATE TABLE CBADigitalReceipt.dbo.Resources (
	id bigint IDENTITY(1,1) NOT NULL,
	name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Resource__3213E83FF920656E PRIMARY KEY (id)
);
CREATE TABLE CBADigitalReceipt.dbo.SubscriptionResources (
	subscriptionId bigint NOT NULL,
	resourceId bigint NOT NULL,
	CONSTRAINT PK__Subscrip__778732345588957C PRIMARY KEY (subscriptionId,resourceId),
	CONSTRAINT SubscriptionResources_subscriptionId_resourceId_unique UNIQUE (subscriptionId,resourceId),
	CONSTRAINT FK__Subscript__resou__17E28260 FOREIGN KEY (resourceId) REFERENCES CBADigitalReceipt.dbo.Resources(id) ON DELETE CASCADE,
	CONSTRAINT FK__Subscript__subsc__16EE5E27 FOREIGN KEY (subscriptionId) REFERENCES CBADigitalReceipt.dbo.Subscriptions(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.STATUS (
	status_code varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	status_description varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__STATUS__4157B020035ACE31 PRIMARY KEY (status_code)
);

CREATE TABLE CBADigitalReceipt.dbo.OPERATION (
	id bigint NOT NULL,
	operationcode varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	description varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	status varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__OPERATIO__3213E83F4DCD725E PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.Devices (
	id bigint IDENTITY(1,1) NOT NULL,
	serialNo varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	emiNo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	deviceType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	uniqueId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	deletedRec bigint DEFAULT 0 NULL,
	createdBy bigint NULL,
	modifiedBy bigint NULL,
	deletedBy bigint NULL,
	active bit DEFAULT 1 NULL,
	lastActive datetime2 NULL,
	lat float NULL,
	lng float NULL,
	deviceModelId bigint NULL,
	isAway bit NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Devices__3213E83FEEA6B22F PRIMARY KEY (id),
	CONSTRAINT [uk-device] UNIQUE (serialNo,deletedRec),
	CONSTRAINT FK__Devices__deviceM__49AEE81E FOREIGN KEY (deviceModelId) REFERENCES CBADigitalReceipt.dbo.DeviceModels(id)
);

CREATE TABLE CBADigitalReceipt.dbo.DeviceConfigs (
	id bigint IDENTITY(1,1) NOT NULL,
	configType varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	config varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	deviceId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__DeviceCo__3213E83FFF3F0007 PRIMARY KEY (id),
	CONSTRAINT FK__DeviceCon__devic__664B26CC FOREIGN KEY (deviceId) REFERENCES CBADigitalReceipt.dbo.Devices(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.DEVICE_INFO (
	id bigint IDENTITY(1,1) NOT NULL,
	app_list varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	cpu varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	ram varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	battery varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	storage varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	firmware varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	latitude varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	longitude varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	merchant_id varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	terminal_id varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	model_name varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	printer_status varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	printer_cut_mode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	sim_serial varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	additional_data varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	device_id bigint NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__DEVICE_I__3213E83F56D8B4E7 PRIMARY KEY (id),
	CONSTRAINT FK__DEVICE_IN__devic__3A379A64 FOREIGN KEY (device_id) REFERENCES CBADigitalReceipt.dbo.Devices(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.PUSH_DEVICE (
	id bigint IDENTITY(1,1) NOT NULL,
	push_id varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	device_id bigint NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__PUSH_DEV__3213E83F12EAB196 PRIMARY KEY (id),
	CONSTRAINT FK__PUSH_DEVI__devic__4885B9BB FOREIGN KEY (device_Id) REFERENCES CBADigitalReceipt.dbo.Devices(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.DEVICE_STATUS (
	id bigint IDENTITY(1,1) NOT NULL,
	last_updated_time datetime2 DEFAULT NULL NULL,
	device_active bit DEFAULT 0 NOT NULL,
	device_id bigint NOT NULL,
	device_status varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__DEVICE_S__3213E83F0E2D486C PRIMARY KEY (id),
	CONSTRAINT FK__DEVICE_ST__devic__41D8BC2C FOREIGN KEY (device_id) REFERENCES CBADigitalReceipt.dbo.Devices(id) ON DELETE CASCADE,
	CONSTRAINT FK__DEVICE_ST__devic__42CCE065 FOREIGN KEY (device_status) REFERENCES CBADigitalReceipt.dbo.STATUS(status_code) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.PUSHDEVICE_OPERATION (
	id bigint IDENTITY(1,1) NOT NULL,
	status varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	push_data varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	merchantId varchar(16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	serialNo varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	operationId bigint NOT NULL,
	pushDeviceId bigint NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__PUSHDEVI__3213E83F800A73BB PRIMARY KEY (id),
	CONSTRAINT FK__PUSHDEVIC__opera__4C564A9F FOREIGN KEY (operationId) REFERENCES CBADigitalReceipt.dbo.OPERATION(id) ON DELETE CASCADE,
	CONSTRAINT FK__PUSHDEVIC__pushD__4D4A6ED8 FOREIGN KEY (pushDeviceId) REFERENCES CBADigitalReceipt.dbo.PUSH_DEVICE(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.RECEIPT_DETAILS (
	id bigint IDENTITY(1,1) NOT NULL,
	AUTH_CODE varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONVERTED_IMAGE_DATA varbinary(MAX) NULL,
	IMAGE_DATA varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	INVOICE_NUMBER varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IS_DONE bigint NOT NULL,
	ITERNATION_ID bigint NULL,
	MERCHANT_ID varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	SERIAL_NUMBER varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	TERMINAL_ID varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	TRACE_NUMBER varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__RECEIPT___3213E83F42E2FDDC PRIMARY KEY (id)
);

CREATE TABLE CBADigitalReceipt.dbo.FailedSubmissions (
	id bigint IDENTITY(1,1) NOT NULL,
	currentRetry bigint NOT NULL,
	record varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	resource varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	event varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	cause varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	subscriptionId bigint NULL,
	CONSTRAINT PK__FailedSu__3213E83F2A3DD77F PRIMARY KEY (id),
	CONSTRAINT FK__FailedSub__subsc__1ABEEF0B FOREIGN KEY (subscriptionId) REFERENCES CBADigitalReceipt.dbo.Subscriptions(id)
);

CREATE TABLE CBADigitalReceipt.dbo.Roles (
	id bigint IDENTITY(1,1) NOT NULL,
	roleName varchar(45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	deletedRec bigint DEFAULT 0 NULL,
	createdBy bigint NULL,
	modifiedBy bigint NULL,
	deletedBy bigint NULL,
	appCodeId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Roles__3213E83FD41B78AB PRIMARY KEY (id),
	CONSTRAINT [uk-role] UNIQUE (roleName,deletedRec),
	CONSTRAINT FK__Roles__appCodeId__32CB82C6 FOREIGN KEY (appCodeId) REFERENCES CBADigitalReceipt.dbo.AppCodes(id)
);


CREATE TABLE CBADigitalReceipt.dbo.Permissions (
	id bigint IDENTITY(1,1) NOT NULL,
	createD smallint NULL,
	readD smallint NULL,
	updateD smallint NULL,
	deleteD smallint NULL,
	createdBy smallint NULL,
	modifiedBy smallint NULL,
	deletedBy smallint NULL,
	deletedRec bigint DEFAULT 0 NULL,
	resourceId bigint NULL,
	roleId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Permissi__3213E83FDF4C89CA PRIMARY KEY (id),
	CONSTRAINT FK__Permissio__resou__57FD0775 FOREIGN KEY (resourceId) REFERENCES CBADigitalReceipt.dbo.Resources(id) ON DELETE CASCADE,
	CONSTRAINT FK__Permissio__roleI__58F12BAE FOREIGN KEY (roleId) REFERENCES CBADigitalReceipt.dbo.Roles(id) ON DELETE CASCADE
);
CREATE TABLE CBADigitalReceipt.dbo.Partners (
	id bigint IDENTITY(1,1) NOT NULL,
	name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	address varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	email varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	contactNo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	deletedRec bigint DEFAULT 0 NOT NULL,
	createdBy bigint NULL,
	modifiedBy bigint NULL,
	deletedBy bigint NULL,
	logo varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Partners__3213E83FC2B65229 PRIMARY KEY (id),
	CONSTRAINT [uk-partner] UNIQUE (deletedRec)
);

CREATE TABLE CBADigitalReceipt.dbo.Merchants (
	id bigint IDENTITY(1,1) NOT NULL,
	name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	merchantId varchar(16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	deletedRec bigint DEFAULT 0 NULL,
	email varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	contactNo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	province varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	district varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	address varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	mcc varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdBy bigint NULL,
	modifiedBy bigint NULL,
	deletedBy bigint NULL,
	lat float NULL,
	lng float NULL,
	radius bigint NULL,
	partnerId bigint NULL,
	isEmailEnabled bit DEFAULT 0 NULL,
	isSMSEnabled bit DEFAULT 0 NULL,
	isSettlementEmailEnabled bit DEFAULT 0 NULL,
	isSettlementSMSEnabled bit DEFAULT 0 NULL,
	contactPerson varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	merchantPassword varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Merchant__3213E83F4262B9A2 PRIMARY KEY (id),
	CONSTRAINT FK__Merchants__partn__3E3D3572 FOREIGN KEY (partnerId) REFERENCES CBADigitalReceipt.dbo.Partners(id) ON DELETE CASCADE
);
CREATE UNIQUE NONCLUSTERED INDEX merchants_merchant_id_deleted_rec ON CBADigitalReceipt.dbo.Merchants (merchantId, deletedRec);

CREATE TABLE CBADigitalReceipt.dbo.Terminals (
	id bigint IDENTITY(1,1) NOT NULL,
	terminalId varchar(9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	deletedRec bigint DEFAULT 0 NULL,
	createdBy bigint NULL,
	modifiedBy bigint NULL,
	deletedBy bigint NULL,
	merchantId bigint NULL,
	deviceId bigint NULL,
	lastSettled datetime2 NULL,
	expectedSale bigint DEFAULT 0 NULL,
	isVoidEnabled bit DEFAULT 0 NULL,
	isOfflineEnabled bit DEFAULT 0 NULL,
	isPreauthEnabled bit DEFAULT 0 NULL,
	isMkeEnabled bit DEFAULT 0 NULL,
	currency varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	remarks varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	highAmount bigint DEFAULT 0 NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__Terminal__3213E83F5DA9519B PRIMARY KEY (id),
	CONSTRAINT FK__Terminals__devic__636EBA21 FOREIGN KEY (deviceId) REFERENCES CBADigitalReceipt.dbo.Devices(id),
	CONSTRAINT FK__Terminals__merch__627A95E8 FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id)
);
CREATE UNIQUE NONCLUSTERED INDEX terminals_terminal_id_deleted_rec ON CBADigitalReceipt.dbo.Terminals (terminalId, deletedRec);

CREATE TABLE CBADigitalReceipt.dbo.Users (
	id bigint IDENTITY(1,1) NOT NULL,
	name varchar(45) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	userName varchar(45) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	password varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	email varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	contactNo varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	lastLoginTime datetime2 NULL,
	loginAttempts bigint DEFAULT 0 NULL,
	sessionId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdBy bigint NULL,
	modifiedBy bigint NULL,
	deletedBy bigint NULL,
	deletedRec bigint DEFAULT 0 NULL,
	roleId bigint NULL,
	partnerId bigint NULL,
	merchantId bigint NULL,
	deviceId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	deletedAt datetime2 NULL,
	CONSTRAINT PK__Users__3213E83F9C50A57A PRIMARY KEY (id),
	CONSTRAINT [uk-user] UNIQUE (userName,email,deletedRec),
	CONSTRAINT FK__Users__deviceId__52442E1F FOREIGN KEY (deviceId) REFERENCES CBADigitalReceipt.dbo.Devices(id),
	CONSTRAINT FK__Users__merchantI__515009E6 FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id),
	CONSTRAINT FK__Users__partnerId__505BE5AD FOREIGN KEY (partnerId) REFERENCES CBADigitalReceipt.dbo.Partners(id),
	CONSTRAINT FK__Users__roleId__4F67C174 FOREIGN KEY (roleId) REFERENCES CBADigitalReceipt.dbo.Roles(id)
);

CREATE TABLE CBADigitalReceipt.dbo.UserConfigs (
	id bigint IDENTITY(1,1) NOT NULL,
	configType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	config varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	userId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__UserConf__3213E83FE6251C74 PRIMARY KEY (id),
	CONSTRAINT FK__UserConfi__userI__69279377 FOREIGN KEY (userId) REFERENCES CBADigitalReceipt.dbo.Users(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.OneTimePasswords (
	id bigint IDENTITY(1,1) NOT NULL,
	value bigint NOT NULL,
	expiresOn datetime2 NULL,
	userId bigint NULL,
	CONSTRAINT PK__OneTimeP__3213E83FE5E123BA PRIMARY KEY (id),
	CONSTRAINT FK__OneTimePa__userI__6C040022 FOREIGN KEY (userId) REFERENCES CBADigitalReceipt.dbo.Users(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.AuditLogs (
	id bigint IDENTITY(1,1) NOT NULL,
	recordId bigint NOT NULL,
	preValue varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	newValue varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	operation varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	resourceName varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	userId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__AuditLog__3213E83FF3DF7CFB PRIMARY KEY (id),
	CONSTRAINT FK__AuditLogs__userI__2630A1B7 FOREIGN KEY (userId) REFERENCES CBADigitalReceipt.dbo.Users(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.FileExports (
	id bigint IDENTITY(1,1) NOT NULL,
	filePath varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	fileName varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	filters varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	status varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	userId bigint NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__FileExpo__3213E83F9365C93C PRIMARY KEY (id),
	CONSTRAINT FK__FileExpor__userI__520F23F5 FOREIGN KEY (userId) REFERENCES CBADigitalReceipt.dbo.Users(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.Batches (
	id bigint IDENTITY(1,1) NOT NULL,
	batchNo bigint NULL,
	batchKey varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	saleCount bigint DEFAULT 0 NULL,
	saleAmount bigint DEFAULT 0 NULL,
	saleVoidCount bigint DEFAULT 0 NULL,
	saleVoidAmount bigint DEFAULT 0 NULL,
	offlineCount bigint DEFAULT 0 NULL,
	offlineAmount bigint DEFAULT 0 NULL,
	offlineVoidCount bigint DEFAULT 0 NULL,
	offlineVoidAmount bigint DEFAULT 0 NULL,
	precompCount bigint DEFAULT 0 NULL,
	precompAmount bigint DEFAULT 0 NULL,
	precompVoidCount bigint DEFAULT 0 NULL,
	precompVoidAmount bigint DEFAULT 0 NULL,
	isSettled bit DEFAULT 0 NULL,
	settledMethod bigint DEFAULT 0 NULL,
	settledDate datetime2 NULL,
	currencycode varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	terminalId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	merchantId bigint NULL,
	CONSTRAINT PK__Batches__3213E83F4922D2D0 PRIMARY KEY (id),
	CONSTRAINT FK__Batches__merchan__7F16D496 FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id),
	CONSTRAINT FK__Batches__termina__7E22B05D FOREIGN KEY (terminalId) REFERENCES CBADigitalReceipt.dbo.Terminals(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.Transactions (
	id bigint IDENTITY(1,1) NOT NULL,
	originId varchar(65) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	paymentMode varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	custMobile varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	transType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cardLabel varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	terminalId bigint NULL,
	batchId bigint NULL,
	traceNo bigint NULL,
	invoiceNo bigint NULL,
	amount bigint NOT NULL,
	currency varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	batchNo bigint NULL,
	pan varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dateTime] datetime2 NOT NULL,
	expDate varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nii varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	rrn varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	authCode varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	signData varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipAmount bigint NULL,
	entryMode varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dccCurrency varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dccTranAmount bigint NULL,
	isVoided bit DEFAULT 0 NULL,
	lat float NULL,
	lng float NULL,
	isAway bit NULL,
	oriTraceNo bigint NULL,
	oriTransType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriBatchNo bigint NULL,
	oriDateTime datetime2 NULL,
	oriRrn varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriAuthCode varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriSignData varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	merchantId bigint NULL,
	CONSTRAINT PK__Transact__3213E83F4B291826 PRIMARY KEY (id),
	CONSTRAINT FK__Transacti__batch__03DB89B3 FOREIGN KEY (batchId) REFERENCES CBADigitalReceipt.dbo.Batches(id),
	CONSTRAINT FK__Transacti__merch__04CFADEC FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id),
	CONSTRAINT FK__Transacti__termi__02E7657A FOREIGN KEY (terminalId) REFERENCES CBADigitalReceipt.dbo.Terminals(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.FailedTransactions (
	id bigint IDENTITY(1,1) NOT NULL,
	originId varchar(65) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	paymentMode varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	custMobile varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	transType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cardLabel varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	terminalId bigint NULL,
	batchId bigint NULL,
	traceNo bigint NULL,
	invoiceNo bigint NULL,
	amount bigint NOT NULL,
	currency varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	batchNo bigint NULL,
	pan varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dateTime] datetime2 NOT NULL,
	expDate varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nii varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	rrn varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	authCode varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	respCode varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	signData varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipAmount bigint NULL,
	entryMode varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dccCurrency varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dccTranAmount bigint NULL,
	lat float NULL,
	lng float NULL,
	isAway bit NULL,
	isVoided bit DEFAULT 0 NULL,
	oriTraceNo bigint DEFAULT 0 NULL,
	oriTransType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriBatchNo bigint DEFAULT 0 NULL,
	oriDateTime datetime2 NULL,
	oriRrn varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriAuthCode varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriSignData varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	merchantId bigint NULL,
	CONSTRAINT PK__FailedTr__3213E83F1C1E6E3D PRIMARY KEY (id),
	CONSTRAINT FK__FailedTra__batch__0B7CAB7B FOREIGN KEY (batchId) REFERENCES CBADigitalReceipt.dbo.Batches(id),
	CONSTRAINT FK__FailedTra__merch__0C70CFB4 FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id),
	CONSTRAINT FK__FailedTra__termi__0A888742 FOREIGN KEY (terminalId) REFERENCES CBADigitalReceipt.dbo.Terminals(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.EReceipts (
	id bigint IDENTITY(1,1) NOT NULL,
	email varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	contactNo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	receiptType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	eReceiptCategory varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	isSentMail bit DEFAULT 0 NULL,
	isSentSMS bit DEFAULT 0 NULL,
	transactionId bigint NULL,
	batchId bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__EReceipt__3213E83F6B889BF6 PRIMARY KEY (id),
	CONSTRAINT FK__EReceipts__batch__2354350C FOREIGN KEY (batchId) REFERENCES CBADigitalReceipt.dbo.Batches(id),
	CONSTRAINT FK__EReceipts__trans__226010D3 FOREIGN KEY (transactionId) REFERENCES CBADigitalReceipt.dbo.Transactions(id) ON DELETE CASCADE
);

CREATE TABLE CBADigitalReceipt.dbo.AggregatedTransactions (
	id bigint IDENTITY(1,1) NOT NULL,
	partnerId bigint NULL,
	netTotal bigint NOT NULL,
	netCount bigint NOT NULL,
	currency varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[date] datetime2 NOT NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	merchantId bigint NULL,
	CONSTRAINT PK__Aggregat__3213E83FE23033F6 PRIMARY KEY (id),
	CONSTRAINT FK__Aggregate__merch__57C7FD4B FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id) ON DELETE SET NULL,
	CONSTRAINT FK__Aggregate__partn__56D3D912 FOREIGN KEY (partnerId) REFERENCES CBADigitalReceipt.dbo.Partners(id)
);
CREATE  UNIQUE NONCLUSTERED INDEX aggregated_transactions_merchant_id_partner_id_currency_date ON CBADigitalReceipt.dbo.AggregatedTransactions (  merchantId ASC  , partnerId ASC  , currency ASC  , date ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

CREATE TABLE CBADigitalReceipt.dbo.TASK_CONFIG (
	id bigint IDENTITY(1,1) NOT NULL,
	[action] varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	isEnabled bit DEFAULT 0 NULL,
	cron varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	value bigint NULL,
	period bigint NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	CONSTRAINT PK__TASK_CON__3213E83FF7BE0A20 PRIMARY KEY (id),
	CONSTRAINT UQ__TASK_CON__2479A5165A6521F2 UNIQUE ([action])
);

CREATE TABLE CBADigitalReceipt.dbo.PAPER_ROLL_STATUS (
	id bigint IDENTITY(1,1) NOT NULL,
	serialNo varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	reqDate datetime2 NULL,
	[type] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	remarks varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	contactPerson varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	contactNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	merchantId bigint NULL,
	terminalId bigint NULL,
	CONSTRAINT PK__PAPER_RO__3213E83F113B872E PRIMARY KEY (id),
	CONSTRAINT FK__PAPER_ROL__merch__03E80D59 FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id),
	CONSTRAINT FK__PAPER_ROL__termi__04DC3192 FOREIGN KEY (terminalId) REFERENCES CBADigitalReceipt.dbo.Terminals(id)
);

CREATE TABLE CBADigitalReceipt.dbo.TranSummary (
	id bigint IDENTITY(1,1) NOT NULL,
	originId varchar(65) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	paymentMode varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	custMobile varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	transType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cardLabel varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	terminalId bigint NULL,
	batchId bigint NULL,
	traceNo bigint NULL,
	invoiceNo bigint NULL,
	amount bigint NOT NULL,
	currency varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	batchNo bigint NULL,
	pan varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dateTime] datetime2 NOT NULL,
	expDate varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	nii varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	rrn varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	authCode varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	signData varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	tipAmount bigint NULL,
	entryMode varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dccCurrency varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dccTranAmount bigint NULL,
	isVoided bit DEFAULT 0 NULL,
	isProcessed bit DEFAULT 0 NULL,
	isNotified bit DEFAULT 0 NULL,
	lat float NULL,
	lng float NULL,
	isAway bit NULL,
	oriTraceNo bigint NULL,
	oriTransType varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriBatchNo bigint NULL,
	oriDateTime datetime2 NULL,
	oriRrn varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriAuthCode varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oriSignData varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	createdAt datetime2 NOT NULL,
	updatedAt datetime2 NOT NULL,
	merchantId bigint NULL,
	CONSTRAINT PK__TranSumm__3213E83FBD5A01F5 PRIMARY KEY (id),
	CONSTRAINT FK__TranSumma__batch__6521F869 FOREIGN KEY (batchId) REFERENCES CBADigitalReceipt.dbo.Batches(id),
	CONSTRAINT FK__TranSumma__merch__66161CA2 FOREIGN KEY (merchantId) REFERENCES CBADigitalReceipt.dbo.Merchants(id),
	CONSTRAINT FK__TranSumma__termi__642DD430 FOREIGN KEY (terminalId) REFERENCES CBADigitalReceipt.dbo.Terminals(id) ON DELETE CASCADE
);
INSERT INTO CBADigitalReceipt.dbo.Currencies (code,displayName,createdAt,updatedAt) VALUES
	 (N'LKR',N'LKR','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'USD',N'USD','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'EUR',N'EUR','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'GBP',N'GBP','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.AppCodes (code,description,deletedRec,createdAt,updatedAt) VALUES
	 (N'57eb8e42-dde6-4a75-a501-5d6c431dd12c',N'ADMIN',0,'2024-07-08 09:13:37.4760000 +00:00','2024-07-08 09:13:37.4760000 +00:00'),
	 (N'f0f87dec-f390-4409-a068-6fe41905ba5b',N'PARTNER',0,'2024-07-08 09:13:37.6500000 +00:00','2024-07-08 09:13:37.6500000 +00:00'),
	 (N'095b4ff7-f1d3-4195-a74a-291c24574b84',N'MERCHANT',0,'2024-07-08 09:13:37.6630000 +00:00','2024-07-08 09:13:37.6630000 +00:00'),
	 (N'2db4e14d-0cb7-4ec6-a867-46fe2b57cb3f',N'DEVICE',0,'2024-07-08 09:13:37.6740000 +00:00','2024-07-08 09:13:37.6740000 +00:00');

INSERT INTO CBADigitalReceipt.dbo.Resources (name,createdAt,updatedAt) VALUES
	 (N'users','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'roles','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'user-roles','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'resources','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'permissions','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'partners','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'merchants','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'terminals','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'devices','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'audits','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');
INSERT INTO CBADigitalReceipt.dbo.Resources (name,createdAt,updatedAt) VALUES
	 (N'transactions','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'file-export','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'currency','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'venders','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'device-models','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'email-config','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'task-config','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'mcc','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'settlement','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'push-notification','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');
INSERT INTO CBADigitalReceipt.dbo.Resources (name,createdAt,updatedAt) VALUES
	 (N'report-export','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'geo-location','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'force-settlement','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'merchant-feedback-highlight','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'tran-status-highlight','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (N'device-status-highlight','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.Roles (roleName,deletedRec,createdBy,modifiedBy,deletedBy,appCodeId,createdAt,updatedAt) VALUES
	(N'super admin',0,NULL,NULL,NULL,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.Permissions (createD,readD,updateD,deleteD,createdBy,modifiedBy,deletedBy,deletedRec,resourceId,roleId,createdAt,updatedAt) VALUES
	 (1,1,1,1,NULL,NULL,NULL,0,1,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,2,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,3,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,4,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,5,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,6,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,7,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,8,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,9,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,10,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');
INSERT INTO CBADigitalReceipt.dbo.Permissions (createD,readD,updateD,deleteD,createdBy,modifiedBy,deletedBy,deletedRec,resourceId,roleId,createdAt,updatedAt) VALUES
	 (1,1,1,1,NULL,NULL,NULL,0,11,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,12,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,13,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,14,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,15,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,16,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,17,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,18,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,19,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');
INSERT INTO CBADigitalReceipt.dbo.Permissions (createD,readD,updateD,deleteD,createdBy,modifiedBy,deletedBy,deletedRec,resourceId,roleId,createdAt,updatedAt) VALUES
	 (1,1,1,1,NULL,NULL,NULL,0,20,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,21,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,22,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,23,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,24,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,25,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 (1,1,1,1,NULL,NULL,NULL,0,26,1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.Users (name,userName,password,email,contactNo,lastLoginTime,loginAttempts,sessionId,createdBy,modifiedBy,deletedBy,deletedRec,roleId,partnerId,merchantId,deviceId,createdAt,updatedAt,deletedAt) VALUES
	 (N'Super Admin',N'SuperAdmin',N'$2a$10$0cLqaal/OjgOinPDixZVvuJJ/vVrjg5icbEtNed6iFjAfFmfmS2la',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000',NULL);

INSERT INTO CBADigitalReceipt.dbo.Venders (name,img,createdAt,updatedAt) VALUES
	 (N'CBA',NULL,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.DeviceModels (name,venderId,img,createdAt,updatedAt) VALUES
	 (N'A920',1,NULL,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.MerchantCategoryCodes (code,description,createdAt,updatedAt) VALUES
	 (N'5411',N'Grocery Stores, Supermarkets','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.email_config (action,bcc,cc,to_list,createdAt,updatedAt) VALUES
	 ('FAILED_FREQUENCY',NULL,NULL,'ashan.m@cba.lk,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('TIMEOUT_FREQUENCY',NULL,NULL,'ashan.m@cba.lk,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('OUT_OF_GEO_FENCE',NULL,NULL,'ashan.m@cba.lk,layantha95@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('FEEDBACK_REQUEST ',NULL,NULL,'ashan.m@cba.lk,layantha95@gmail.com,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('UNSETTLED_ALERT',NULL,NULL,'ashan.m@cba.lk,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('INACTIVE_ALERT',NULL,NULL,'ashan.m@cba.lk,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('TRAN_AMOUNT',NULL,NULL,'ashan.m@cba.lk,layantha95@gmail.com,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('TRAN_VELOCITY',NULL,NULL,'ashan.m@cba.lk,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('TERMINAL_CREATION',NULL,NULL,'ashan.m@cba.lk,ashanbm@gmail.com','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');


INSERT INTO CBADigitalReceipt.dbo.TASK_CONFIG (createdAt,updatedAt,action,cron,isEnabled,period,value) VALUES
	 ('2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','UNSETTLED_ALERT','0 0/3 * * * ?',0,24,0),
	 ('2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','INACTIVE_ALERT','0 0/3 * * * ?',0,24,0),
	 ('2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','TRAN_AMOUNT','0/30 * * * * ?',1,0,500000),
	 ('2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','TRAN_VELOCITY','0 0/3 * * * ?',0,48,3),
	 ('2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','FAILED_FREQUENCY','0 0/3 * * * ?',0,72,1),
	 ('2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','TIMEOUT_FREQUENCY','0 0/3 * * * ?',0,72,1);

INSERT INTO CBADigitalReceipt.dbo.STATUS (status_code,status_description,createdAt,updatedAt) VALUES
	 ('ACTV','Active','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('BATC','Batch Uploading','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('COMP','Completed','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('DACT','De Active','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('DELT','Deleted','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('FAIL','Failed','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('PROC','Processing','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('REVC','Reversal Completed','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('REVH','Reversal Handaling','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('PEND','Pending','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('REVP','Reversal pending','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000'),
	 ('VOID','Voided transaction','2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000');

INSERT INTO CBADigitalReceipt.dbo.OPERATION (id,createdAt,updatedAt,operationcode,description,status) VALUES
	 (1,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','MSG','Message-operation','ACTV'),
	 (2,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','DIN','Get Device Info','ACTV'),
	 (3,'2024-05-06 14:05:10.1150000','2024-05-06 14:05:10.1150000','SET','Settlement Operation','ACTV');

CREATE TABLE CBADigitalReceipt.dbo.SequelizeMeta (
	name varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Sequeliz__72E12F1AAA3A5C76 PRIMARY KEY (name),
	CONSTRAINT UQ__Sequeliz__72E12F1B8A17BE98 UNIQUE (name)
);
