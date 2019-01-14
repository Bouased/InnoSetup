@echo off

SETLOCAL
pushd "%~dp0"

echo erasing...
del /S *.dcu *.ddp *.dsk *.~* *.cfg *.drc *.dsm *.local *.identcache %1 %2 %3 %4 %5 %6 %7 %8 %9 >NUL
if NOT "%1" == "all" goto LEAVE

del /S output\*.exe >NUL
del /S files\Compil32.* >NUL
del /S files\ISCC.* >NUL
del /S files\*.e32 >NUL
del /S files\ISCmplr.* >NUL
del /S files\ISPP.* >NUL

del /S help\ishelp\*_generated.* >NUL
del /S help\ishelp\Staging\contents.htm >NUL
del /S help\ishelp\Staging\contentsindex.js >NUL
del /S help\ishelp\Staging\*_generated_*.* >NUL
del /S help\ishelp\Staging\*.chm >NUL
del /S help\ishelp\Staging\topic_*.htm >NUL

del /S help\ispphelp\*_generated.* >NUL
del /S help\ispphelp\Staging\contents.htm >NUL
del /S help\ispphelp\Staging\contentsindex.js >NUL
del /S help\ispphelp\Staging\*_generated_*.* >NUL
del /S help\ispphelp\Staging\*.chm >NUL
del /S help\ispphelp\Staging\topic_*.htm >NUL

:LEAVE

popd
ENDLOCAL
