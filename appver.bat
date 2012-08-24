REM easier way how to handle version formats  https://github.com/safrm/appver
REM author:  Miroslav Safr <miroslav.safr@gmail.com>
REM version:

REM exists("C:\\progs\\Git\\bin\\sh.exe") {
REM     APP_VERSION_FULL=$$system("C:\\progs\\Git\\bin\\sh.exe" -c \"/bin/git describe --tags  --dirty=* 2> /dev/null  \")
@echo off  
set APP_FULL_VERSION_TAG=C:\progs\Git\bin\sh.exe -c \"/bin/git describe --tags  --dirty=* 2> /dev/null  \"
set APP_SHORT_VERSION_TAG="C:\\progs\\Git\\bin\\sh.exe" -c \"/bin/git describe --abbrev=0 2> /dev/null  \"
set APP_BUILD_DATE=%date:~9,4%%date:~6,2%%date:~3,2%_%time:~0,2%%time:~3,2%

REM if [ "xAPP_FULL_VERSION_TAG" = "x" ]
REM then
REM   APP_FULL_VERSION_TAG=NA
REM fi
echo "APP_FULL_VERSION_TAG=%APP_FULL_VERSION_TAG%"

REM if [ "xAPP_SHORT_VERSION_TAG" = "x" ]
REM then
REM   APP_SHORT_VERSION_TAG=NA
REM fi
echo "APP_SHORT_VERSION_TAG=%APP_SHORT_VERSION_TAG%"

REM if [ "xAPP_BUILD_DATE" = "x" ]
REM then
REM   APP_BUILD_DATE=NA
REM fi
echo "APP_BUILD_DATE=%APP_BUILD_DATE%"

REM combinations
APP_FULL_VERSION_AND_DATE="%APP_FULL_VERSION_TAG% (%APP_BUILD_DATE%)"

export APP_FULL_VERSION_TAG=%APP_FULL_VERSION_TAG%
export APP_SHORT_VERSION_TAG=%APP_SHORT_VERSION_TAG%
export APP_BUILD_DATE=%APP_BUILD_DATE%
export APP_FULL_VERSION_AND_DATE="%APP_FULL_VERSION_AND_DATE%"
