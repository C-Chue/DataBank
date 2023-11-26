@echo off
chcp 65001

echo 主动推送当前文件夹内容 --> github
git add * 
git commit -m '主动推送'
git push origin main
pause