DECLARE @Procedure VARCHAR(100) = '' -- PARÂMETRO
/*******************************************************************
********************************************************************
********************************************************************/
DECLARE @dataBases	TABLE(name varchar(100), row int)
DECLARE @result TABLE (
	[database] varchar(50)
)
DECLARE @row		INT

INSERT INTO @dataBases
SELECT b.name, ROW_NUMBER () OVER(ORDER BY b.database_id) AS r 
  FROM sys.databases AS b 
 WHERE b.state = 0 -- Somente bases ativas

SELECT @row = MAX(row) FROM @dataBases

WHILE @row > 0
BEGIN
	
		DECLARE @command NVARCHAR(1000)	
		SELECT
			@command = 
			'BEGIN USE ' + name + ' IF(EXISTS(SELECT 1 FROM sys.tables AS T JOIN sys.schemas AS S ON S.schema_id = T.schema_id WHERE S.name = ''Usuarios'' AND T.name = ''Usuarios''))' +
			'BEGIN
			SELECT
					''' + name + ''' 
					WHERE NOT EXISTS(
					SELECT M.object_id
					FROM sys.all_sql_modules AS M
					JOIN sys.procedures AS P
						ON M.object_id = P.object_id
					WHERE P.name = ''' + @Procedure + ''')			
				END	
			END'
				FROM @dataBases WHERE row = @row

		INSERT INTO @result
		EXEC sys.sp_executesql @command

	SELECT @row = @row - 1
 END

SELECT * FROM @result
