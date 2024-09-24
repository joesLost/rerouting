CREATE OR ALTER PROCEDURE update_as_is_iteration
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;

    DROP TABLE IF EXISTS as_is_iteration;
    SELECT *
    INTO as_is_iteration
    FROM current_iteration;

    COMMIT TRANSACTION;

    BEGIN TRANSACTION;

    DROP TABLE IF EXISTS as_is_iteration_raw;
    SELECT *
    INTO as_is_iteration_raw
    FROM current_iteration_raw;

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    INSERT INTO Errortable (ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage, ErrorTime)
    VALUES (
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ERROR_PROCEDURE(),
        ERROR_LINE(),
        ERROR_MESSAGE(),
        CURRENT_TIMESTAMP
    );

    RETURN;
END CATCH
END;
