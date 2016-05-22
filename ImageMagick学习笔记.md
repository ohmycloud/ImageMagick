```
欢迎共同研究ImageMagick
Email:sxw2k@sina.com
sxw
                                                        2011年暑假
```
 

## ImageMagick学习笔记

-------------------------------------------------------------------

注意：ImageMagick对中文支持不好，文件（夹）一定不要含中文，否则会报错！切记！

-开启开关  +关闭开关，恢复从前。

convert

convert顾名思义就是对图像进行转化，它主要用来对图像进行格式的转化，同时还可以做缩放、剪切、模糊、反转等操作。
格式转化

比如把 foo.jpg 转化为 foo.png：转换不会破坏原图像。

```
convert foo.jpg foo.png
```
 

Mogrify

```
mogrify -format png *.jpg
```

将所有jpg文件转换成png格式，不破坏源文件（相当于批量转换了）

注意：

```
mogrify -format png *.gif
```

会把gif文件的每一帧都转化成png文件，会生成很多文件

convert还可以把多张照片转化成pdf格式：

```
convert *.jpg foo.pdf
convert test.gif test.jpg 会生成很多以test开头的图片文件
```
=>大小缩放

为一个普通大小的图片做一个缩略图

```
convert -resize 100x100 foo.jpg thumbnail.jpg
```

也可以用百分比,更为直观：

```
convert -resize 50%x50% foo.jpg thumbnail.jpg  （50%x50%是字母x）
```

convert会自动地考虑在缩放图像大小时图像的高宽的比例，也就是说新的图像的高宽比与原图相同。 

批量生成缩略图：

```
mogrify -sample 80x60 *.jpg
```

注意，这个命令会覆盖原来的图片，不过你可以在操作前，先把你的图片备份一下。

```
convert -sample 25%x25% input.jpg output.jpg
```

等比列缩放
=>加边框

在一张照片的四周加上边框，可以用 -mattecolor 参数，

```
convert -mattecolor "#000000" -frame 60x60 yourname.jpg rememberyou.png
```
其中，"#000000"是边框的颜色，边框的大小为60x60

=>在图片上加文字

```
convert -fill green -pointsize 40 -draw "text 10,50 charry.org" 2.jpg 222.jpg
```

上面的命令在距离图片的左上角10x50的位置，用绿色的字写下charry.org，如果你要指定别的字体，可以用-font参数。

或者：

```
convert 1.png -fill white -pointsize 13 -draw "text 10,15 ‘lifesinger 2006’" 2.png
```

=>模糊


高斯模糊:

```
convert -blur 80 foo.jpg blur.png
```

-blur参数还可以这样-blur 80x5。后面的那个5表示的是Sigma的值，这个是图像术语，我也不太清楚，总之，它的值对模糊的效果起关键的作用，效果更明显


=>翻转


上下翻转：

```
convert -flip foo.png bar.png
```

左右翻转：

```
convert -flop foo.png bar.png
```

=>反色
形成底片的样子：

```
convert -negate foo.png bar.png
```

单色
把图片变为黑白颜色：

```
convert -monochrome foo.png bar.png
```

加噪声

```
convert -noise 3 foo.png bar.png
```

油画效果
我们可用这个功能，把一张普通的图片，变成一张油画，效果非常的逼真

```
convert -paint 4 foo.png bar.png
```
 
着色：

着色是将每个像素的颜色与指定颜色混合的过程。该效果的参数就是要用来混合的颜色。可以用一个百分数（它将分别用于红色、绿色和蓝色），也可以用三个百分数来指定这个参数。也可以提供三个实际值中的一个。要指定三个值，每个值分别代表红色、绿色和蓝色三个采样，使用 red/green/blue 形式的参数。例如， 10/20/30 意味着红色的值是 10、绿色值为 20 而蓝色值为 30。您也可以在这个构造中使用百分数

```
convert -colorize 255 input.jpg output.jpg
convert -colorize 100/0/125 input.jpg output.jpg
```
 
内爆效果

内爆效果模拟了您图像的中心被吸入虚拟黑洞的情形。所用的参数是您所期望的内爆效果量。

```
convert -implode 1 input.jpg output.jpg
```
 
曝光，模拟胶片曝光

```
convert -solarize 42 input.jpg output.jpg
```
 
扩散

spread 在图像之内以随机的数量移动像素。所用的参数是被移到新选择的位置的像素区域的大小。所以它指定了输出和输入的相似程度

```
convert -spread 5 input.jpg output.jpg
```
 
马赛克效果：`convert -sample 10% -sample 1000% input.jpg output.jpg`


从左至右将图片水平相连：

```
convert +append *.jpg result.jpg
```
 
或

```
convert -size 350x500 xc:black composite.jpg
composite -geometry +0+0 composite.jpg image1.gif composite.jpg
composite -geometry +100+0 composite.jpg image2.gif composite.jpg
composite -geometry +0+300 composite.jpg image3.gif composite.jpg
composite -geometry +0+375 composite.jpg image4.gif composite.jpg
```

旋转
把一张图片，旋转一定的角度：

```
convert -rotate 30 foo.png bar.png
```
  
上面的30，表示向右旋转30度，如果要向左旋转，度数就是负数。

炭笔效果:

```
convert -charcoal 2 foo.png bar.png
```

形成炭笔或者说是铅笔画的效果。增加 -charcoal 选项的参数的数值会增加应用于该图像的“炭笔”数量，但也会延缓生成图像的过程。


散射
毛玻璃效果：

```
convert -spread 30 foo.png bar.png
```

漩涡
以图片的中心作为参照，把图片扭转，形成漩涡的效果：

```
convert -swirl 67 foo.png bar.png
```

凸起效果
用-raise来创建凸边：

```
convert -raise 5x5 foo.png bar.png
```

执行后，你会看到，照片的四周会一个5x5的边，如果你要一个凹下去的边，把-raise改为+raise就可以了。其实凸边和凹边看起来区别并不是很大。 
为图片添加一些注释信息：

```
convert -font Arial -stroke green -fill red -draw "text 50,60 www.hist.edu.cn" -pointsize 14 07.jpg hist.png
```
 
解释：

```
-draw “text 10,10  String"  在以图片左上角为原点坐标的10,10位置处添加文字
-font 指定字体
-stroke 描边用的颜色，
-fill 填充用的颜色，这里用none就可以画出空心字了，
-pointsize 字体像素大小，
-font Arial 将注释的字体设置为Arial。也可以在此处指定字体文件的路径。但它是使用位于非标准位置的字体来完成该任务的：
```

```
convert -font c:\windows\fonts\1900805.ttf -fill white -pointsize 36 -draw ‘text 10,475 “ylmf.com”’ floriade.jpg stillhq.jpg
```

```
-fill white 用白色而不是标准的黑色来填充字母。
-pointsize 36 以点为单位指定字母的大小。一英寸等于 72 点。
```
 
```
convert -font fonts\1900805.ttf -fill white -pointsize 36 -draw 'text 10,475 "stillhq.com"' floriade.jpg stillhq.jpg
```

以下是结果：

带标记的图像


-fill white 用白色而不是标准的黑色来填充字母。

发散后应用炭笔效果：

```
convert -sample 50%x50% -spread 4 -charcoal 4 input.jpg output.jpg
```
 

加上5个像素宽的红色边框：

```
convert -bordercolor red -border 5x5 input.jpg output.jpg
convert -list color 列出描边可用的颜色
```

还可以使用以下方法来指定您自己的颜色了，这里 R 表示红色值，G 表示绿色值，B 表示蓝色值，A 是 alpha（透明度）值：

```
#RGB - (R,G,B 是十六进制数，每个 4 位) 
#RRGGBB - (每个 8 位) 
#RRRGGGBBB - (每个 12 位) 
#RRRRGGGGBBBB - (每个 16 位) 
#RGBA - (每个 4 位) 
#RRGGBBAA - (每个 8 位) 
#RRRGGGBBBAAA - (每个 12 位) 
#RRRRGGGGBBBBAAAA - (每个 16 位) 
rgb(r,g,b) - (r,g,b 是十进制数) 
rgba(r,g,b,a) - (r,g,b,a 是十进制数) 
```

```
convert -mattecolor rgba(255,91,191,1) -frame 2x2 input.jpg out.jpg
```
 
添加一些类似于用 -raise 命令得到的阴影

```
convert -mattecolor rgb(255,181,197) -frame 5x5+2 input.jpg out.jpg
```
 
更多的修饰：

```
convert -mattecolor rgb(255,181,197) -frame 5x5+2+2    input.jpg out.jpg
convert -mattecolor rgb(255,181,197) -frame 25x25+0+25 input.jpg out.jpg
convert -mattecolor rgb(255,181,197) -frame 25x25+25+0 input.jpg out.jpg
```
 
研究边框可深入研究下-frame参数

composite 命令将一个图像叠加到另一个图像上

```
composite -gravity NorthEast w.jpg input.jpg out.jpg
composite -gravity NorthWest w.jpg input.jpg Northwest.jpg
composite -gravity SouthWest w.jpg input.jpg southwest.jpg
composite -gravity SouthEast w.jpg input.jpg southEast.jpg
```
 
可以叠加一个透明的角，生成带有圆角的图像。

将图片转换成pdf文件

```
convert *.jpg  test.pdf
```

而 `convert  test.pdf  test.png` 是将pdf中的文件导出！但是需要 Ghostscript

 

生成法国国旗图案

```
convert -size 20x40 xc:red xc:white xc:blue +append flag.png
```
 
命令的执行是有顺序的，按照从左至右的顺序依次执行

```
convert 1.jpg -crop 300x300+0+0 -resize 200x200 -colors 100 +profile "*" 1.png
```

表示：把1.jpg先从左上角(0,0)裁剪一块300x300的部分，然后把这部分缩小到200x200，然后把颜色缩减到100色，最后生成1.png。"+profile "*""意味着在图片文件里不存储附加信息，以减小图片体积。

注意，-resize会试图保留原图的视觉比例，因此不一定生成的图片和你指定的尺寸一定匹配，比如，如果2.jpg大小是400x200，那么如果用下面的命令：

```
convert 2.jpg -resize 100x100 2.png
```

那么生成的图片2.png的实际大小是100x50。

常用的命令有：

```
-crop 宽x高+起点横坐标+起点纵坐标：裁剪图
-resize 宽x高[!]：改变尺寸，如果使用惊叹号，表示不保留视觉比例，强行改变尺寸匹配给定的宽和高
-colors 颜色数：设定图片采用的颜色数，如果是生成png或gif图片应指定这个参数
-quality 质量：设定jpeg图片输出质量，推荐采用80，此命令仅用于输出格式是jpg的情况，不应省略，省略的话默认质量是95，生成图片过大
+profile "*"：图片中不存储附加信息，必须使用，否则生成图片过大
```

生成索引：

```
montage -bordercolor red -borderwidth 3 -label "%f" -tile 5x3 *.jpg montage.jpg
```

```
mogrify -format gif *.jpg
```

将所有jpg文件转换成gif格式

```
identify -verbose 001.jpg
```

显示图片详细信息

```
identify -format "%wx%h"  001.jpg
```

显示图片的宽和高输出类似于640x480，其中-format允许你仅仅定想要输出的信息。%w 表示图像宽度，而 %h 表示图像高度

图片目录（visual image directory ，VID）的创建：

```
montage *.jpg directory.vid
```

或则

```
convert 'vid:*.jpg' directory.vid
```
 
如何将gif文件分析为一系列的单个图片？

```
convert animation.gif framed.gif
```
 
如何从图片文件中抽取第一张图片

```
convert "Image.gif[0]" first.gif 
```
 
如何创建一张空白图片

```
convert -size 80x60 xc:"#ddddff" ss.jpg
convert -size 80x60 null:white white.jpg
convert 017.jpg -threshold 100% black.jpg  创建一张与017.jpg同大小的图片，黑色
convert 017.jpg -threshold 65% black.jpg
```
 

 
```
identify -format "%wx%h" sample.png
```

显示图片宽和高

```
convert +adjoin *.jpg frames%d.gif  所有jpg图片转换成gif格式
```

如何生成gif动画

```
1、convert -delay 20 *.jpg animation.gif
2、convert -delay 20 001.jpg -delay 10 006.jpg -delay 5 007.jpg animation.gif
3、convert 010.jpg -page +50+100 007.jpg -page +0+100 008.jpg animation.gif
4、convert -loop 50 *.jpg animation.gif
```

Imagick的两种命令行格式：

```
command  [options]  input_image   output_image
command  [options] image1 [options] image2 [options]  output_image
```
 

```
convert -size 40x20 xc:red  xc:blue  -append  -rotate 90  append_rotate.gif
```
 

产生一蓝一红2个图片，附加到一块然后再右旋转90度

```
convert -size 40x20 xc:red  xc:blue -rotate 90  -append   append_rotate.gif
convert -size 40x20 xc:red  xc:blue  -append   append_rotate.gif
convert -size 40x20 xc:red  xc:blue -rotate 90  append_rotate.gif
```

注意这是一个动画，有2副图片。会动的！！

```
convert 06.jpg 07.jpg -append 08.jpg 09.jpg -background skyblue +append temp.jpg
```
 
06.jpg和07.jpg垂直附加，08.jpg和09.jpg水平附加在背景为天蓝色的图片上

 
```
convert -list gravity
```

- None
- Center
- East
- Forget
- NorthEast
- North
- NorthWest
- SouthEast

 
```
identify -ping 000.jpg

# 000.jpg JPEG 670x448 670x448+0+0 DirectClass 8-bit 46.2891kb


identify -format "%k" 000.jpg
# 34426

identify -ping -format "double_width=%[fx:w*2] PI=%[fx:atan(1)*4]" 000.jpg
# double_width=1340 PI=3.14159

convert null: -print "(50 + 25)/5  ==>  %[fx: (50+25)/5 ]\n" null:
# (50 + 25)/5  ==>  15 
```

 


