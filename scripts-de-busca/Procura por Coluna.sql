/************************************************************************
*	Description: Procura por uma determinada coluna							
*																		
*	Parameters.: @TextoProcurado => Especifica o valor a ser pesquisado				
*
*																		
*************************************************************************/
DECLARE @TextoProcurado VARCHAR(MAX)
SET @TextoProcurado = 'imagem'
--========================================================
SELECT   TABLE_CATALOG
	,TABLE_SCHEMA
	,TABLE_NAME
	,COLUMN_NAME
	,DATA_TYPE
	,CHARACTER_MAXIMUM_LENGTH
	,NUMERIC_PRECISION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%' + @TextoProcurado  + '%'
ORDER BY TABLE_NAME, COLUMN_NAME
--========================================================
--========================================================
