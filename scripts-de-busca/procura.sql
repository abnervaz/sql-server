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
    

--COLUNAS
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



--PROCURA UM OBJETO EM TODOS AS BASES DO BANCO
sp_msforeachdb 'select "?" as Base from ?.sys.schemas WHERE name=''Tracking'''


--PROCURA DADOS EM XML
select
  Roles
from
  MyTable
where
  Roles.value('(/root/role)[1]', 'varchar(max)') like 'StringToSearchFor'