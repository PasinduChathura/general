CREATE TRIGGER tranTriggerInsert
ON Transactions
AFTER INSERT
AS
BEGIN
    INSERT INTO TranSummary (originId, paymentMode, custMobile, transType, cardLabel, traceNo, invoiceNo, amount, currency, batchNo, pan, merchantId, terminalId, dateTime, expDate, nii, rrn, authCode, signData, tipAmount, entryMode, dccCurrency, dccTranAmount, lat, lng, isAway, createdAt, updatedAt)
    SELECT originId, paymentMode, custMobile, transType, cardLabel, traceNo, invoiceNo, amount, currency, batchNo, pan, merchantId, terminalId, dateTime, expDate, nii, rrn, authCode, signData, tipAmount, entryMode, dccCurrency, dccTranAmount, lat, lng, isAway, createdAt, updatedAt
    FROM INSERTED;
END;


CREATE TRIGGER tranTriggerUpdate
ON Transactions
AFTER UPDATE
AS
BEGIN
    UPDATE TranSummary
    SET TranSummary.transType = i.transType, 
        TranSummary.updatedAt = i.updatedAt,
        TranSummary.isAway = i.isAway
    FROM TranSummary t
    INNER JOIN INSERTED i ON t.id = i.id;
END;
