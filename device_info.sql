DROP TABLE IF EXISTS CBADigitalReceipt.dbo.DEVICE_INFO ;
CREATE TABLE CBADigitalReceipt.DEVICE_INFO (
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
	CONSTRAINT FK__DEVICE_IN__devic__3A379A64 FOREIGN KEY (device_id) REFERENCES CBADigitalReceipt.Devices(id) ON DELETE CASCADE
);
