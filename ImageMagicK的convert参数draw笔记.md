## ImageMagicK的convert参数draw笔记

convert通过draw可以在已有的图片上绘制一些文字、线条、形状等。可能会用text、line、rectangle、roundRectangle、circle、ellipse等，下面逐一来说明。

- text 
 

把一段文本绘制到已有图片上。

基本命令格式：

```
convert 图片 -draw "text x坐标,y坐标 '文本信息'" 结果图片
```
 
另外还可有一些参数是可以设置的，比如字体，字体大小，字体颜色已经重新定义坐标原点。

```
convert -size 512x50 xc:gray -gravity southeast -fill red -pointsize 24 -draw "text 20,5 'hello netingcn.com!'" txt.png
```

上述命令中使用gravity来重新定义坐标，关于gravity的更多信息，请参考ImageMagicK之gravity参数详解，-fill 设置文字的颜色，颜色能够使用类似#ff00ff的方式，但是需要用双引号引起来，-pointsize 24设置文字的大小， -draw 后面引号中第一个单词是text，表明是在图片上绘制一个设置的文本，20是x坐标，5则是y坐标，hello netingcn.com!是绘制到图片上的文本信息，如果文本信息中含有空格，需要用单引号引起来，没有空格也可以用单引号，所以建议总是使用单引号。不过遗憾的是不能把中文通过这种方式绘制到图片，要把中文加在图片是，需要另外的方法。结果如下图：

 
- line 
 
在图片上绘制一条直线，基本命令格式：

```
convert 图片 -draw "line 起点x坐标,起点y坐标 终点x坐标,终点y坐标" 结果图片
```
 
可以使用的参数有-stroke 来指定线条的颜色，-strokewidth 指定线的宽度。

```
convert -size 512x50 xc:gray -stroke white -strokewidth 4 -draw "line 10,25 500,25" line.png
``` 

rectangle、roundRectangle， 
 
两者功能都是在图片上绘制一个矩形，前者是直角，后者可以绘制圆角。

```
convert -size 150x150 xc:gray -stroke red -strokewidth 2 -fill white -draw "Rectangle 10,10 140,140" rect-1.png
convert -size 150x150 xc:gray -stroke red -strokewidth 2 -fill white -draw "roundRectangle 10,10 140,140 8,8" rect-2.png
```
 
说明：参数-stroke 来指定边框的颜色，-strokewidth 指边框的宽度，-fill　矩形的填充颜色，可以用none设置为不填充任何颜色，如果没有-fill参数，默认填充为黑色，Rectangle 与roundRectangle 后第一组参数是确定矩形左上角的坐标，第二组是确定右下角的坐标，roundRectangle的第三组参数是确定圆角的幅度，如果是0,0话，就是直角，所以可以直接用roundRectangle 来代替Rectangle 。示例图片如下：


circle、ellipse， 
 
分别绘制圆和椭圆。其实也可以用椭圆来完成圆的绘制。下面用例子说明：

```
convert -size 140x140 xc:gray -stroke red -strokewidth 2 -fill white -draw "circle 70,70 5,70" circle.png
convert -size 140x140 xc:gray -stroke red -strokewidth 2 -fill white -draw "ellipse 70,70 65,65 0,360" ellipse-1.png
convert -size 140x140 xc:gray -stroke red -strokewidth 2 -fill white -draw "ellipse 70,70 60,30 0,360" ellipse-2.png
convert -size 140x140 xc:gray -stroke red -strokewidth 2 -fill white -draw "ellipse 70,70 60,30 90,270" ellipse-3.png
```
 
说明：同矩形一样，参数-stroke 来指定边框的颜色，-strokewidth 指边框的宽度，-fill　矩形的填充颜色，可以用none设置为不填充任何颜色。circle和ellipse中的第一组参数都是代表圆心的坐标，但是他们第二组参数含义不同，circle的第二组参数是圆的任何一边缘坐标，所以圆的半径就是两组坐标的距离，ellipse的第二组参数中的第一个是横向的最大长度、第二个是纵向最大高度，第三组参数是绘制的区间，区间是0~360度，0度是原点开始到从左到右，度数是顺时针方向。有了这个参数就可以很容易绘制半圆，1/4圆，乃至圆的任何一部分，所以ellipse比circle的功能更加强大。上述的第二条命令完成和第一条命令同样的事。示例图片如下：
