DECLARE @DBNAME varchar(300)
set @DBNAME = '$(vDBName)'


DECLARE @dateTime NVARCHAR(20)
set @dateTime = '$(vDataHora)'


DECLARE @BackupFile varchar(100)
SET @BackupFile = '$(vFileNameBkp)'

-- Fornecer um nome para o backup para armazenar na mídia
DECLARE @BackupName varchar(100)
SET @BackupName = REPLACE(REPLACE(@DBNAME,'[',''),']','') +' full backup for '+ @dateTime

-- Gerar o comando SQL dinâmico a ser executado
DECLARE @sqlCommand NVARCHAR(1000) 
SET @sqlCommand = 'BACKUP DATABASE ' +@DBNAME+  ' TO DISK = '''+@BackupFile+ ''' WITH INIT, NAME= ''' +@BackupName+''', NOSKIP, NOFORMAT'

-- Executar o comando SQL gerado
EXEC(@sqlCommand)
