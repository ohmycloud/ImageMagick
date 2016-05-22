## ImageMagick的功能简介：
原文地址：http://bbs.gxsd.com.cn/forum.php?mod=viewthread&tid=253184&page=1，由BBDD完成。

- 1、批量旋转、分割，并顺序编号,一步到位
- 2、自动批量切除白边（auto-crop）
- 3、自动倾斜校正（deskew）
- 4、批量加标注
- 5、批量去标注
- 6、批量加水印
- 7、批量去水印
--------------------------------------------------------------------------------------------------

- 1、将 a.gif 转为 png 格式

```
convert a.gif a.png
```

请注意，convert 命令的基本格式为

```
convert 源文件 [参数] 目标文件
```

在上面的命令中，源文件是 a.gif，目标文件是 a.png。由于这是最简单的格式转换，所以不需要中间的参数。
convert 常用于单个文件的转换。上面的命令是它最基本的用法。

前面说过 IM 支持超过 100 种的文件格式。
下面的命令，可以列出 IM 所支持的所有格式：

```
identify -list format
```

- 2、批量文件的格式转换

```
mogrify -path newdir -format png  *.gif
```

这个命令的作用，是将当前目录下的所有 gif 文件，转换为 png 格式，并将其存放在 newdir 目录下。

```
mogrify 是用于批量处理文件的命令。它的基本格式是这样的：
mogrify 参数 源文件
mogrify 支持基本的通配符，例如你可以用 a*.png 指代所有以 a 打头的 png 文件，诸如此类。
```

再回到刚才的命令：

```
mogrify -path newdir -format png  *.gif
```

这里的 -path 和 -format 是两个可选择的参数。
-format 指定输出的文件格式，而 -path 则指定输出的文件目录。

我在这里先强调一下：如果不加 -path 参数的话，mogrify 有可能会覆盖你的源文件，因此强烈推荐在每个 mogrify 命令里都加上 -path 参数，并在执行之前，先检查整个命令正确性。

 

## 图像的缩放：使用 -resize

IM 有好几种缩放图像的方法，在这里我只讲最基本的 resize 命令。

将一个200x304大小的图像缩小为100x152（长宽各缩短一半）。

```
convert page200.png -resize 100x152 page100.png
```

上面的 100x152，指定了目标文件的长和宽。

你也可以只指定目标文件宽度，这样它的高度会等比例放大：

```
convert page200.png -resize 100 page100.png
```

或者只指定高度：

```
convert page200.png -resize x152 page100.png
```

以上三句命令，其结果都是一样的。


你可以用 identify 命令来显示图像的尺寸以及其它一些信息：

```
identify page100.png
```
其结果为：

```
page100.png PNG 100x152 100x152+0+0 8-bit DirectClass 17.9kb
```

最后，你还可以通过指定百分比来缩放图像：

```
convert page200.png -resize 50% page100.png
convert page200.png -resize 150% page300.png
``` 

- 批量缩放图像

```
mogrify -path newdir -resize 200% *.png
```

这句命令的意思是将当前目录中所有的 png 文件都放大一倍，并存放到 newdir 目录中。

请注意，如果没有 -path 语句，新生成的 png 文件将会覆盖原始文件。因此，在使用 mogrify 命令时，-path 参数几乎是必须的。

另外，我们也可以注意到 mogrify 和 convert 的命令其实基本上是通用的。通常我们可以先用 convert 修改单个文件，对结果满意的话再用 mogrify 进行批量处理。

 

## 三、图像的剪切

- 使用 -crop

```
convert page100.png -crop 50x50+10+10 crop1.png
convert page100.png -crop 50x50+10+10 +repage crop2.png
```

这两句命令的意思都是以 10,10 为原点，从图上剪一个 50x50 的小图。
+repage 的作用是重置图像内部的信息。下面是用 identify 命令查看 crop1.png 和 crop2.png 的结果。

```
crop1.png PNG 50x50 100x152+10+10 8-bit DirectClass 4.6kb
crop2.png PNG 50x50 50x50+0+0 8-bit DirectClass 4.56kb
```

除非特殊情况，不然每次使用 -crop 类语句时，都应加上 +repage。


- -gravity 语句

在缺省情况下，原点坐标设在图像的左上角，也就是所谓的 NorthWest。你可以用 -gravity 语句来改变坐标的方向。

例如：

```
convert page100.png -gravity west -crop 50x50+0+0 +repage crop3.png
convert page100.png -gravity east -crop 50x50+0+0 +repage crop4.png
```

-gravity 的参数包括 NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast。大小写都行。

下面的命令在扫描图书时经常会用到

```
convert 2pages.png -crop 50%x100% +repage newpage.png
```

系统自动会生成 newpage-0.png 和 newpage-2.png 两个文件。
请注意，在 -crop 后面跟的是 50%x100%，而不是 50%x100%+0+0。
这句话的意思，是让它按 50%x100% 这样的大小，一块块切下去，能切几块就切几块。
如果你设的是 50%x50%，那它就会切成 4 块。

批量处理：

```
convert page*.png -crop 50%x100% +repage newpaged.png
```

请注意这里的 d。这条命令能自动产生 newpage001.png newpage002.png newpage003.png ……这样的文件。页码顺序不乱。

- -trim 自动切除白边

```
convert page100.png -trim +repage trim.png
```

## 四、旋转与校正

```
convert r90.png -rotate -90 page200.png
```

批量旋转:

```
mogrify -path newdir -rotate -90 *.png
```

结合以前讲的 -rotate 命令，旋转分割一步到位。

```
convert r2pages.png -rotate -90 -crop 50%x100% +repage newpage.png
```

- -background 命令

```
convert page200.png -background blue -rotate 10 r10.png
```

用 -background 设定背景的颜色，有时会用得到

```
convert -list color
```

这个命令列出所有可直接使用的颜色英文名。
IM 支持许多种表示颜色的方法（其它的以后再讲），直接用英文名（如 black, white, red, blue 等）是最方便的。

- -deskew

```
convert page100.png -background white -deskew 40% deskewed.png
```

-deskew 命令用于自动倾斜校正。后面跟一个百分数，手册上推荐你用 40% 这个值(A threshold of 40% works for most images)。

批量校正:

```
mogrify -path newdir -background white -deskew 40% *.png
```

## 五、颜色处理（一）

IM 中有许多调整颜色的方法，让我们先从最无聊的讲起。

```
convert page.png -noop noop.png
```            

- -noop ，表示什么也不做！
放在这里，当然不只是为了凑字数，而是为了让大家熟悉一下中间的那个坐标图。
上面的这个坐标，表示变换前后的两者的颜色值完全一样。不做改变。因此形成了一条45度的对角线。

```
convert page.png -negate negated.png
```              

- -negate 反相。黑变成了白，白变成了黑。
形成 -45 度的直线。
另外请注意中间坐标系下面的两条渐变线。

```
convert page.png -level 25%,75% p1585.png
convert page.png -level 25% p15.png
```

- -level 命令后面如果跟两个参数（用逗号分开），第1个参数 25% 表示将原图颜色中最暗的 25% 变为黑，第二参数 75% 则表示将最亮的 25% 为白。剩下的依线性变换。
当省略第二个参数时，两者取同样的值，因此上面两条命令实际上是一致的。

```
convert page.png -level 0,85% p0-85.png
```
              
你也可以用 +level。

```
convert page.png +level 25% p+25.png
```
               

另外，-level 后面还可以跟第三个参数：

```
convert page.png -level 0,100%,2.0 p0-100-2.0.png
convert page.png -level 0,100%,0.5 p0-100-2.0.png
convert page.png -level 0,85%,0.5 p0-100-2.0.png
```       

用第3个参数来调整 gamma 值。直线变成了曲线.


## 六、颜色处理（二）

下面的这条命令，充分显示了 ImageMagick 有多变态。

```
convert logo.png  -fx "(1/(1+exp(10*(.5-u)))-0.0066928509)*1.0092503" sigmoidal.png
```
     

输完了吗？
祝贺你，你刚完成了一次著名的 sigmoidal 非线性对比度变换。
是的，ImageMagick 就是这么变态，你可以输入完整的公式，对原始图像进行随心所欲的变换。
顺便说一下，sigmoidal 变换是很有用的工具，它对扫描后的文件有很好的效果。
但是，谁又记得住这么长的公式呢？
别担心，ImageMagick 已经替你想到了。

```
convert logo.png  -sigmoidal-contrast 10,50% logo_sigmoidal.png
```

这句命令，和前面那一长串公式达到的效果是一样的，而且好像更快。

ImageMagick 里还有不少命令，可以帮你节约时间。
例如下面的：

```
convert gray_range.jpg  -normalize  normalize_gray.jpg
```

-normalize 的作用是把原图中最暗的部分变成黑，最亮的部分变成白，由此来增强对比度。

``
convert gray_range.jpg  -contrast-stretch 15%  stretch_gray.jpg
```

-contrast-stretch 的作用和 -normalize 是一样的，只是多了个可调节的参数。


## 七、颜色处理（三）


我们在制作图书的时候常常遇到瘦身的问题，ImageMagick 有什么好办法吗？

```
convert logo.png -colors 64 logo64c.png
```

这条命令把颜色数降为 64。你看得出两者的区别吗？反正我是看不出。
现在用 identify 看一下两者的区别：

```
identify *.png
logo.png PNG 202x152 202x152+0+0 8-bit DirectClass 17.4kb
logo64c.png[1] PNG 202x152 202x152+0+0 8-bit PseudoClass 64c 4.84kb
```

一个是 17.4k，一个是 4.84k。
瘦身成功！

类似的命令还有 -monochrome：

```
convert  logo.png  -monochrome     monochrome.gif
```
 
把图片变成黑白两色。

-threshold

```
convert logo.png     -threshold   -1   threshold_0.gif
convert logo.png     -threshold  25%   threshold_25.gif
convert logo.png     -threshold  50%   threshold_50.gif
convert logo.png     -threshold  75%   threshold_75.gif
convert logo.png     -threshold 100%   threshold_100.gif
```       

-threshold 的作用是在颜色世界划一条线，线上的为白，线下的为黑。

 
## 八、在图上写字

 

下面讲一下如何在如何运用字体。

先来看看有哪些字体可用：

```
convert -list font > fonts.txt
```

这条命令会在当前目录下生成 fonts.txt 文件，里面是所有可用的字体列表。

然后是 label 指令。

```
convert -background lightblue -fill blue -font Candice -pointsize 72 label:Anthony label.gif
``` 

label 命令生成一行字。请注意，它前面没有“-”号。如果你要输入一行字就用双引号把它括上。像这样：label:"Hello World!"。
-background 和 -fill 分别设定背景和文字的颜色。
-font 和 -pointsize 设定字体和大小。

但是这条命令不直接支持中文，你必须先把你要写的字存到文本文件里才行：

```
convert -background lightblue -fill blue -font 方正书宋_GBK -pointsize 72 label:@gxsd-utf8.txt gxsd.gif
``` 

冒号后面的 `@` 后面跟的是文件（gxsd-utf8.txt）而不是字符串。
请注意：这个文件必须是不带 Unicode 标志位的 utf-8 文件。

下面介绍 caption:

```
convert -background lightblue -fill blue -font Corsiva -pointsize 36 -size 320x caption:"This is a very long caption line." caption.gif
```
 
caption 的用法和 label 差不多，区别就在于它可以折行。

上面的几种方法都是如何生成单独的图片，如果要在现有图片上印字怎么办呢？
那就用 -annotate:

```
convert page200b.png -font 楷体 -fill white -undercolor #00000080 -gravity South -annotate 0x0+0+10 @anno-utf8.txt anno.png
```
 
-annotate 的格式是这样的：

```
01.-annotate {SlewX}x{SlewY}+{X}+{Y} "字符串"
```

其中 +X+Y是所在的相对位置。（请复习第三章中 -gravity 的用法）。
而 {SlewX}x{SlewY} 则表示倾斜的角度。

 
## 九、绘图

开始之前，先介绍如何用 ImageMagick 生成画布：

```
convert -size 100x100 xc:blue canvas_blue.gif
convert -size 100x100 xc:rgb(0,0,255) canvas_blue.gif
``` 

xc: 生成一块单色的画布，颜色由冒号后面的 blue 或 rgb(0,0,255) 指定，尺寸由 -size 指定。

```
convert -size 50x50 xc:red xc:blue +append red+blue.gif
convert -size 50x50 xc:red xc:blue -append red-blue.gif
```     

用 append 合并图像，请注意 + 和 - 的区别。

接下来是 gradient，渐变：

```
convert  -size 100x100 gradient:  gradient.jpg
convert -size 100x100  gradient:blue gradient_blue.jpg
convert -size 100x100 gradient:red-blue gradient_red_to_blue.jpg
```     

-draw 是最基本的绘图指令。

```
convert -size 100x60 xc:skyblue -fill white -stroke black -draw "rectangle 20,10 80,50" draw_rect.gif
``` 

这条命令是在一块 100x60 大小的天蓝色画布上，画一个白底黑边的长方形，起点为 (20,10)，终点为 (80,50)。

通过加不同的参数，-draw 命令不但可以画长方形，它还画点、直线、圆弧、折线等等。具体的用法和上面的长方形类似，请参考http://www.imagemagick.org/script/command-line-options.php?#draw。

```
convert -size 100x60 xc:skyblue -fill white -stroke black -draw "ellipse 50,30 40,20 0,360" draw_ellipse.gif
convert -size 100x60 xc:skyblue -fill white -stroke black -draw "polyline 40,10 20,50 90,10 70,40" draw_polyline.gif
convert -size 100x60 xc:skyblue -fill white -stroke black -draw "roundrectangle 20,10 80,50 20,15" draw_rrect.gif
convert -size 100x60 xc:skyblue -fill white -stroke black -draw "ellipse 50,30 40,20 45,270" draw_ellipse_partial.gif
convert -size 100x60 xc:skyblue -gravity center -draw "image over 0,0 0,0 'terminal.gif'" draw_image.gif
convert -size 100x60 xc:skyblue -fill white -stroke black -font Candice -pointsize 40 -gravity center -draw "text 0,0 'Hello'" draw_text.gif
```
 