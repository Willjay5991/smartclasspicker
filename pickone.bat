@echo off
chcp 65001
setlocal enabledelayedexpansion

:: 统计文件行数
set lines=0
for /f "delims=" %%a in (student-list.txt) do (
    set /a lines+=1
    set "student_!lines!=%%a"
)

:: 检查空文件
if %lines% equ 0 (
    echo 错误：文件为空或不存在！
    pause
    exit
)

:: 生成随机行号（1~总行数）
set /a rand_num=(%random% %% lines) + 1

:: 输出结果
echo student number: %lines%
echo !student_%rand_num%!
echo.
pause
