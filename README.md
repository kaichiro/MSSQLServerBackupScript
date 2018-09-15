# MSSQLServerBackupScript
Arquivos para automatismo de rotina de backup de base de dados Microsoft SQLServer, compactação (utilizando WinRAR) e exclusão de arquivos antigos em diretórios distintos (configurável).

Vamos lá, mão na massa, ops, código!
Seguindo os passos logo abaixo, você conseguirá, de forma simples, rápida e segura, configurar um automatismo para efetuar backups de base de dados SQL Server.
---------------------------
## - Primeiro Passo => clone ou baixe os arquivos deste projeto (Script.Backup.Full.bat, Script.Backup.Full.sql).
## - Segundo passo => configurar o arquivo (Script.Backup.Full.bat) responsável por toda a configuração/parametrização da rotina.
- Abrindo este arquivo, você encontrará algumas configurações/parâmetros que deverão ser preenchido de acordo com o contexto de trabalho.
- NOTA: as linhas que começam com `echo` são comentários e não serão executadas, caso desejar, poderá retirá-las do corpo do script.
```sh
echo Instância do serviço do SQL Server
set SQLServerInstance=.
echo Nome do usuário de acesso ao banco de dados
set SQLServerUser=sa
echo Senha do usuário de acesso ao banco de dados
set SQLServerPassword=Senha
echo Diretório absoluto e nome do arquivos de script SQL
set FileNameScriptBackup=C:\iLabor.NET\Scripts\Bkps\Script.Backup.Full.sql
echo Nome da base de dados em questão
set DataBaseName=iLabor
echo Diretório absoluto e nome de um arquivo de saída de informações
echo (arquivo apenas de status, não é o arquivo de backup)
set FileNameOutputInfo=C:\iLabor.NET\DB.Bkp\Script.Backup.Full.out.txt
echo Diretório absoluto do arquivos de backup (arquivo.bak)
set PathBackupFile=C:\iLabor.NET\DB.Bkp
echo Diretório absoluto para os arquivos compactados (*.rar)
set PathBackupFileCompacted=C:\iLabor.NET\DB.Bkp.Compacted
echo Diretório absoluto e nome do executável de compactação
set PathOfCompactor="C:\Program Files\WinRAR\WinRAR.exe"
echo Tamanho do arquivo de compactação
set FileRarSize=100
echo Quantidade de dias a ser preservado os arquivos de backup compactados
set QtdeDiasPreservarRAR=10
echo Quantidade de dias a ser preservado os arquivos de backup
set QtdeDiasPreservarBAK=7
```

## CONSIDERAÇÕES FINAIS
- Não há necessidade de configurar/modificar o arquivo Script.Backup.Full.sql (arquivo de criação do arquivo de backup SQL Server), pois o mesmo recebe todos os dados, via passagem de parâmetros, do arquivo Script.Backup.Full.bat.
