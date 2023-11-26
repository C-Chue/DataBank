@echo off
chcp 65001

echo + ------------------------------------------- +
echo + -- 主动推送当前文件夹内容 --> github -- +
git add * 
git commit -m '%date% %time%-主动推送'
git push origin main
echo + ---------------- 推送成功 ----------------- +

pause