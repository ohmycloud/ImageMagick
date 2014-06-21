@echo off
convert %1 ( %1 -blur 3x3 ) -compose overlay -composite output.png
REM 上述命令完成了如下工作：
REM 1：将输入图像进行模糊。
REM 2：将模糊之后的图片以overlay的方式，叠加到输入图像上去。
