@echo off

rem  Inno Setup
rem  Copyright (C) 1997-2012 Jordan Russell
rem  Portions by Martijn Laan
rem  For conditions of distribution and use, see LICENSE.TXT.
rem
rem  Batch file to compile all projects without Unicode support

setlocal
Setlocal EnableDelayedExpansion

if exist ..\..\compilesettings.bat goto compilesettingsfound
:compilesettingserror
echo compilesettings.bat is missing or incomplete. It needs to be created
echo with the following lines, adjusted for your system:
echo.
echo   set DELPHIROOT=c:\delphi2              [Path to Delphi 2 (or later)]
echo   set DELPHI3ROOT=c:\delphi3             [Path to Delphi 3 (or later)]
echo   set DELPHI7ROOT=c:\delphi7             [Path to Delphi 7 (or later)]
goto failed2

:compilesettingsfound
set DELPHIROOT=
set DELPHI3ROOT=
set DELPHI7ROOT=
call ..\..\compilesettings.bat
if "%DELPHIROOT%"=="" goto compilesettingserror
if "%DELPHI3ROOT%"=="" goto compilesettingserror
if "%DELPHI7ROOT%"=="" goto compilesettingserror

cd /d %~dp0

echo - Compilation des ressources

if NOT "%1" == "unicode" goto unicode
if NOT "%1" == "ansi" goto ansi
rem -------------------------------------------------------------------------

rem  Compile each project separately because it seems Delphi
rem  carries some settings (e.g. $APPTYPE) between projects
rem  if multiple projects are specified on the command line.

:ansi
cd ansi
if errorlevel 1 goto failed
rem http://docwiki.embarcadero.com/RADStudio/Tokyo/fr/BRCC32.EXE,_le_compilateur_de_ressources
FOR %%G IN ("%~dp0*.rc") DO (
 if  "%%G" == "%~dp0HelperEXEs.rc" (
	 "%DELPHI2007ROOT%\bin\BRCC32.exe" -v "%%G"
	 if errorlevel 1 goto failed 
 ) else (
	 "%DELPHI2007ROOT%\bin\CGRC.exe" -v "%%G"
	 if errorlevel 1 goto failed
 )
)

goto done

:unicode
cd unicode
if errorlevel 1 goto failed
FOR %%G IN ("%~dp0*.rc") DO (
 if  "%%G" == "%~dp0HelperEXEs.rc" (
	 "%DELPHI2009ROOT%\bin\BRCC32.exe" -v "%%G"
	 if errorlevel 1 goto failed 
 ) else (
	 "%DELPHI2009ROOT%\bin\CGRC.exe" -v "%%G"
	 if errorlevel 1 goto failed
 )
)

:done
echo Success!
cd ..
goto exit

:failed
echo *** FAILED ***
cd ..
:failed2
exit /b 1

:exit
