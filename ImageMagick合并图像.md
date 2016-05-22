## ImageMagick合并图像

ImageMagick操作--图片连接操作

- 1、图片连接

指定待连接图片（按顺序）、单张图片旋转角度（0）、画布颜色（rgb(0,0,255)）、较小图片的对齐方式（center）、连接后图片旋转角度（0）。

```
convert bee.png 2.png -rotate 0 -background "rgb(0,0,255)" -gravity center -append -rotate -0 new.png
```

若需横向连接，通常单张图片旋转角度（90）、连接后图片旋转角度（90）。

```
convert 1.jpg 2.jpg -rotate 90 -background "rgb(0,0,255)" -gravity center -append -rotate -90 new.png
```

- 2、多张图片连接

指定待连接图片（按顺序）、列数和行数（3x2）、单张小图片尺寸（20x15!）、边框宽度（+2+4）、画布颜色（rgb(0,0,255)）。注：！表示强制调整为指定尺寸，如果不加则不会改变原图比例。

```
montage 1.jpg 2.jpg 3.jpg 4.jpg -tile 3x2 -geometry 240x320!+2+4 -background "rgb(0,0,255)" new.gif
```

- 3、多张图片连接（添加说明文字）

指定文字尺寸（15）、字体（Forte）、文字颜色（rgb(0,0,0)）、每张图片的文字内容、待连接图片（按顺序）、边框宽度（5）、列数和行数（3x2）、单张小图片尺寸（20x15!）、边框宽度（+2+4）、画布颜色（rgb(0,0,255)）。

```
montage -pointsize 15  -fill "rgb(0,0,0)" -label "1.jpg" 1.jpg -label " " 2.jpg -label "" 3.jpg -label "I'm 4.jpg" 4.jpg -frame 5 -tile 3x2 -geometry 150x240!+2+4 -background "rgb(0,0,255)" new.jpg
```


- 4、垂直渐变连接
指定渐变宽度（50）。注：240为图片的高度，第一张图片的宽度为300，等于渐变宽度+250，同样第二张图片的起始位置也为250。

```
convert -size 240x250 xc:white -size 240x50 gradient: -append -rotate 90 3.jpg ( 2.jpg -clone 0 -compose copyopacity +matte -composite -repage +250+0 ) -delete 0 -compose over -mosaic +repage new
.jpg 
```
