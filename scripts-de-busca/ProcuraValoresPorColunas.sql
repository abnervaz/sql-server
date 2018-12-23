/************************************************************************
*	Description: Procura em todas as tabelas um determinado	valor		
*		     de uma determinada coluna								
*																		
*	Parameters.: @column => Especifica o nome da coluna					
*		     @operator => Especifica o operador de comparação		
*		     @value => Especifica o valor para a coluna definida	
*																		
*************************************************************************/

    DECLARE @tables		TABLE(name varchar(100))
	DECLARE @result		TABLE(Tabela varchar(100))
	DECLARE @column		VARCHAR(20) = '',
			@operator	CHAR(2) = '<>',	
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
		 SELECT @query = 'SELECT TOP 1 ''' + @table + ''' FROM ' + @table + ' WHERE ' + @column + @operator + @value

		INSERT INTO @result
		EXEC sys.sp_executesql @query

		DELETE FROM @tables WHERE name = @table		
	END

  SELECT * FROM @result
