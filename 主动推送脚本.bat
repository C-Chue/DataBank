@echo off
chcp 65001

echo + ------------------------------------------- +
echo + -- 主动推送当前文件夹内容 --> github -- +

git add * 
git commit -m "%date:~3,10% %time%-主动推送"
git push origin main

if %errorlevel% equ 0 (
    echo echo + ---------------- 推送成功 ----------------- +
) else (
    echo + ---------------- 推送失败 ----------------- +
)

pause