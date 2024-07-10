DECLARE @SchemaName NVARCHAR(128)
SET @SchemaName = 'dbo'
DECLARE @TableName NVARCHAR(128)
DECLARE @DropStatement NVARCHAR(MAX)

DECLARE TableCursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = @SchemaName AND TABLE_TYPE = 'BASE TABLE'

OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @DropStatement = 'DROP TABLE ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName)
    EXEC sp_executesql @DropStatement
    FETCH NEXT FROM TableCursor INTO @TableName
END

CLOSE TableCursor
DEALLOCATE TableCursor