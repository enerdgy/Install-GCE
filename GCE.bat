@echo off
set Chrome=
IF %Chrome% == "" GOTO :EOF
set RegExt=0
set RegDef=1

C:
cd c:\

wmic product where "name like 'Google Chrome'" call uninstall /nointeractive

msiexec.exe /i %chrome% /qn

if "%RegExt%" == "1" REG ADD HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallBlacklist /v "1" /t REG_SZ /d "*" /f
if "%RegDef%" == "1" REG ADD HKLM\SOFTWARE\Policies\Google\Chrome /v "DefaultBrowserSettingEnabled" /t REG_DWORD /d "1" /f

EXIT

:EOF
