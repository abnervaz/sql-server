/************************************************************************
*	Description: Procura por rotinas como PROC, FUNCTION E TRIGGER								
*																		
*	Parameters.: @TextoProcurado => Especifica o valor a ser pesquisado				
*
*																		
*************************************************************************/
--ROTINAS (PROCS, FUNCTIONS, TRIGGERS)
DECLARE @TextoProcurado VARCHAR(MAX)
SET @TextoProcurado = 'foto'
--========================================================
SELECT   SPECIFIC_CATALOG
  ,ROUTINE_TYPE
  ,SPECIFIC_SCHEMA
  ,SPECIFIC_NAME
  ,ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE '%' + @TextoProcurado  + '%'
ORDER BY ROUTINE_TYPE, SPECIFIC_SCHEMA, SPECIFIC_NAME
--========================================================
