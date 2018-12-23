/************************************************************************
*	Description: Efetua uma busca no conteúdo dos objetos por uma 
*				 referência especifica em todas as bases								
*																		
*	Parameters.: @object => Especifica a referência a ser pesquisada
*							nas bases					
*	
*	ESSE SCRIPT PODE DEMORAR PARA SER EXECUTADO																
*************************************************************************/
DECLARE @object varchar(200) = ''
DECLARE @dataBases	TABLE(name varchar(100), row int)
DECLARE @result TABLE (
	[database] varchar(50),
	[object] varchar(200),
	[type] varchar(200)
)
DECLARE @row		INT

INSERT INTO @dataBases
SELECT b.name, ROW_NUMBER () OVER(ORDER BY b.database_id) AS r 
  FROM sys.databases AS b 
 WHERE b.state = 0

SELECT @row = MAX(row) FROM @dataBases

WHILE @row > 0
BEGIN
	
		DECLARE @command NVARCHAR(1000)	
		SELECT
			@command = 
			'USE ' + name + '
			SELECT ''' + name + ''', 
				s.name + ''.'' + o.name AS object
			   ,o.type_desc
			FROM sys.objects AS o
			JOIN sys.all_sql_modules AS m
				ON m.object_id = o.object_id
			JOIN sys.schemas AS s
			ON s.schema_id = o.schema_id
			WHERE m.definition LIKE ''%' + @object + '%'''
				FROM @dataBases WHERE row = @row

		INSERT INTO @result
		EXEC sys.sp_executesql @command

	SELECT @row = @row - 1
 END

SELECT * FROM @result
