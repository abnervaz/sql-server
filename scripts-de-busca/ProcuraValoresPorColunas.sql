    DECLARE @tables		TABLE(name varchar(100))
	DECLARE @result		TABLE(Tabela varchar(100))
	DECLARE @column		VARCHAR(20) = 'IDORGANIZACAO',
			@operador	CHAR(2) = '<>',
			@value		VARCHAR(20) = '1'

INSERT INTO @tables
	 SELECT TABLE_SCHEMA + '.' + TABLE_NAME 
	   FROM INFORMATION_SCHEMA.COLUMNS
	  WHERE LOWER(COLUMN_NAME) = LOWER(@column)

WHILE(EXISTS(SELECT * FROM @tables))
	BEGIN

		DECLARE @table VARCHAR(100),
				@query NVARCHAR(MAX)
		
		 SELECT @table = MIN(name) FROM @tables
		 SELECT @query = 'SELECT TOP 1 ''' + @table + ''' FROM ' + @table + ' WHERE ' + @column + @operador + @value

		INSERT INTO @result
		EXEC sys.sp_executesql @query

		DELETE FROM @tables WHERE name = @table		
	END

  SELECT * 
   FROM @result