@echo off
chcp 65001
setlocal enabledelayedexpansion

:: 配置参数 ======================================
:: 核心修改点：可配置抽样人数
set pick_count=20 
:: ==============================================

:: 生成日期戳 (YYYYMMDD)
for /f "skip=1" %%a in ('wmic os get localdatetime') do if not defined filedate set "filedate=%%a"
set "filename=pick%filedate:~0,8%.txt"

:: 读取学生名单到数组
set lines=0
for /f "delims=" %%a in (student-list.txt) do (
    set /a lines+=1
    set "student_!lines!=%%a"
)

if %lines% lss %pick_count%(
    echo 错误：文件中只有%lines%名学生，不足%pick_count%人
    pause
    exit
)

set count=0
set "picked=,"
:loop
set /a "rand_num=!random! %% lines + 1"
if not "!picked:,%rand_num%,=!"=="!picked!" goto loop

set "picked=!picked!,%rand_num%,"
call set "selected_!count!=%%student_%rand_num%%%"
set /a count+=1
if !count! lss %pick_count% goto loop

set /a pick_count_minus_one = pick_count - 1


:: 输出到文件并显示
(
echo 随机选取的 %pick_count% 名学生：
for /l %%i in (0,1,%pick_count_minus_one%) do (
    echo !selected_%%i!
)
) > "%filename%"

type "%filename%"
pause
