## ImageMagick操作--图片高级操作

- 1、图片指定区域变色

指定区域尺寸和起始坐标（50x60+20+10）、区域颜色（rgb(255,0,0)）、着色程度（20%）。

```
convert old.png -region 50x60+20+10 -fill "rgb(255,0,0)" -colorize 20% new.png 
convert 2.jpg -region 150x100+20+10 -fill "rgb(255,0,0)" -colorize 20% new.png
```

- 2、图片指定区域变色（放大或缩小区域）

指定区域尺寸和起始坐标（50x60+20+10）、尺寸（120%）、区域颜色（rgb(255,0,0)）、着色程度（20%）。

```
convert old.png -region 50x60+20+10 -resize 120% -fill "rgb(255,0,0)" -colorize 20% new.png 
```

- 3、替换相同颜色的区域（指定颜色）

指定颜色差异程度（10%），替换颜色（黑色），被替换颜色（白色）。将整张图片中的指定颜色全部替换。

```
convert 2.jpg -alpha set -channel RGBA -fuzz 10% -fill "rgb(0,0,0)" -opaque "rgb(255,255,255)" new.png 
```

- 4、替换不同颜色的区域（指定颜色）

指定颜色差异程度（50%），替换颜色（白色），指定颜色（蓝色）。将整张图片中除指定颜色外的颜色全部替换。

```
convert 2.jpg -alpha set -channel RGBA -fuzz 50% -fill "rgb(255,255,255)" +opaque "rgb(0,0,255)" new.png 
```

- 5、替换相同颜色的区域（指定坐标）
指定颜色差异程度（10%），替换颜色（红色），指定坐标（180,150）。将整张图片中与指定位置颜色相同的颜色全部替换。

```
convert 2.jpg -alpha set -channel RGBA -fuzz 10% -fill "rgb(255,0,0)" -draw "color 180,150 replace" new.png 
```

- 6、替换相同颜色的连通区域（指定坐标）

指定颜色差异程度（10%），替换颜色（红色），指定坐标（180,150）。将图片连通区域中与指定位置颜色相同的颜色全部替换。

```
convert 2.jpg -alpha set -channel RGBA -fuzz 10% -fill "rgb(255,0,0)" -draw "color 180,150 replace" new.png 
```


- 7、图像边缘突出显示

指定探测半径（5），对图像中类似边缘的像素进行探测。使边缘突显出来，易于观察。

```
convert old.png -edge 5 new.png 
```
 
- 8、图像边缘探测

指定探测半径（5）。

```
convert 2.jpg -background white -flatten -colorspace gray -negate -edge 5 -negate -normalize -threshold 50% -despeckle -blur 0x.5 -contrast-stretch 0x50% new.png 
```