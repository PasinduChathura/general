CREATE PROCEDURE dbo.CHECK_AND_UPDATE_DEVICE_STATUS
AS 
BEGIN
    DECLARE @diff_minutes INT;
    
    -- Set the number of minutes after which a device is considered inactive
    SET @diff_minutes = 10;
    
    UPDATE device_status
    SET device_status = 'DACT'
    WHERE device_status = 'ACTV'
    AND DATEDIFF(MINUTE, last_updated_time, GETDATE()) > @diff_minutes;
END
