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
DROP TABLE IF EXISTS CBADigitalReceipt.Transactions ;
DROP TABLE IF EXISTS CBADigitalReceipt.Batches ;
DROP TABLE IF EXISTS CBADigitalReceipt.FileExports ;
DROP TABLE IF EXISTS CBADigitalReceipt.AuditLogs ;
DROP TABLE IF EXISTS CBADigitalReceipt.OneTimePasswords ;
DROP TABLE IF EXISTS CBADigitalReceipt.UserConfigs ;
DROP TABLE IF EXISTS CBADigitalReceipt.Users ;
DROP TABLE IF EXISTS CBADigitalReceipt.Terminals ;
DROP TABLE IF EXISTS CBADigitalReceipt.Merchants ;
DROP TABLE IF EXISTS CBADigitalReceipt.Partners ;
DROP TABLE IF EXISTS CBADigitalReceipt.Permissions ;
DROP TABLE IF EXISTS CBADigitalReceipt.Roles ;
DROP TABLE IF EXISTS CBADigitalReceipt.FailedSubmissions ;
DROP TABLE IF EXISTS CBADigitalReceipt.RECEIPT_DETAILS ;
DROP TABLE IF EXISTS CBADigitalReceipt.PUSHDEVICE_OPERATION ;
DROP TABLE IF EXISTS CBADigitalReceipt.DEVICE_STATUS ;
DROP TABLE IF EXISTS CBADigitalReceipt.PUSH_DEVICE ;
DROP TABLE IF EXISTS CBADigitalReceipt.DEVICES ;
DROP TABLE IF EXISTS CBADigitalReceipt.DEVICE_INFO ;
DROP TABLE IF EXISTS CBADigitalReceipt.DeviceConfigs ;
DROP TABLE IF EXISTS CBADigitalReceipt.Devices ;
DROP TABLE IF EXISTS CBADigitalReceipt.OPERATION ;
DROP TABLE IF EXISTS CBADigitalReceipt.STATUS ;
DROP TABLE IF EXISTS CBADigitalReceipt.SubscriptionResources ;
DROP TABLE IF EXISTS CBADigitalReceipt.Resources ;
DROP TABLE IF EXISTS CBADigitalReceipt.Subscriptions ;
DROP TABLE IF EXISTS CBADigitalReceipt.Currencies ;
DROP TABLE IF EXISTS CBADigitalReceipt.email_config ;
DROP TABLE IF EXISTS CBADigitalReceipt.ConsumingServices ;
DROP TABLE IF EXISTS CBADigitalReceipt.MerchantCategoryCodes ;
DROP TABLE IF EXISTS CBADigitalReceipt.DeviceModels ;
DROP TABLE IF EXISTS CBADigitalReceipt.Venders ;
DROP TABLE IF EXISTS CBADigitalReceipt.ApplicationSignatures ;
DROP TABLE IF EXISTS CBADigitalReceipt.AppCodes ;
DROP TABLE IF EXISTS CBADigitalReceipt.AggregatedTransactions ;
DROP TABLE IF EXISTS CBADigitalReceipt.EReceipts ;
DROP TABLE IF EXISTS CBADigitalReceipt.PAPER_ROLL_STATUS ;
DROP TABLE IF EXISTS CBADigitalReceipt.TASK_CONFIG ;
DROP TABLE IF EXISTS CBADigitalReceipt.FailedTransactions ;
DROP TABLE IF EXISTS CBADigitalReceipt.SequelizeMeta ;
DROP TABLE IF EXISTS CBADigitalReceipt.TranSummary ;

