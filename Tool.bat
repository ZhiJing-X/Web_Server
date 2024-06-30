@echo off
chcp 65001 > nul  :: 设置代码页为 UTF-8，以支持中文字符

REM 检测是否以管理员权限运行
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：请使用管理员权限运行此脚本！
    pause
    exit /b
)

:main_menu
cls
echo ===========================================
echo             BAT 工具箱
echo ===========================================
echo 1. 系统信息
echo 2. 磁盘工具
echo 3. 网络工具
echo 4. 更新管理
echo 5. 文件操作
echo 6. 关于
echo 0. 退出
echo ===========================================
set /p choice=请选择一个选项（0-6）:

rem 输入验证和功能选择
if "%choice%"=="1" call :SystemInfo
if "%choice%"=="2" call :DiskTools
if "%choice%"=="3" call :NetworkTools
if "%choice%"=="4" call :UpdateManagement
if "%choice%"=="5" call :FileOperations
if "%choice%"=="6" call :About
if "%choice%"=="0" goto :eof

echo 无效的选项，请重新输入！
pause
goto main_menu

exit /b

:SystemInfo
cls
echo ===========================================
echo             系统信息
echo ===========================================
echo 1. 查看整机配置信息
echo 2. 查看内存使用情况
echo 0. 返回主菜单
echo ===========================================
set /p sys_choice=请选择一个选项（0-2）:

rem 系统信息子菜单选择
if "%sys_choice%"=="1" call :SystemInfoDetail
if "%sys_choice%"=="2" call :MemoryUsage
if "%sys_choice%"=="0" goto main_menu

echo 无效的选项，请重新输入！
pause
goto SystemInfo

exit /b

:SystemInfoDetail
cls
echo 正在获取整机配置信息...
echo.
echo === CPU（中央处理器）信息 ===
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors /Format:Table
echo.
echo === RAM（内存）信息 ===
wmic memorychip get Capacity,Speed,Manufacturer /Format:Table
echo.
echo === 硬盘信息 ===
wmic diskdrive get Model,InterfaceType,MediaType,Size /Format:Table
echo.
echo === 操作系统信息 ===
wmic os get Caption,CSDVersion,OSArchitecture,Version /Format:Table
pause
goto SystemInfo

exit /b

:MemoryUsage
cls
echo 正在查看内存使用情况...
echo.
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto SystemInfo

exit /b

:DiskTools
cls
echo ===========================================
echo             磁盘工具
echo ===========================================
echo 1. 查看磁盘空间
echo 0. 返回主菜单
echo ===========================================
set /p disk_choice=请选择一个选项（0-1）:

rem 磁盘工具子菜单选择
if "%disk_choice%"=="1" call :DiskSpace
if "%disk_choice%"=="0" goto main_menu

echo 无效的选项，请重新输入！
pause
goto DiskTools

exit /b

:DiskSpace
cls
echo 正在查看磁盘空间...
echo.
wmic logicaldisk get size,freespace,caption /format:table
pause
goto DiskTools

exit /b

:NetworkTools
cls
echo ===========================================
echo             网络工具
echo ===========================================
echo 1. ping 一个网址
echo 0. 返回主菜单
echo ===========================================
set /p net_choice=请选择一个选项（0-1）:

rem 网络工具子菜单选择
if "%net_choice%"=="1" call :PingWebsite
if "%net_choice%"=="0" goto main_menu

echo 无效的选项，请重新输入！
pause
goto NetworkTools

exit /b

:PingWebsite
cls
set /p website=请输入要ping的网址:
echo 正在ping %website%...
ping %website%
pause
goto NetworkTools

exit /b

:UpdateManagement
cls
echo ===========================================
echo             更新管理
echo ===========================================
echo 1. 推迟Windows更新
echo 0. 返回主菜单
echo ===========================================
set /p update_choice=请选择一个选项（0-1）:

rem 更新管理子菜单选择
if "%update_choice%"=="1" call :DelayWindowsUpdate
if "%update_choice%"=="0" goto main_menu

echo 无效的选项，请重新输入！
pause
goto UpdateManagement

exit /b

:DelayWindowsUpdate
cls
echo ===========================================
echo          推迟Windows更新
echo ===========================================
echo 1. 启用推迟Windows更新
echo 0. 返回更新管理菜单
echo ===========================================
set /p updateChoice=请选择一个选项（0-1）:

rem 推迟Windows更新子菜单选择
if "%updateChoice%"=="1" call :EnableDelay
if "%updateChoice%"=="0" goto UpdateManagement

echo 无效的选项，请重新输入！
pause
goto DelayWindowsUpdate

exit /b

:EnableDelay
cls
echo 正在启用推迟Windows更新...

:: 显示进度条
setlocal enabledelayedexpansion
set /a progress=0
for /L %%i in (1,1,50) do (
    ping -n 1 -w 50 127.0.0.1 >nul
    set /a progress=!progress!+2
    cls
    echo 正在启用推迟Windows更新... !progress!%%
    echo ===[!progress!%%]===
)
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdateUX\Settings" /v "FlightSettingsMaxPauseDays" /t REG_DWORD /d "5000" /f
echo 启用推迟Windows更新成功。
pause
goto UpdateManagement

exit /b

:FileOperations
cls
echo ===========================================
echo             文件操作
echo ===========================================
echo 1. 复制文件或目录
echo 2. 移动文件或目录
echo 3. 删除文件或目录
echo 0. 返回主菜单
echo ===========================================
set /p file_choice=请选择一个选项（0-3）:

rem 文件操作子菜单选择
if "%file_choice%"=="1" call :CopyFiles
if "%file_choice%"=="2" call :MoveFiles
if "%file_choice%"=="3" call :DeleteFiles
if "%file_choice%"=="0" goto main_menu

echo 无效的选项，请重新输入！
pause
goto FileOperations

exit /b

:CopyFiles
rem 编写复制文件的操作代码
pause
goto FileOperations

exit /b

:MoveFiles
rem 编写移动文件的操作代码
pause
goto FileOperations

exit /b

:DeleteFiles
rem 编写删除文件的操作代码
pause
goto FileOperations

exit /b

:About
cls
echo ===========================================
echo                关于
echo ===========================================
echo BAT 工具箱 v1.0
echo 作者：YourName
echo 联系作者：输入 "1" 查看作者信息
echo 返回主菜单：输入 "0" 返回主菜单
echo ===========================================
set /p about_choice=请输入选项：

rem 关于页面选择
if "%about_choice%"=="1" (
    start "" "https://blog.iwexe.site"  :: 替换为实际的联系作者链接
    goto main_menu
) else if "%about_choice%"=="0" (
    goto main_menu
)

echo 无效的选项，请重新输入！
pause
goto About

exit /b
