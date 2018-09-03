@echo off

echo A sessao abaixo, configuração de variáveis, é dedicada
echo para configurar variáveis locais de parametrização deste
echo automatismo de backup.
echo Inicialmente, este, irá conectar ao servidor SQL Server,
echo por meio do utilitário SqlCmd irá chamar um arquivo de 
echo execução de instrução SQL, passando parâmetros, que por 
echo sua vez iniciará o processo de backup, logo após, irá
echo compactar (WinRAR) para um diretório auxiliar e por fim,
echo de acordo com as configurações abaixo, irá excluir, por
echo prazo de dias, arquivos (.bak e .rar) antigos.

echo /// Inicio de configuração de variáveis \\\

set SQLServerInstance=.
set SQLServerUser=sa
set SQLServerPassword=Senha
set FileNameScriptBackup=C:\iLabor.NET\Scripts\Bkps\Script.Backup.Full.sql
set DataBaseName=iLabor
set FileNameOutputInfo=C:\iLabor.NET\DB.Bkp\Script.Backup.Full.out.txt
set PathBackupFile=C:\iLabor.NET\DB.Bkp
set PathBackupFileCompacted=C:\iLabor.NET\DB.Bkp.Compacted
set PathOfCompactor="C:\Program Files\WinRAR\WinRAR.exe"
set FileRarSize=100
set QtdeDiasPreservarRAR=10
set QtdeDiasPreservarBAK=7

echo \\\ Final de configuração de variáveis ///

echo ATENCAO, procure não modificar abaixo desta linha.

echo Convertendo (%FileRarSize%) em MB
set /a FileRarSize=%FileRarSize%*1024

date /t
set data=%date%
set ano=%data:~6,4%
set mes=%data:~3,2%
set dia=%data:~0,2%
set data=%ano%.%mes%.%dia%
time /t
set horario=%time%
set hh=%horario:~0,2%
set mm=%horario:~3,2%
set ss=%horario:~6,2%
set horario=%hh%.%mm%.%ss%

set DataHora=%data%-%horario%
set DataHora=%DataHora: =0%

set FileNameBKP=%DataBaseName%.Backup.FULL-%DataHora%.bak

cls

echo Configurando o nome e diretório absoluto para o arquivo de backup
set BackupFullFileName=%PathBackupFile%\%FileNameBKP%

echo Executando o processo de backup
sqlcmd -S %SQLServerInstance% -U %SQLServerUser% -P %SQLServerPassword% -i %FileNameScriptBackup% -o %FileNameOutputInfo% -v vDBName ="%DataBaseName%" -v vFileNameBkp ="%BackupFullFileName%" -v vDataHora ="%DataHora%"

echo Compactando o arquivo
%PathOfCompactor% a -ep1 -v%FileRarSize% %PathBackupFileCompacted%\%FileNameBKP%.rar %BackupFullFileName%

echo Excluindo arquivos .bak do diretório de bakcup (%PathBackupFile%)
forfiles /P %PathBackupFile% /S /D -%QtdeDiasPreservarBAK% /M *.bak /C "cmd /c del @file"

echo Excluindo arquivos .rar do diretório de compactados (%PathBackupFileCompacted%)
forfiles /P %PathBackupFileCompacted% /S /D -%QtdeDiasPreservarRAR% /M *.bak /C "cmd /c del @file"
