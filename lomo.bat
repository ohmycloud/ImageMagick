@echo off
set layer1Color="#3066FF" 
::#C0FFFF  "#000699" 
set layer2Color="#000699" 
set layer1Alpha=180 
set layer2Alpha=180

convert %1 -fill %layer1Color% -colorize 100% layer1.png 
convert layer1.png -alpha on -channel A -evaluate Set %layer1Alpha% layer1.png 
convert %1 -fill %layer2Color% -colorize 100% layer2.png 
convert layer2.png -alpha on -channel A -evaluate Set %layer2Alpha% layer2.png 
convert %1 layer1.png -compose softlight -composite temp.png 
convert temp.png layer2.png -compose exclusion -composite result.png 
convert result.png -background black -vignette 0x65000  result.png

del layer1.png 
del layer2.png 
del temp.png

imdisplay %2

REM 简单说明一下代码，基本的lomo效果合成步骤分为如下三步：
REM 1：用一个层带alpha通道的单色蒙版对输入图像进行soft light的composition
REM 2：再用一个带alpha通道的单色蒙版对步骤1得到的图像进行exclusion的composition
REM 3：加入暗角
REM 还有更精细的加工步骤，比如眩光，噪声等等。这里没有考虑。
REM 注：
REM 可以通过改动两个蒙版不同的颜色值，和alpha通道值来得到不同的lomo效果。
