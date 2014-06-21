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

