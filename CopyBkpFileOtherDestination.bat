echo   Este programa faz uma cópia dos arquivos de backup para 
echo um diretorio na rede ou ftp (desde que seja transparente)
echo e depois deleta arquivos antigos.
echo ---------------------------------------------------------

echo   Modifique apenas as variaveis dentro do scopo configuracao
echo de Variaveis. BEGIN...END

echo <<< /// BEGIN - configuracao de variaveis \\\ >>>
set DestinationFolder="\\NomeOuIP\Diretorio"
set OriginFolder="D:\Diretorio\Backup"
set ExFile=*.rar
set DelFileLongerThanDays=3
set UnitMaped=k
echo <<< \\\ END - configuracao de variaveis /// >>>

cls
echo Inicio cfg data
@echo off
 
set date1=today
set qty=-1
set separator=%~3
 
if /i "%date1%" EQU "TODAY" (set date1=now) else (set date1="%date1%")
echo >"%temp%\%~n0.vbs" s=DateAdd("d",%qty%,%date1%)
echo>>"%temp%\%~n0.vbs" d=weekday(s)
echo>>"%temp%\%~n0.vbs" WScript.Echo year(s)^&_
echo>>"%temp%\%~n0.vbs" right(100+month(s),2)^&_
echo>>"%temp%\%~n0.vbs" right(100+day(s),2)^&_
echo>>"%temp%\%~n0.vbs" d
for /f %%a in ('cscript //nologo "%temp%\%~n0.vbs"') do set result=%%a
del "%temp%\%~n0.vbs"
endlocal& (
set "YY=%result:~0,4%"
set "MM=%result:~4,2%"
set "DD=%result:~6,2%"
set "daynum=%result:~-1%"
)
if %daynum% EQU 1 set "weekday=Sunday"
if %daynum% EQU 2 set "weekday=Monday"
if %daynum% EQU 3 set "weekday=Tuesday"
if %daynum% EQU 4 set "weekday=Wednesday"
if %daynum% EQU 5 set "weekday=Thursday"
if %daynum% EQU 6 set "weekday=Friday"
if %daynum% EQU 7 set "weekday=Saturday"
 
set dt=%DD%/%MM%/%YY%
echo Fim cfg data


cd %OriginFolder%

forfiles /M *.rar /D %dt% /C "cmd /c COPY /Y @file %DestinationFolder%"



net use %UnitMaped%: %DestinationFolder%
%UnitMaped%:
forfiles /M %ExFile% /D -%DelFileLongerThanDays% /C "cmd /c del @file "
net use %UnitMaped%: /delete /Y
