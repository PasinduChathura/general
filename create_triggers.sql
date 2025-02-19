CREATE TRIGGER tranTriggerInsert
ON Transactions
AFTER INSERT
AS
BEGIN
	INSERT INTO TranSummary(id, originId, paymentMode, custMobile, transType, cardLabel, traceNo, invoiceNo, amount, currency, batchNo, pan, merchantId, terminalId, dateTime, expDate, nii, rrn, authCode, signData, tipAmount, entryMode, dccCurrency, dccTranAmount, lat, lng, isAway, createdAt, updatedAt)
	SELECT id, originId, paymentMode, custMobile, transType, cardLabel, traceNo, invoiceNo, amount, currency, batchNo, pan, merchantId, terminalId, dateTime, expDate, nii, rrn, authCode, signData, tipAmount, entryMode, dccCurrency, dccTranAmount, lat, lng, isAway, createdAt, updatedAt
	FROM INSERTED;
END;

CREATE TRIGGER tranTriggerUpdate
ON Transactions
AFTER UPDATE
AS
BEGIN
  UPDATE TranSummary
  SET transType = (SELECT transType FROM INSERTED), 
      updatedAt = (SELECT updatedAt FROM INSERTED),
      isAway = (SELECT isAway FROM INSERTED)
  WHERE id = (SELECT id FROM INSERTED);
END;

UPDATE TranSummary 
    SET signData = (SELECT signData
        FROM Transactions
        WHERE TranSummary.id = Transactions.id
    );
