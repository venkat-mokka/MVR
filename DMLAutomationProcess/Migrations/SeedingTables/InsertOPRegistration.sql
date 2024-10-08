USE [Database]
GO
/****** Object:  StoredProcedure [dbo].[InsertOPRegistration]    Script Date: 02-09-2024 17:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertOPRegistration]
    @PatientID INT,
    @OPID NVARCHAR(20),
    @VisitDate DATETIME,
    @IsMlcCase BIT = NULL,
    @IsEmergencyCase BIT = NULL,
    @DepartmentID INT = NULL,
    @SpecialityID INT = NULL,
    @DoctorID INT = NULL,
    @FeeTypeID INT = NULL,
    @ReferredBy NVARCHAR(50),
    @CreatedDate DATETIME = NULL,
    @IsActive BIT
AS
BEGIN
    -- Use TRY-CATCH to handle potential errors
    BEGIN TRY
        -- Insert into OPRegistration table
        INSERT INTO OPRegistration (
            PatientID,
            OPID,
            VisitDate,
            IsMlcCase,
            IsEmergencyCase,
            DepartmentID,
            SpecialityID,
            DoctorID,
            FeeTypeID,
            ReferredBy,
            CreatedDate,
            IsActive
        )
        VALUES (
            @PatientID,
            @OPID,
            @VisitDate,
            @IsMlcCase,
            @IsEmergencyCase,
            @DepartmentID,
            @SpecialityID,
            @DoctorID,
            @FeeTypeID,
            @ReferredBy,
            @CreatedDate,
            @IsActive
        );

        -- Optional: Return the ID of the inserted record (if you have an identity column)
        SELECT SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        -- Handle errors here (log them, rethrow them, etc.)
        THROW;
    END CATCH
END
