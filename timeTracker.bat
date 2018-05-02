@ECHO OFF
title Lets Get To Work
:: David Cote 2018
:: Replace the variable PROGRAM and PLAYLIST by the path of your software ".exe" file or shortcut ".lnk".
:: You can add specific start options to the shortcut of your program. Just right click on it and select "properties"
:: e.g. PROGRAM="nameOfProgram.exe"
::      SHORTCUT="C:\Users\Public\Desktop\Shortcut.lnk"
::      PLAYLIST="C:\Users\Username\Music\playlistFile.ext"
:top
SET PROGRAM=audacity.exe
SET SHORTCUT="C:\Users\Public\Desktop\Audacity.lnk"
SET PLAYLIST="D:\music\thrice_movingmountains.mp3"
SET THEMSG
echo ======================Let's Get to Work================================
echo 0.  Start Software alone
echo 1.  Start a Music Playlist, Start Software, Start Timer 
echo 2.  Start a Music Playlist, Start Timer
echo 3.  Start the Timer
echo 4.  Stop the Timer
echo 5.  Check Timer Status
echo 6.  Check Software Status
echo 7.  Force Start Software from ShortCut + Timer
echo 8.  Add Notes ( or addNote %NOTE%)
echo 9.  Open the Git Folder
echo C.  Clear(C)
echo 11. Quit(Q or Exit)
echo.
echo =======================================================================
echo The timer entry will be stored in timeTracker.log
echo e.g. "%date% - Started working at %time%"
echo =======================================================================
echo %THEMSG%
SET INPUT=
SET /P INPUT=Please select a number:
::IF /I '%INPUT%'=='1' CALL:StartShortcut&CALL:StartMusic&CALL:StartTimer
IF /I '%INPUT%'=='0' CALL:StartSoftware
IF /I '%INPUT%'=='1' CALL:Trio
IF /I '%INPUT%'=='2' CALL:StartTimer&CALL:StartMusic
IF /I '%INPUT%'=='3' GOTO:StartTimer
IF /I '%INPUT%'=='4' GOTO:StopTimer
IF /I '%INPUT%'=='5' GOTO:TimerStatus
IF /I '%INPUT%'=='6' GOTO:CheckRun
IF /I '%INPUT%'=='7' CALL:StartSoftware&CALL:StartTimer
IF /I '%INPUT%'=='8' GOTO:AddNote
IF /I '%INPUT%'=='addnote' GOTO:AddNote
IF /I '%INPUT%'=='9' GOTO:CodeRepo
IF /I '%INPUT%'=='C' GOTO:Clear
IF /I '%INPUT%'=='Q' GOTO:Quit
IF /I '%INPUT%'=='11' GOTO:Quit
IF /I '%INPUT%'=='exit' GOTO:Quit

:Trio
echo =======================================================================
echo The Music is Starting
echo The Timer is Starting
echo Software is Starting
echo =======================================================================
SET THEMSG=## The Music, the Timer and the Software are starting ##
start "" /b %PLAYLIST%
start "" /b %SHORTCUT%
goto StartTimer

:StartShortcut
SET THEMSG=### The Shortcut is launching ###
start "" /b %SHORTCUT%

:StartMusic
echo =======================================================================
echo The Music is Starting
echo =======================================================================
SET THEMSG=### The Playlist is Starting ###
start "" /b %PLAYLIST%
goto top

:CheckRun
SETLOCAL EnableExtensions
set EXE=%PROGRAM%
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto FOUND
echo =======================================================================
echo CheckRun: Software is not started
echo =======================================================================
SET THEMSG=## CheckRun: Software is not started ##
cls
goto top

:StartSoftware
SETLOCAL EnableExtensions
set EXE=%PROGRAM%
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto FOUND
echo =======================================================================
echo CheckRun: Software is starting
echo =======================================================================
SET THEMSG=## CheckRun: Software is starting ##
start "" /b %SHORTCUT%
goto top

:FOUND
echo =======================================================================
echo Software is already Running
echo =======================================================================
SET THEMSG=### Software is already Running ###
goto top

:StartTimer
echo %date% - Started working at %time% >> timeTracker.log
echo =======================================================================
echo Timer Started
echo =======================================================================
SET THEMSG=### Timer Started at %time% ###
goto top

:StopTimer
echo %date% - Stopped working at %time% >> timeTracker.log
echo =======================================================================
echo Timer Stopped
echo %date% - Stopped working at %time%
echo =======================================================================
SET THEMSG=### Timer Started at %time% ###
goto top

:TimerStatus
for /f "delims==" %%a in (timeTracker.log) do set lastline=%%a
cls
echo =======================================================================
echo Timer Status
echo Last Entry : %lastline%
echo =======================================================================
pause
goto top


:AddNote
echo =======================================================================
echo Add Notes
SET INPUT=
SET /P INPUT=Enter Notes:
echo =======================================================================
echo %date% - Notes: %INPUT% (%time%) >> timeTracker.log
goto top

:CodeRepo
start "" /b "C:\git\"
goto top

:Clear
cls
goto top

:Quit
cls
echo Ciao Bye!
exit