@ECHO OFF
SETLOCAL
::SETLOCAL EnableDelayedExpansion

REM -------------------------------------------------------------------------------

SET "_FILE_A=%UserProfile%\Documents\SpiderOak Hive\SysAdmin\Tools\Compare To\CompareTo-Parent.bat"
SET "_FILE_A=%UserProfile%\Documents\GitHub\Batch-Tools-SysAdmin\powershell-template (2).bat"
SET "_FILE_A=\\gammafox\C$\Users\G\Documents\SpiderOak Hive\Programming\Powershell\Templates\powershell-template.ps1"

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

SET "_FILE_B=%UserProfile%\Documents\SpiderOak Hive\SysAdmin\Configuring Systems\Boxstarter\Troubleshoot-BatchScript-CompareTo.bat"
SET "_FILE_B=%UserProfile%\Documents\GitHub\Batch-Tools-SysAdmin\powershell-template (2).bat"
SET "_FILE_B=\\gammafox\C$\Users\G\Documents\SpiderOak Hive\Programming\Powershell\Templates\powershell-template (2).ps1"

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

::-------------------------------------------------------------------------------

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

:EndParameters

REM -------------------------------------------------------------------------------

:Footer
:END
ENDLOCAL
ECHO: 
ECHO End %~nx0
ECHO: 
PAUSE
::GOTO :EOF
EXIT /B & REM If you call this program from the command line and want it to return to CMD instead of closing Command Prompt, need to use EXIT /B or no EXIT command at all.
