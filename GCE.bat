@echo off

::This removes then installs google chrome enterprise 64 bit
::created on 2/6/18
::Author: Robert R.

::Set Variables
    ::set chrome can be local or network share
	    ::ex1 - set chrome=c:\temp\googlechromestandaloneenterprise64.msi
        ::ex2 - set chrome=\\server\share\googlechromestandaloneenterprise64.msi
    set Chrome=
    ::The next line checks to see if Chrome variable is set and exits if its null
    IF %Chrome% == "" GOTO :EOF
    set RegExt=0
    set RegDef=1

::set working Drive and working directory
    C:
    cd c:\

::Remove Google Chrome if it already is installed
    wmic product where "name like 'Google Chrome'" call uninstall /nointeractive

::Install Google Chrome from path
	msiexec.exe /i %chrome% /qn

::Add Registry keys
	::Disable all extentions on Computer if regext=1
		if "%regext%" == "1" (
            REG ADD HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallBlacklist /v "1" /t REG_SZ /d "*" /f
        )
	
	::Force Google Chrome as default Browser
		if "%regext%" == "1" (
            REG ADD HKLM\SOFTWARE\Policies\Google\Chrome /v "DefaultBrowserSettingEnabled" /t REG_DWORD /d "1" /f
        )
EXIT

:EOF
