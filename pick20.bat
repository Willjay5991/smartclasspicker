@echo off
chcp 65001
setlocal enabledelayedexpansion

:: 配置参数 ======================================
:: 核心修改点：可配置抽样人数
set pick_count=20 
:: ==============================================


:: 读取学生名单到数组
set lines=0
for /f "delims=" %%a in (student-list.txt) do (
    set /a lines+=1
    set "student_!lines!=%%a"
)

if %lines% lss %pick_count% (
    echo 错误：文件中只有%lines%名学生，不足20人
    pause
    exit
)

set count=0
set "picked=,"
:loop
:: 修正点1：正确的变量赋值方式
set /a "rand_num=!random! %% lines + 1"

:: 修正点2：使用延迟变量扩展
if not "!picked:,%rand_num%,=!"=="!picked!" goto loop

set "picked=!picked!,%rand_num%,"
call set "selected_!count!=%%student_%rand_num%%%"
set /a count+=1
if !count! lss %pick_count% goto loop

set /a pick_count_minus_one = pick_count - 1

echo 随机选取的%pick_count%名学生：
for /l %%i in (0,1,%pick_count_minus_one%) do (
    echo !selected_%%i!
)
pause
