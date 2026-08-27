/*
---------------------------
Stored Procedure: Load Bronze Layer (Source -> Bronze)
---------------------------

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:

    EXEC bronze.load_bronze;

--------------------------
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        
        SET @batch_start_time = GETDATE();
    
        PRINT '--------------------------------';
        PRINT 'Loading bronze layer';
        PRINT '--------------------------------';

        PRINT '--------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating table : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting into table : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\SQLData\CRM\cust_info.csv'
        WITH (
	        FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );  
        SET @end_time = GETDATE();
        PRINT 'Loading Duration :' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating table : bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Insering into table : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\SQLData\CRM\prd_info.csv'
        WITH (
	        FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        ); 
        SET @end_time = GETDATE();
        PRINT 'Loading Duration :' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating table : bronze.crm_sls_info';
        TRUNCATE TABLE bronze.crm_sls_info;

        PRINT '>> Inserting into table : bronze.crm_sls_info';
        BULK INSERT bronze.crm_sls_info
        FROM 'C:\SQLData\CRM\sls_info.csv'
        WITH (
	        FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Duration : :' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'

        PRINT '--------------------------------';
        PRINT 'Loading ERP tables';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating table : bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting into table : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\SQLData\ERP\CUST_az12.csv'
        WITH (
	        FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Duration :' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating table : bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting into table : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\SQLData\ERP\LOC_A101.csv'
        WITH (
	        FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Duration :' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'

        SET @start_time = GETDATE();
        PRINT '>> Truncating table : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting table : bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\SQLData\ERP\PX_CAT_G1V2.csv'
        WITH (
	        FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading Duration :' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'

        SET @batch_end_time = GETDATE();
        PRINT '-----------------------'
        PRINT 'Loading bronze layer is completed'
        PRINT 'Total Duration time :' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds'
        PRINT '-----------------------'
    END TRY

    BEGIN CATCH
            PRINT '----------------------------------';
            PRINT 'Error occured during bronze layer';
            PRINT 'Error message' + ERROR_MESSAGE();
            PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
            PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
            PRINT '----------------------------------';
    END CATCH
END

/*
For my refernce purpose to get clarification
EXEC xp_fileexist 'C:\SQLData\CRM\prd_info.csv';

EXEC xp_dirtree 'C:\SQLData\prd_info.csv', 1, 1;
-------------------------------------------------------

EXEC xp_fileexist 'C:\SQLData\CRM\prd_info.csv';

EXEC xp_dirtree 'C:\SQLData\CRM\prd_info.csv', 1, 1;
--------------------------------------------------------
EXEC xp_fileexist 'C:\SQLData\CRM\sls_info.csv';

EXEC xp_dirtree 'C:\SQLData\CRM\sls_info.csv', 1, 1;
-----------------------------------------------------------
EXEC xp_fileexist 'C:\SQLData\ERP\CUST_az12.csv';

EXEC xp_dirtree 'C:\SQLData\ERP\CUST_az12.csv', 1, 1;
----------------------------------------------------
EXEC xp_fileexist 'C:\SQLData\ERP\LOC_A101.csv';

EXEC xp_dirtree 'C:\SQLData\ERP\LOC_A101.csv', 1, 1;
-------------------------------------------------------
EXEC xp_fileexist 'C:\SQLData\ERP\PX_CAT_G1V2.csv';

EXEC xp_dirtree 'C:\SQLData\ERP\PX_CAT_G1V2.csv', 1, 1;




SELECT COUNT(*) FROM bronze.crm_cust_info

SELECT * FROM bronze.crm_cust_info 

SELECT * FROM bronze.crm_cust_info

SELECT * FROM bronze.crm_prd_info

SELECT * FROM bronze.crm_sls_info

SELECT * FROM bronze.erp_cust_az12

SELECT * FROM bronze.erp_loc_a101

SELECT * FROM bronze.erp_px_cat_g1v2 */

--EXEC bronze.load_bronze
