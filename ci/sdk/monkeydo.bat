@echo off

REM allow runtime variable assignment to non-existing environment variables (i.e. constants)
setlocal enabledelayedexpansion

REM Check to make sure the required arguments are provided
IF "%~1"=="/?" GOTO usage   REM Handle Windows standard help command
IF "%~2"=="" GOTO usage     REM Handle not enough arguments. We require the executable and device ID to be passed.

IF "%~3" NEQ "" (
    REM Make sure test test flag is correct
    IF "%~3"=="/t" (
        GOTO parse_args
    ) ELSE (
        GOTO usage
    )
)

:parse_args
REM Parse the command line arguments
SET prg_path=%1
SHIFT /1
SET device_id=%1
SHIFT /1
SET test_flag=%1
SHIFT /1

IF "%test_flag%" NEQ "" (
    SET test_flag=-t
)

SET test_names=

:get_test_names
IF "%~1" NEQ "" (
    SET test_names=%test_names% "%~1"
    SHIFT /1
    GOTO :get_test_names
)

REM Get the constant arguments from the command line
SET home=%~dp0

REM Execute the call to shell
java -classpath "%home%monkeybrains.jar" com.garmin.monkeybrains.monkeydodeux.MonkeyDoDeux -f %prg_path% -d %device_id% -s "%home%shell.exe" %test_flag% %test_names%
GOTO :eof  rem Skip past the usage block

rem Print the help/usage information for this script
:usage
@echo Pushes and runs a Connect IQ executable on the Connect IQ simulator. The simulator must be running for this command to succeed.
@echo.
@echo Usage: %0 executable device_id ^[/t ^| /t test_name^]
@echo     executable - A Connect IQ executable to run.
@echo     device_id  - The device to simulate.
@echo     test_name  - When providing the test flag you may specify a one or more test names.
endlocal
exit /B 1
