@ECHO OFF &setlocal enabledelayedexpansion
REM CONFIG
SET EXT=".lpr"
SET SOURCE="index.txt"
SET /A count=0

REM CONFIG CURRENT DRIVE MOUNT

echo "Reading File"

for /F "tokens=1,2 delims=|" %%a in ('type %SOURCE%') do (
    set /A count+=1
    set "mapping[!count!].SID=%%a"
    set "mapping[!count!].UID=%%b"
)

REM DEBUG mapping
REM for /L %%i in (1,1,%count%) do echo !mapping[%%i].SID! !mapping[%%i].UID!

echo "Reading Files in Current Directory..."


echo "Rename Completed. Press any Key to Exit Or Close Terminal"
pause
