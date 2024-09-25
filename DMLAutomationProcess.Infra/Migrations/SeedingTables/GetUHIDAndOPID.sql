CREATE OR ALTER PROCEDURE [dbo].GetUHIDAndOPID
AS
BEGIN
    -- Declare variables for UHID and OPID generation
    DECLARE @datePrefix NVARCHAR(8);   -- To store the date prefix for UHID and OPID
    DECLARE @nextId INT;               -- To store the next sequence number
    DECLARE @formattedId NVARCHAR(4);  -- To store the formatted sequence number
    DECLARE @uhID NVARCHAR(12);        -- To store the generated UHID
    DECLARE @opID NVARCHAR(13);        -- To store the generated OPID (length adjusted to account for appended '1')

    -- Get today's date
    DECLARE @tomorrowDate DATE = GETDATE();

    -- Set the date prefix for UHID in yyyyMMdd format
    SET @datePrefix = FORMAT(@tomorrowDate, 'yyyyMMdd');

    -- Calculate the next sequence number for UHID
    -- Extract the numeric part of UHID after the date prefix
    SELECT @nextId = ISNULL(MAX(CAST(SUBSTRING(UHID, LEN(@datePrefix) + 1, LEN(UHID) - LEN(@datePrefix)) AS INT)), 0) + 1
    FROM OPRegistration
    WHERE UHID LIKE @datePrefix + '%';

    -- Format the UHID with zero-padding (4 digits for sequence part)
    SET @formattedId = RIGHT('0000' + CAST(@nextId AS VARCHAR(4)), 4);
    SET @uhID = @datePrefix + @formattedId;

    -- Set the date prefix for OPID in yyMMdd format
    SET @datePrefix = FORMAT(@tomorrowDate, 'yyMMdd');

    -- Generate OPID and append '1' at the end
    SET @opID = 'OP.' + @datePrefix + @formattedId + '1';

    -- Output the results
    SELECT @uhID AS NewUHID, @opID AS NewOPID, GETDATE() AS VisitDate;
END;

