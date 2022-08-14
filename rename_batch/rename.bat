@ECHO OFF &setlocal enabledelayedexpansion
REM HKUST DSTO RENAME UTILITY 2022-08-15. WRITTEN BY X8336
REM RENAME .lpr TO <SID>.jpg 
REM 1. Read index.txt into Array
REM 	EXPECTED FILE FORMAT |22123444|530bbd14-1bd4-11ed-861d-0242ac120002|
REM 	EXPECTED FILE NAME 4356771a-1bd4-11ed-861d-0242ac120002.lpr
REM 2. Read Files of Current Directory, Write to File , Read to Array , Write to Log
REM 3. Compare and Rename Document 
REM 4. Delete filenames.txt
REM END 

REM CONFIG PARMS
SET EXT=.lpr
SET TARGET_EXT=.jpg
SET SOURCE="index.txt"
SET /A count=0


echo "Reading File"

for /F "tokens=1,2 delims=|" %%a in ('type %SOURCE%') do (
    set /A count+=1
    set "mapping[!count!].SID=%%a"
    set "mapping[!count!].UID=%%b"
)

REM DEBUG mapping
REM for /L %%i in (1,1,%count%) do echo !mapping[%%i].SID! !mapping[%%i].UID!

echo "Reading Files in Current Directory..."
dir *%EXT% /b /b >filenames.txt

SET /A count_file=0
for /F  %%a in (filenames.txt) do (
    set /A count_file+=1
    set "filename[!count_file!]=%%a"
)

REM DEBUG filename
REM for /L %%i in (1,1,%count_file%) do echo !filename[%%i]!

REM LOOKUP MAPPING AND RENAME FILE SID.jpg
for /L %%i in (1,1,%count_file%) do (
	for /L %%a in (1,1,%count%) do (
	 
      	   if "!filename[%%i]!" == "!mapping[%%a].UID!%EXT%" (
         		REN "!mapping[%%a].UID!%EXT%" "!mapping[%%a].SID!%TARGET_EXT%"
			echo "!mapping[%%a].UID!%EXT% RENAMED TO !mapping[%%a].SID!%TARGET_EXT%" >>execution.log
		)	 
	)
 )

del filenames.txt
echo "Rename Completed. Press any Key to Exit Or Close Terminal"
pause
