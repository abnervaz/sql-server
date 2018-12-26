/************************************************************************
*	Description: Query para busca dentro do conteúdo XML						
*																				
*************************************************************************/
select
  *
from
  MyTable
where
  Roles.value('(/root/role)[1]', 'varchar(max)') = 'StringToSearchFor'
