@echo off
chcp 65001 > nul  :: ���ô���ҳΪ UTF-8����֧�������ַ�

REM ����Ƿ��Թ���ԱȨ������
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ������ʹ�ù���ԱȨ�����д˽ű���
    pause
    exit /b
)

:main_menu
cls
echo ===========================================
echo             BAT ������
echo ===========================================
echo 1. ϵͳ��Ϣ
echo 2. ���̹���
echo 3. ���繤��
echo 4. ���¹���
echo 5. �ļ�����
echo 6. ����
echo 0. �˳�
echo ===========================================
set /p choice=��ѡ��һ��ѡ�0-6��:

rem ������֤�͹���ѡ��
if "%choice%"=="1" call :SystemInfo
if "%choice%"=="2" call :DiskTools
if "%choice%"=="3" call :NetworkTools
if "%choice%"=="4" call :UpdateManagement
if "%choice%"=="5" call :FileOperations
if "%choice%"=="6" call :About
if "%choice%"=="0" goto :eof

echo ��Ч��ѡ����������룡
pause
goto main_menu

exit /b

:SystemInfo
cls
echo ===========================================
echo             ϵͳ��Ϣ
echo ===========================================
echo 1. �鿴����������Ϣ
echo 2. �鿴�ڴ�ʹ�����
echo 0. �������˵�
echo ===========================================
set /p sys_choice=��ѡ��һ��ѡ�0-2��:

rem ϵͳ��Ϣ�Ӳ˵�ѡ��
if "%sys_choice%"=="1" call :SystemInfoDetail
if "%sys_choice%"=="2" call :MemoryUsage
if "%sys_choice%"=="0" goto main_menu

echo ��Ч��ѡ����������룡
pause
goto SystemInfo

exit /b

:SystemInfoDetail
cls
echo ���ڻ�ȡ����������Ϣ...
echo.
echo === CPU�����봦��������Ϣ ===
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors /Format:Table
echo.
echo === RAM���ڴ棩��Ϣ ===
wmic memorychip get Capacity,Speed,Manufacturer /Format:Table
echo.
echo === Ӳ����Ϣ ===
wmic diskdrive get Model,InterfaceType,MediaType,Size /Format:Table
echo.
echo === ����ϵͳ��Ϣ ===
wmic os get Caption,CSDVersion,OSArchitecture,Version /Format:Table
pause
goto SystemInfo

exit /b

:MemoryUsage
cls
echo ���ڲ鿴�ڴ�ʹ�����...
echo.
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto SystemInfo

exit /b

:DiskTools
cls
echo ===========================================
echo             ���̹���
echo ===========================================
echo 1. �鿴���̿ռ�
echo 0. �������˵�
echo ===========================================
set /p disk_choice=��ѡ��һ��ѡ�0-1��:

rem ���̹����Ӳ˵�ѡ��
if "%disk_choice%"=="1" call :DiskSpace
if "%disk_choice%"=="0" goto main_menu

echo ��Ч��ѡ����������룡
pause
goto DiskTools

exit /b

:DiskSpace
cls
echo ���ڲ鿴���̿ռ�...
echo.
wmic logicaldisk get size,freespace,caption /format:table
pause
goto DiskTools

exit /b

:NetworkTools
cls
echo ===========================================
echo             ���繤��
echo ===========================================
echo 1. ping һ����ַ
echo 0. �������˵�
echo ===========================================
set /p net_choice=��ѡ��һ��ѡ�0-1��:

rem ���繤���Ӳ˵�ѡ��
if "%net_choice%"=="1" call :PingWebsite
if "%net_choice%"=="0" goto main_menu

echo ��Ч��ѡ����������룡
pause
goto NetworkTools

exit /b

:PingWebsite
cls
set /p website=������Ҫping����ַ:
echo ����ping %website%...
ping %website%
pause
goto NetworkTools

exit /b

:UpdateManagement
cls
echo ===========================================
echo             ���¹���
echo ===========================================
echo 1. �Ƴ�Windows����
echo 0. �������˵�
echo ===========================================
set /p update_choice=��ѡ��һ��ѡ�0-1��:

rem ���¹����Ӳ˵�ѡ��
if "%update_choice%"=="1" call :DelayWindowsUpdate
if "%update_choice%"=="0" goto main_menu

echo ��Ч��ѡ����������룡
pause
goto UpdateManagement

exit /b

:DelayWindowsUpdate
cls
echo ===========================================
echo          �Ƴ�Windows����
echo ===========================================
echo 1. �����Ƴ�Windows����
echo 0. ���ظ��¹���˵�
echo ===========================================
set /p updateChoice=��ѡ��һ��ѡ�0-1��:

rem �Ƴ�Windows�����Ӳ˵�ѡ��
if "%updateChoice%"=="1" call :EnableDelay
if "%updateChoice%"=="0" goto UpdateManagement

echo ��Ч��ѡ����������룡
pause
goto DelayWindowsUpdate

exit /b

:EnableDelay
cls
echo ���������Ƴ�Windows����...

:: ��ʾ������
setlocal enabledelayedexpansion
set /a progress=0
for /L %%i in (1,1,50) do (
    ping -n 1 -w 50 127.0.0.1 >nul
    set /a progress=!progress!+2
    cls
    echo ���������Ƴ�Windows����... !progress!%%
    echo ===[!progress!%%]===
)
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdateUX\Settings" /v "FlightSettingsMaxPauseDays" /t REG_DWORD /d "5000" /f
echo �����Ƴ�Windows���³ɹ���
pause
goto UpdateManagement

exit /b

:FileOperations
cls
echo ===========================================
echo             �ļ�����
echo ===========================================
echo 1. �����ļ���Ŀ¼
echo 2. �ƶ��ļ���Ŀ¼
echo 3. ɾ���ļ���Ŀ¼
echo 0. �������˵�
echo ===========================================
set /p file_choice=��ѡ��һ��ѡ�0-3��:

rem �ļ������Ӳ˵�ѡ��
if "%file_choice%"=="1" call :CopyFiles
if "%file_choice%"=="2" call :MoveFiles
if "%file_choice%"=="3" call :DeleteFiles
if "%file_choice%"=="0" goto main_menu

echo ��Ч��ѡ����������룡
pause
goto FileOperations

exit /b

:CopyFiles
rem ��д�����ļ��Ĳ�������
pause
goto FileOperations

exit /b

:MoveFiles
rem ��д�ƶ��ļ��Ĳ�������
pause
goto FileOperations

exit /b

:DeleteFiles
rem ��дɾ���ļ��Ĳ�������
pause
goto FileOperations

exit /b

:About
cls
echo ===========================================
echo                ����
echo ===========================================
echo BAT ������ v1.0
echo ���ߣ�YourName
echo ��ϵ���ߣ����� "1" �鿴������Ϣ
echo �������˵������� "0" �������˵�
echo ===========================================
set /p about_choice=������ѡ�

rem ����ҳ��ѡ��
if "%about_choice%"=="1" (
    start "" "https://blog.iwexe.site"  :: �滻Ϊʵ�ʵ���ϵ��������
    goto main_menu
) else if "%about_choice%"=="0" (
    goto main_menu
)

echo ��Ч��ѡ����������룡
pause
goto About

exit /b
