/************************************************************************
*	Description: Exibe uma série de informações sobre a instância 					
*																				
*************************************************************************/
SELECT
            SERVERPROPERTY('MachineName') AS [ServerName], 
			SERVERPROPERTY('ServerName') AS [ServerInstanceName], 
            SERVERPROPERTY('InstanceName') AS [Instance], 
            SERVERPROPERTY('Edition') AS [Edition],
            SERVERPROPERTY('ProductVersion') AS [ProductVersion], 
			Left(@@Version, Charindex('-', @@version) - 2) As VersionName


SELECT  
   CONNECTIONPROPERTY('net_transport') AS net_transport,
   CONNECTIONPROPERTY('protocol_type') AS protocol_type,
   CONNECTIONPROPERTY('auth_scheme') AS auth_scheme,
   CONNECTIONPROPERTY('local_net_address') AS local_net_address,
   CONNECTIONPROPERTY('local_tcp_port') AS local_tcp_port,
   CONNECTIONPROPERTY('client_net_address') AS client_net_address 
