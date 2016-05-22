## ImageMagick 命令行处理 

ImageMagic命令行能像这样简单：

```
convert image.jpg image.png
```
 

或者它很复杂，就像下面的：

```
convert label.gif +matte \ 
\( +clone -shade 110x90 -normalize -negate +clone -compose Plus -composite \) \
\( -clone 0 -shade 110x50 -normalize -channel BG -fx 0 +channel -matte \) \
-delete 0 +swap -compose Multiply -composite button.gif
```
 
不用知道太多ImageMagick命令行，你可能认为上面的第一个命令是转换一个JPEG格式的图像为Png格式。然而，很少有人知道第二个命令，它更加复杂，用丰富的质感和模拟的深度使一个色彩单调的二位符号变成三维

[命令格式快速浏览:上面第二个命令那个太长了，以至于跨越了好几行，所以我们为了清晰，插入反斜线(\)来格式化命令行。反斜线在unix中是续行符。在windows shell中，使用^符号作为续行符。在这些网页中，我们使用Unix风格，就像上面的。然而，有时，如果你的浏览器窗口太小了，命令行被浏览器隐藏了，但是在空白处的命令行，依然会被作为一行打印。续行符不需要被输入了。上面使用反斜线转义的的圆括号在Windows中不转义。在Unix和Windows之间有一些其他的不同之处（包括引号标记，比如），但是我们将在它们出现时再讨论。]

此处我们以一个带有阴影的圆柱展示一个任务的完成百分比：

考虑到示意图的复杂性，你可能为它能用单一的命令行完成感到吃惊：

``` 
convert -size 320x90 canvas:none -stroke snow4 -size 1x90 -tile gradient:white-snow4 \
  -draw 'roundrectangle 16, 5, 304, 85 20,40' +tile -fill snow \
  -draw 'roundrectangle 264, 5, 304, 85  20,40' -tile gradient:chartreuse-green \
  -draw 'roundrectangle 16,  5, 180, 85  20,40' -tile gradient:chartreuse1-chartreuse3 \
  -draw 'roundrectangle 140, 5, 180, 85  20,40' +tile -fill none \
  -draw 'roundrectangle 264, 5, 304, 85 20,40' -strokewidth 2 \
  -draw 'roundrectangle 16, 5, 304, 85 20,40' \( +clone -background snow4 \
  -shadow 80x3+3+3 \) +swap -background none -layers merge \( +size -font Helvetica \
  -pointsize 90 -strokewidth 1 -fill red label:'50 %' -trim +repage \( +clone \
  -background firebrick3 -shadow 80x3+3+3 \) +swap -background none -layers merge \) \
  -insert 0 -gravity center -append -background white -gravity center -extent 320x200 \
  cylinder_shaded.png
```  

在下一节我们仔细分析ImageMagick命令行的结构。如果顺利的话，在仔细阅读和较好地理解命令行如何作用时，你应该能不借助有时候令人畏缩的程序接口完成复杂的图像处理任务。

当使用ImageMagick命令行时阅读《ImageMagick使用案例》得到额外帮助

命令行的结构

ImageMagick命令行包括

一个或多个要求的输入文件名.零个，一个或多个图像设置.零个，一个或多个图像操作.零个，一个或多个图像序列操作符
零个或一个输出图像文件名（required by convert, composite, montage, compare, import, conjure）

你可以在下面的第二节找到命令行每一部分的详细说明

Input Filename 输入文件名

ImageMagick扩展了输入文件名的概念，包括：

- 文件名通配符
- 一个明确的图片格式
- 使用内建的图像和图案
- 标准输入，标准输出，和文件描述符
- 从图像中选择特定帧
- 图像选区
- 使一列图像调整大小
- 剪切一列图像
- 使用文件名引用

下面几段解释这些扩展

Filename Globbing 文件名通配符

在unix shell中，特定的字符诸如（*）和问号（？）根据模式匹配自动生成文件名清单。这种特征就是广为人知的通配。ImageMagick为系统支持文件名通配，比如Windows，不是天生就支持它。举个例子，假设你想转换你当前目录中的1.jpg, 2.jpg, 3.jpg, 4.jpg, and 5.jpg为一个GIF动画。你可以方便地针对所以JPEG文件用此命令：

```
convert *.jpg images.gif
```
 

Explicit Image Format明确图像格式

图像存储在数量极多的图像格式中包括为人熟知的JPEG，PNG，TIFF和其他格式。ImageMagick在读入和处理图像前一定要知道图像的格式。很多格式在图像中有一个能唯一识别该格式的签名。如果没有，ImageMagick使用文件扩展名来决定图像格式。例如，image.jpg 或image.JPG告诉ImageMagick正在读取的图像是JPEG格式。

在某些情况下图像可能没有包含签名 and /or 文件名不能识别图像格式。在这些情况下，必须指定明确的格式。例如，假设我们有一个图像叫做image并且含有raw，red，和blue 色饱和度值。ImageMagick没有办法自动确定此图像的格式，所以我们明确地设定一种：

```
convert –size 640x480 –depth 8 rgb:image image.png
```
 
Built-in Images and Patterns内置图像和图案

ImageMagick有很多内置图像和图案。使用checkerboard 图案，例如，使用：

```
convert -size 640x480 pattern:checkerboard checkerboard.png
```
 
STDIN.STDOUT,and file descriptors 标准输入，标准输出和文件描述符

Unix和Windows允许一条命令的输出通过管道成为另一条命令的输入。ImageMagick允许从标准流 STDIN（标准输入）和STDOUT （标准输出）读写图像数据。分别地，使用一个虚拟文件名 - . 在这个例子中我们传送convert命令的输出到display程序。

```
convert logo: gif:- | display gif:-
```
 
前面的例子中第二个明确的格式”gif”是可选的。GIF 图像在图像中有一个唯一的签名所以ImageMagick的display命令能容易地识别出格式为GIF。convert 程序也用这种方法接受标准输入：

```
convert rose: gif:- | convert - -size “200%” bigrose.jpg
```
 
其他管道可通过它们的文件描述符访问（版本 6.4.9-3）。文件描述符0,1和2分别保留地作为标准流 STDIN，STDOUT，和STDERR，但是与文件描述符数字 N>2关联的管道可以使用假名fd:N访问。（假名fd:0 和 fd:1 可被用作STDIN和STDOUT.）下一个例子展示了如何附加从描述符3和4传过来的图像数据并且把结果导入有文件描述符5的文件里。

```
convert fd:3 fd:4 –append fd:5
```
 
当需要时，可以给出先前提到的明确的图像格式，就像下面的：

``` 
convert gif:fd:3 jpg:fd:4 –append tif:fd:5
```
 

Selecting Frames 选择帧

 

一些图像格式包含不止一个图像帧。或许你只想要第一幅图像。或者最后一幅，或中间的一些图像。你可以指定将读取哪个图像帧通过在文件名后加上用括号包围的帧范围。此处我们的图像（一个GIF动画）包含多个帧，但我们只想要第一个：

``` 
convert 'images.gif[0]' images.png
```
 

[Unix一般会解释括号所以上面我们用引号引起文件名。在Windows shell 括号不会被解释但是使用引号也无妨。然而，在很多情况下，关于Unix和Windows单引号和双引号的角色反转过来，所以Windows用户应在我们显示单引号时使用双引号，反过来也一样。]

你可以从带有帧值域的序列中读取多张图像。例如，你可以从一列图像中提取前四帧：

```
convert 'images.gif[0-3]' images..mng
```
 
完全地，你可以不按顺序地从一列图像中读取多张图像。下一条命令获取序列中的第三副图像，接着是第二幅，然后是第四副：

```
convert 'images.gif[3,2,4]' images..mng
```
 
注意到最后两条命令，生成单一图像。输出在这种情况下，图像格式是MNG，是一个多帧文件因为MNG格式支持多帧。如果输出格式为JPG，只能支持单一帧，输出将会是单独帧组成。下面是更多关于此的，在 Output Filename一节。

 
Selecting an Image Region  图像选区

Raw 图像是一组不含额外数据诸如宽，高，或者图像签名的颜色密度。对于Raw图像格式，你必须指定图像宽和高并且指定读取图像的区域范围。在我们的例子中，图像是raw 8-bit RGB 格式，并且是6000像素宽，4000像素高。然而，我们只要靠近图像中心600x400的区域：

``` 
convert –size 6000x4000 –depth 8 \
'rgb:image[600x400+1900+2900]' image.jpg
```
 

你可以使用-extract选项达到同样结果：

```
convert -size 6000x4000 -depth 8 \
-extract 600x400+1900+2900 rgb:image image.jpg
```
 
Inline Image Resize 调整一列图像的大小

有时候读取图像时调整它们的大小很方便。假设你有上百个大的JPEG图像，你想把它们转换成一列PNG缩略图：

```
convert '*.jpg' –resize 120x120 thumbnaild.png
```
 
此处所有图像被读取随后被调整大小。逐个读取每个图像时更快，占用资源更集中：

```
convert '*.jpg[120x120]' thumbnail.png
```

Inline Image Crop 剪切一列图像

有时候读取图像时剪切它们很方便。假设你有上百个大的JPEG图像，你想把它们转换成一列PNG缩略图：

```
convert '*.jpg' -crop 120x120+10+5 thumbnaild.png
```

此处所有图像被读取随后被调整大小。逐个读取每个图像时更快，占用资源更集中：

```
convert '*.jpg[120x120+10+5]' thumbnaild.png
```
 
Filename References 文件名引用

  有两种方法使用文件名去引用其他图像文件名。第一个就是使用'@',它从指定文件读取用空白隔开的图像文件。假定文件myimages.txt包含一个文件名清单，像这样：

```
  frame001.jpg
  frame002.jpg
  frame003.jpg 
```

我们会有这样的命令：

```
convert @myimages..txt mymovie.gif
```
 
读取图像 frame001.jpg, frame002.jpg, and frame003.jpg并把它们转换成GIF图像序列

如果图像路径包含一个或多个空格，用引号包围路径：

```
'my title.jpg'
```

有些ImageMagick命令行选项会超出你的命令行解释器的能力。Windows，例如，限制命令行为8192个字符。如果，例如，你有一个带有多边形箭头的draw选项超过了命令行长度限制，把draw 选项放入一个文件并用@符号引用此文件（e.g.@mypoly.txt）

另一种引用其他图像文件的方法是通过在带有值域的文件名中嵌入格式字符。考虑文件名image-%d.jpg[1-5]. 命令是：

```
convert image-%d.jpg[1-5]
```
 
让ImageMagick尝试读取带有这些文件名的图像：

```
  image-1.jpg
  image-2.jpg
  image-3.jpg
  image-4.jpg
  image-5.jpg
```
 

ImageSetting

 图像设置一直存留当它出现在命令行上时并且可能影响随后的处理比如读取图像，一个图像操作符，或当写如图像占位符时。图像设置保持作用直到被重置或命令行终止。图像设置包括：

```
‑adjoin  • ‑affine  • ‑alpha  • ‑antialias  • ‑authenticate  • ‑background  • ‑bias  • ‑black‑point‑compensation  • ‑blue‑primary  • ‑bordercolor  • ‑caption  • ‑channel  • ‑comment  • ‑compress  • ‑debug  • ‑define  • ‑delay  • ‑density  • ‑depth  • ‑direction  • ‑display  • ‑dispose  • ‑dither  • ‑encoding  • ‑endian  • ‑extract  • ‑family  • ‑fill  • ‑filter  • ‑font  • ‑format  • ‑fuzz  • ‑geometry  • ‑gravity  • ‑green‑primary  • ‑interlace  • ‑intent  • ‑interpolate  • ‑label  • ‑limit  • ‑linewidth  • ‑log  • ‑loop  • ‑mask  • ‑mattecolor  • ‑monitor  • ‑orient  • ‑page  • ‑pointsize  • ‑preview  • ‑quality  • ‑quiet  • ‑red‑primary  • ‑region  • ‑render  • ‑repage  • ‑sampling‑factor  • ‑scene  • ‑seed  • ‑size  • ‑stretch  • ‑stroke  • ‑strokewidth  • ‑style  • ‑texture  • ‑tile  • ‑transparent‑color  • ‑treedepth  • ‑type  • ‑undercolor  • ‑units  • ‑verbose  • ‑virtual‑pixel  • ‑weight
```
 

在此例中，-channel 应用到每幅图像上，因此，就如我们提到的，设置会存留：

```
convert –channel RGB wand.png wizard.png images.png
```
 

ImageMagick 命令行处理

ImageMagic命令行能像这样简单：

```
convert image.jpg image.png
```
 

或者它很复杂，就像下面的：

```
convert label.gif +matte \ 
\( +clone -shade 110x90 -normalize -negate +clone -compose Plus -composite \) \
\( -clone 0 -shade 110x50 -normalize -channel BG -fx 0 +channel -matte \) \
-delete 0 +swap -compose Multiply -composite button.gif
```
 
不用知道太多ImageMagick命令行，你可能认为上面的第一个命令是转换一个JPEG格式的图像为Png格式。然而，很少有人知道第二个命令，它更加复杂，用丰富的质感和模拟的深度使一个色彩单调的二位符号变成三维

[命令格式快速浏览:上面第二个命令那个太长了，以至于跨越了好几行，所以我们为了清晰，插入反斜线(\)来格式化命令行。反斜线在unix中是续行符。在windows shell中，使用^符号作为续行符。在这些网页中，我们使用Unix风格，就像上面的。然而，有时，如果你的浏览器窗口太小了，命令行被浏览器隐藏了，但是在空白处的命令行，依然会被作为一行打印。续行符不需要被输入了。上面使用反斜线转义的的圆括号在Windows中不转义。在Unix和Windows之间有一些其他的不同之处（包括引号标记，比如），但是我们将在它们出现时再讨论。]


此处我们以一个带有阴影的圆柱展示一个任务的完成百分比：

考虑到示意图的复杂性，你可能为它能用单一的命令行完成感到吃惊： 

```
convert -size 320x90 canvas:none -stroke snow4 -size 1x90 -tile gradient:white-snow4 \
  -draw 'roundrectangle 16, 5, 304, 85 20,40' +tile -fill snow \
  -draw 'roundrectangle 264, 5, 304, 85  20,40' -tile gradient:chartreuse-green \
  -draw 'roundrectangle 16,  5, 180, 85  20,40' -tile gradient:chartreuse1-chartreuse3 \
  -draw 'roundrectangle 140, 5, 180, 85  20,40' +tile -fill none \
  -draw 'roundrectangle 264, 5, 304, 85 20,40' -strokewidth 2 \
  -draw 'roundrectangle 16, 5, 304, 85 20,40' \( +clone -background snow4 \
  -shadow 80x3+3+3 \) +swap -background none -layers merge \( +size -font Helvetica \
  -pointsize 90 -strokewidth 1 -fill red label:'50 %' -trim +repage \( +clone \
  -background firebrick3 -shadow 80x3+3+3 \) +swap -background none -layers merge \) \
  -insert 0 -gravity center -append -background white -gravity center -extent 320x200 \
  cylinder_shaded.png
```  

在下一节我们仔细分析ImageMagick命令行的结构。如果顺利的话，在仔细阅读和较好地理解命令行如何作用时，你应该能不借助有时候令人畏缩的程序接口完成复杂的图像处理任务。


当使用ImageMagick命令行时阅读《ImageMagick使用案例》得到额外帮助


命令行的结构

   ImageMagick命令行包括

- 一个或多个要求的输入文件名.
- 零个，一个或多个图像设置.
- 零个，一个或多个图像操作.
- 零个，一个或多个图像序列操作符
- 零个或一个输出图像文件名（required by convert, composite, montage, compare, import, conjure）

你可以在下面的第二节找到命令行每一部分的详细说明

Input Filename 输入文件名

 
 ImageMagick扩展了输入文件名的概念，包括：

- ·文件名通配符
- ·一个明确的图片格式
- ·使用内建的图像和图案
- ·标准输入，标准输出，和文件描述符
- ·从图像中选择特定帧
- ·图像选区
- ·使一列图像调整大小
- ·剪切一列图像
- ·使用文件名引用

 
下面几段解释这些扩展

Filename Globbing 文件名通配符

在unix shell中，特定的字符诸如（*）和问号（？）根据模式匹配自动生成文件名清单。这种特征就是广为人知的通配。ImageMagick为系统支持文件名通配，比如Windows，不是天生就支持它。举个例子，假设你想转换你当前目录中的1.jpg, 2.jpg, 3.jpg, 4.jpg, and 5.jpg为一个GIF动画。你可以方便地针对所以JPEG文件用此命令：

```
convert *.jpg images.gif
```
 
Explicit Image Format明确图像格式

图像存储在数量极多的图像格式中包括为人熟知的JPEG，PNG，TIFF和其他格式。ImageMagick在读入和处理图像前一定要知道图像的格式。很多格式在图像中有一个能唯一识别该格式的签名。如果没有，ImageMagick使用文件扩展名来决定图像格式。例如，image.jpg 或image.JPG告诉ImageMagick正在读取的图像是JPEG格式。


在某些情况下图像可能没有包含签名 and /or 文件名不能识别图像格式。在这些情况下，必须指定明确的格式。例如，假设我们有一个图像叫做image并且含有raw，red，和blue 色饱和度值。ImageMagick没有办法自动确定此图像的格式，所以我们明确地设定一种：

```
convert –size 640x480 –depth 8 rgb:image image.png
```
 
Built-in Images and Patterns内置图像和图案

ImageMagick有很多内置图像和图案。使用checkerboard 图案，例如，使用：

```
convert -size 640x480 pattern:checkerboard checkerboard.png
```
 

STDIN.STDOUT,and file descriptors 标准输入，标准输出和文件描述符

 

Unix和Windows允许一条命令的输出通过管道成为另一条命令的输入。ImageMagick允许从标准流 STDIN（标准输入）和STDOUT （标准输出）读写图像数据。分别地，使用一个虚拟文件名 - . 在这个例子中我们传送convert命令的输出到display程序。

```
convert logo: gif:- | display gif:-
```
 
前面的例子中第二个明确的格式”gif”是可选的。GIF 图像在图像中有一个唯一的签名所以ImageMagick的display命令能容易地识别出格式为GIF。convert 程序也用这种方法接受标准输入：

```
convert rose: gif:- | convert - -size “200%” bigrose.jpg
```
 
其他管道可通过它们的文件描述符访问（版本 6.4.9-3）。文件描述符0,1和2分别保留地作为标准流 STDIN，STDOUT，和STDERR，但是与文件描述符数字 N>2关联的管道可以使用假名fd:N访问。（假名fd:0 和 fd:1 可被用作STDIN和STDOUT.）下一个例子展示了如何附加从描述符3和4传过来的图像数据并且把结果导入有文件描述符5的文件里。

```
convert fd:3 fd:4 –append fd:5
```
 
当需要时，可以给出先前提到的明确的图像格式，就像下面的：

```
convert gif:fd:3 jpg:fd:4 –append tif:fd:5
```
 
Selecting Frames 选择帧

 
一些图像格式包含不止一个图像帧。或许你只想要第一幅图像。或者最后一幅，或中间的一些图像。你可以指定将读取哪个图像帧通过在文件名后加上用括号包围的帧范围。此处我们的图像（一个GIF动画）包含多个帧，但我们只想要第一个：

```
convert 'images.gif[0]' images.png
```
 

[Unix一般会解释括号所以上面我们用引号引起文件名。在Windows shell 括号不会被解释但是使用引号也无妨。然而，在很多情况下，关于Unix和Windows单引号和双引号的角色反转过来，所以Windows用户应在我们显示单引号时使用双引号，反过来也一样。]


你可以从带有帧值域的序列中读取多张图像。例如，你可以从一列图像中提取前四帧：

```
convert 'images.gif[0-3]' images..mng
```
 
完全地，你可以不按顺序地从一列图像中读取多张图像。下一条命令获取序列中的第三副图像，接着是第二幅，然后是第四副：

```
convert 'images.gif[3,2,4]' images..mng
```
 

注意到最后两条命令，生成单一图像。输出在这种情况下，图像格式是MNG，是一个多帧文件因为MNG格式支持多帧。如果输出格式为JPG，只能支持单一帧，输出将会是单独帧组成。下面是更多关于此的，在 Output Filename一节。

Selecting an Image Region  图像选区

Raw 图像是一组不含额外数据诸如宽，高，或者图像签名的颜色密度。对于Raw图像格式，你必须指定图像宽和高并且指定读取图像的区域范围。在我们的例子中，图像是raw 8-bit RGB 格式，并且是6000像素宽，4000像素高。然而，我们只要靠近图像中心600x400的区域：

```
convert –size 6000x4000 –depth 8 \
'rgb:image[600x400+1900+2900]' image.jpg
```
 
你可以使用-extract选项达到同样结果：

```
convert -size 6000x4000 -depth 8 \
-extract 600x400+1900+2900 rgb:image image.jpg
```
 
Inline Image Resize 调整一列图像的大小

有时候读取图像时调整它们的大小很方便。假设你有上百个大的JPEG图像，你想把它们转换成一列PNG缩略图：

```
convert '*.jpg' –resize 120x120 thumbnaild.png
```
 
此处所有图像被读取随后被调整大小。逐个读取每个图像时更快，占用资源更集中：

```
convert '*.jpg[120x120]' thumbnail.png
```
 
Inline Image Crop 剪切一列图像

有时候读取图像时剪切它们很方便。假设你有上百个大的JPEG图像，你想把它们转换成一列PNG缩略图：

``` 
convert '*.jpg' -crop 120x120+10+5 thumbnaild.png
```

此处所有图像被读取随后被调整大小。逐个读取每个图像时更快，占用资源更集中：

```
convert '*.jpg[120x120+10+5]' thumbnaild.png
```
 
Filename References 文件名引用

  有两种方法使用文件名去引用其他图像文件名。第一个就是使用'@',它从指定文件读取用空白隔开的图像文件。假定文件myimages.txt包含一个文件名清单，像这样：

```
  frame001.jpg
  frame002.jpg
  frame003.jpg 
```

我们会有这样的命令：

```
convert @myimages..txt mymovie.gif
```
 
读取图像frame001.jpg, frame002.jpg, and frame003.jpg并把它们转换成GIF图像序列


如果图像路径包含一个或多个空格，用引号包围路径：

```
'my title.jpg'
```

有些ImageMagick命令行选项会超出你的命令行解释器的能力。Windows，例如，限制命令行为8192个字符。如果，例如，你有一个带有多边形箭头的draw选项超过了命令行长度限制，把draw 选项放入一个文件并用@符号引用此文件（e.g.@mypoly.txt）

另一种引用其他图像文件的方法是通过在带有值域的文件名中嵌入格式字符。考虑文件名image-%d.jpg[1-5]. 命令是：

```
convert image-%d.jpg[1-5]
```
 
让ImageMagick尝试读取带有这些文件名的图像：

```
  image-1.jpg
  image-2.jpg
  image-3.jpg
  image-4.jpg
  image-5.jpg
```
 

ImageSetting

 图像设置一直存留当它出现在命令行上时并且可能影响随后的处理比如读取图像，一个图像操作符，或当写如图像占位符时。图像设置保持作用直到被重置或命令行终止。图像设置包括：

```
‑adjoin  • ‑affine  • ‑alpha  • ‑antialias  • ‑authenticate  • ‑background  • ‑bias  • ‑black‑point‑compensation  • ‑blue‑primary  • ‑bordercolor  • ‑caption  • ‑channel  • ‑comment  • ‑compress  • ‑debug  • ‑define  • ‑delay  • ‑density  • ‑depth  • ‑direction  • ‑display  • ‑dispose  • ‑dither  • ‑encoding  • ‑endian  • ‑extract  • ‑family  • ‑fill  • ‑filter  • ‑font  • ‑format  • ‑fuzz  • ‑geometry  • ‑gravity  • ‑green‑primary  • ‑interlace  • ‑intent  • ‑interpolate  • ‑label  • ‑limit  • ‑linewidth  • ‑log  • ‑loop  • ‑mask  • ‑mattecolor  • ‑monitor  • ‑orient  • ‑page  • ‑pointsize  • ‑preview  • ‑quality  • ‑quiet  • ‑red‑primary  • ‑region  • ‑render  • ‑repage  • ‑sampling‑factor  • ‑scene  • ‑seed  • ‑size  • ‑stretch  • ‑stroke  • ‑strokewidth  • ‑style  • ‑texture  • ‑tile  • ‑transparent‑color  • ‑treedepth  • ‑type  • ‑undercolor  • ‑units  • ‑verbose  • ‑virtual‑pixel  • ‑weight
```
 

在此例中，-channel 应用到每幅图像上，因此，就如我们提到的，设置会存留：

```
convert –channel RGB wand.png wizard.png images.png
```
Image Operator 图像操作符 

 

图像操作符不同于图像设置，它立即对图像产生作用当它出现在命令行上时。一个图像操作符是任意的非列出的图像设置或图像序列操作符命令行选项。不像图像设置，存留到命令行终止，图像操作符应用到一幅图像后就消失了。图像操作符包括：

 
```
‑annotate  • ‑black‑threshold  • ‑blur  • ‑border  • ‑charcoal  • ‑chop  • ‑clip  • ‑clip‑path  • ‑clip‑mask  • ‑colors  • ‑colorize  • ‑colorspace  • ‑compose  • ‑contrast  • ‑convolve  • ‑crop  • ‑cycle  • ‑despeckle  • ‑draw  • ‑edge  • ‑emboss  • ‑enhance  • ‑equalize  • ‑evaluate  • ‑extent  • ‑flip  • ‑flop  • ‑floodfill  • ‑frame  • ‑gamma  • ‑gaussian‑blur  • ‑implode  • ‑lat  • ‑level  • ‑map  • ‑median  • ‑modulate  • ‑monochrome  • ‑negate  • ‑noise  • ‑normalize  • ‑opaque  • ‑ordered‑dither  • ‑paint  • ‑posterize  • ‑raise  • ‑profile  • ‑radial‑blur  • ‑raise  • ‑random‑threshold  • ‑resample  • ‑resize  • ‑roll  • ‑rotate  • ‑sample  • ‑scale  • ‑sepia‑tone  • ‑segment  • ‑shade  • ‑shadow  • ‑sharpen  • ‑shave  • ‑shear  • ‑sigmoidal‑contrast  • ‑solarize  • ‑splice  • ‑spread  • ‑strip  • ‑swirl  • ‑threshold  • ‑transparent  • ‑thumbnail  • ‑tint  • ‑transform  • ‑trim  • ‑unsharp  • ‑version  • ‑wave  • ‑white‑point  • ‑white‑threshold
```
 
在这个例子中，-negate 使wand图像负片而不是wizard:
 
```
convert wand.png –negate wizard.png images.png
```
 

Image Sequence Operator 图像序列操作符

图像序列操作符不同于图像设置，它立即影响图像序列当它出现在命令行上时。从这些图像操作符中选择：

 ```
‑append  • ‑affinity  • ‑average  • ‑clut  • ‑coalesce  • ‑combine  • ‑composite  • ‑crop  • ‑debug  • ‑deconstruct  • ‑delete  • ‑evaluate‑seqence  • ‑fft  • ‑flatten  • ‑fx  • ‑hald‑clut  • ‑ift  • ‑identify  • ‑insert  • ‑layers  • ‑limit  • ‑map  • ‑maximum  • ‑minimum  • ‑morph  • ‑mosaic  • ‑optimize  • ‑print  • ‑process  • ‑quiet  • ‑separate  • ‑swap  • ‑write
```
 

Image Geometry 几何图像


 许多命令行选项都有一个geometry 参数指定这样的东西如要求图像的宽和高和其他尺寸的量。因为用户想得到各种各样的图像的尺寸，大小，位置的结果（并且因为ImageMagick支持它们），geometry 参数能出现多种形式。我们在这一节描述他们中的多数。

 

带有geometry 参数的图像选项和设置包括如下。记住从语法上分析有些参数略有不同。更多细节，请分别查看option或setting的说明

```
‑adaptive‑resize  • ‑border  • ‑borderwidth  • ‑chop  • ‑crop  • ‑density  • ‑extent  • ‑extract  • ‑frame  • ‑geometry  • ‑iconGeometry  • ‑liquid‑rescale  • ‑page  • ‑region  • ‑repage  • ‑resize  • ‑sample  • ‑scale  • ‑shave  • ‑splice  • ‑thumbnail  • ‑window
```
 

Geometry 参数可能是下表列出的任何形式。这些将在下表分段详细描述。通常的形式是size[offset],即size是必须的，offset是可选的。特殊场合下，[size]offset也可以。在任何情况下gemetry参数中都不允许空格出现。

 
```
Size                一般描述（事实上行为因不同的选项和设置变化）
Scale%              高和宽都按指定的百分比测量
Scale-x%xscale-y%   高和宽分别都按指定百分比测量（只需要一个%号）
Width               给定宽度，高度会自动选择以保持宽高比
xheight             给定高度，宽度自动选择以保持宽高比
widthxheight        给定宽和高的最大值，保持宽高比
widthxheight^       给定宽和高的最小值，保持宽高比
widthxheight!       Width and height emphatically given, original aspect ratio ignored.
widthxheight>       Change as per widthxheight but only if an image dimension exceeds a specified dimension.
Widthxheight<       仅当宽和高都超过指定尺寸时改变尺寸
area@               调整图像大小到指定像素面积。保持宽高比。
{size}{offset}      指定偏移量（默认为+0+0）.下面，{size}指的是上面出现的任何形式。
{size}{+-}x{+-}y    水平和垂直偏移量x和y，用像素指定。两者都需要标记。偏移量受-gravity 设置影响。偏移量不受 %或其他size操作符影响。
```
 
对图像的基本调整；操作符%,^,和!

 此处，就是下面，是一些简单的geometry的例子展示它作为-resize的参数是如何使用的。我们将使用内置图像logo: 作为输入图像。这个不错的图像有640像素宽，480像素高。我们说他的尺寸是640x480。当我们给出一个图像的尺寸时，宽度（水平尺寸）总是在高度（垂直尺寸）之前。当我们谈到图像的坐标或偏移量时这会是对的，它总是x值后跟着y值。你就想想高中代数课程和xy水平坐标系（Well，几乎，我们的y轴总是向下的！）

 ```
convert logo： -resize '200%'     bigWiz.png
convert logo: -resize '200x50%'  longShortWiz.png
convert logo: -resize '100x200'  notThinWiz.png
convert logo: -resize '100x200^' biggerNotThinWiz.png
convert logo: -resize '100x200!' dochThinWiz.png
```
 
4个命令中的第一个很简单-------它从各个方向把输入图像的宽和高都拉伸200%；它用两个因子放大整个图像。第二条命令为每个方向指定不同的百分比，把图像的宽拉伸200%并且挤压高度为50%。结果图（此例中）尺寸为1280x240。注意到%号不需要重复一次；下面的与它相同：

```
200x50%， 200%x50，200%x50%
```

默认的，geometry参数给定的宽和高是最大值除非指定了一个百分比。那就是，图像扩大或缩小到指定的宽高值而保持图像的宽高比（它的高和宽的比率）。例如，上面的第三条命令“试图”设置图像尺寸为100x200。假设逐步收缩原图像（它是640x480），保持它的宽高比始终不变，直到它达到100x200的矩形。因为图像难以置信的长，当它的宽度缩为100像素时。为了保持宽高比，高度因此不得不变为（480/640）x100像素=75像素，所以最后尺寸为100x75

注意到在前面的例子中，至少有一个指定的尺寸会得到（在此情况下，宽度为100像素）结果图在原图范围内调整适应.你可以引用^操作符得到与之相反的结果。就像上面的第四个命令。在那种情况下，当100x200^作为参数时，再次，至少会得到一个尺寸，但是这种情况下，结果图可以紧含在原图中。此处geometry给出最小的值。在我们的例子中，高将会变为200并且宽会被调整以保持宽高比，变成（640x480）x200像素=267像素。通过^操作符，其中的一个尺寸会匹配所要求的大小，但是图像很可能超出要求的尺寸以保持宽高比。（^功能在IM 6.3.8-2是新的）

我们看到ImageMagick在保持图像宽高比方面很出色，防止你喜欢的图像和照片失真。但是你可能真的想要尺寸变为100x200，因此拉伸图像。在这种情况下，仅仅告诉ImageMagick你真的想要（!）通过在geometry参数后附加一个感叹号。这样会强制使图像变为你指定的大小。所以，如果你指定100x200! ，图像尺寸会恰恰变成100x200（给出一个小的，垂直的，狭长的Wizard）

限定宽，高和面积；操作符>,<和@

此有更多例子：

```
convert logo: -resize '100' wiz1.png
convert logo: -resize 'x200' wiz2.png
convert logo: -resize '100x200>' wiz3.png
convert logo: -resize '100x200<' wiz4.png
```
 
当只指定宽度时，就如上面的第一个例子，宽度就是所给值，高度选为能保持输入图像宽高比的值。类似的，如果只指定了高度，就如上面的第二个例子，高度被接受并且宽度被选择保持宽高比。

除非其中之一的几何规格超出图像原来的宽和高才使用>改变图像尺寸。除非图像原来的尺寸超过几何规格才用<调整图像大小。在任一情况下，如果发生变化，结果就像>或>操作符不存在一样。所以，在上面的第三个例子中，我们指定了100x200> 并且原图像大小是640x480，所以图像大小减小就如我们指定了100x200一样。然而，上面第四个例子图像大小将没有变化。

最后，使用@指定图像的最大像素面积，再次，与此同时保持图像宽高比。（像素只取整数值，所以一些近似值通常也有效）在下面的例子中，要求10000像素面积。结果图文件尺寸是115x86，它有9890像素。

```
convert logo: -resize '@10000' wiz10000.png
```
 
关于引号的另一句话：在上面和下面所有的例子中，我们用引号引起了gemotery 参数。在很多情况下这是可选的，但不总是。我们必须在使用<或>时用引号引起几何规格以防这些字符被shell解释为文件重定向符号。在Windows操作系统上，、符号^需要在引号内，否则会被忽略。为了安全，或许应该保持把geometry 参数放在引号中的习惯，就像我们这里一样。

Geometry的偏移量

这是一些说明geometry参数中偏移量用法的例子。偏移量的一种典型用法就是结合 –region 选项。这个选项允许很多其他选项修改图像中指定的矩形子区域的像素。照此，需要给出哪个区域的宽和高，还有相对图像的偏移量，它是一对坐标，指明了该区域在整个更大图像中的位置。下面，在第一个例子中，我们指定一个区域大小为100x200，位置在xy-坐标 x=10,y=20.为了方便，让我们用惯常的代数记号(x,y)=(10,20).

```
convert logo: -region '100x200+10+20' –negate wizNeg1.png
convert logo: -region '100x200-10+20' -negate wizNeg2.png
convert logo: -gravity center -region '100x200-10+20' -negate wizNeg3.png
```
 

注意偏移量总需要+/-符号。偏移量实际上并非图像中的位置；它的坐标必须加到其他位置。让我们称之为当前位置。在上面的前两个例子中，尽管，该位置为图像的左上角，它的坐标为(0,0)(那是默认位置当没有其他给出的指令改变它时)。上面第一个例子将100x200的矩形放到左上角坐标(10,20)处。

一个负的偏移量在很多情况下有意义。在上面的第二个例子中，偏移量是(-10,20),被指定为-10+20.在此情况下，只有图像中那个矩形位置的部分图像成为负片。此处指定的geometry 为90x200+0+20与之相当。

在上面的第三个例子中，-gravity 设置在其他参数之前，并且设置当前位置在图像的正中心。在此情况下，即在像素(320,240)处，因为图像大小为640x480。这意味着偏移量应用到那个位置，它因而移动位置了，此时，到了(320-10,240+20)=(310,260).但是10x200区域本身受到 –gravity 设置的影响，所以，不是影响它的左上角，the region's own center (at (+50,+100) within it) is determined.因此，100x200的矩形中心移动到了(310,260).现在左上角负片变成了（310-50,260-100）=(260,160).

## 图像堆栈

在学校里，你的老师可能允许你在一张演草纸上演算问题然后把结果抄到试卷上。图像堆栈与之相似。它允许你孤立地在一幅图像或图像序列上工作并随后把结果导回命令行。图像堆栈用圆括号描述。图像操作符仅影响当前堆栈中的图像。例如，我们能限定图像旋转为wizard图像像这样：

```
convert wand.gif  \( wizard.gif –rotate 30  \)  +append  images.gif
```
 

再次注意括号被他们前面的反斜线转义了。这在Unix上是必须的，此处圆括号是特殊的shell字符。反斜线告诉shell不要解释这些字符，而是直接传递给命令行执行。在Windows下不需要转义括号。每个括号（或者转义的括号）两边都要有空格，就像上面的示例那样。
 

除了已经讨论过的图像操作符，下面的图像操作符在图像堆栈中处理图像更有用。

```
‑clone  • ‑delete  • ‑insert  • ‑swap  •
```
 

这些图像操作符的参数是图像序列的数字索引，从0开始，为第一个图像，以此类推。然而，如果你给出一个负的索引，图像从最后开始索引（最后一个图像算起）。即，索引 -1 在当前图像序列中是最后一幅图像。，-2是倒数第二个，以此类推。


输出文件名

ImageMagick 扩展了输出文件的概念，包括：

- 一个明确的图像格式
- 写到标准输出
- 文件名引用


在下面几段中解释其中的每一部分

明确的图像格式

图像存储在数量极多的图像格式中包括为人熟知的JPEG，PNG，TIFF和其他格式。ImageMagick在写入图像前一定要知道图像的格式。ImageMagick使用文件扩展名来决定图像格式。例如，image.jpg 或image.JPG告诉ImageMagick正在读取的图像是JPEG格式。

在某些情况下文件名不能识别图像格式。在这些情况下，图像写入的格式就是它原来读取的格式除非指定了明确的格式。例如，假设我们有一个图像叫做image并且是raw，red，和blue 强烈格式：

```
convert image.jpg rgb:image
```
 
标准输出：

Unix允许一个命令的输出通过管道传送到另一命令中。Imagemagick允许使用文件名 – 将一个命令传给另一个命令。在此例子中我们将convert的输出传给程序display

```
convert logo: gif:- | display gif:-
```

此处明确的格式是可选的GIF图像格式有一个签名能唯一识别图像所以ImageMagick能容易地识别格式为gif


文件名引用

使用嵌入的格式字符去些写个按序排列的图像清单。假设我们的输出文件名是 image-%d.jpg 并且我们的图像清单包含3个图像。你可能期望图像文件写为：

```
image-0.jpg
image-1.jpg
image-2.jpg
```

或检索图像属性去修改图像文件名。例如，命令

 
```
convert rose: -set filename:area '%wx%h' \
'rose-%[filename:area].png'
```
 

用此文件名写入图像

rose-70x46.jpg

最后，转换多个JPEG图像为单独的PDF页，用：

```
convert *.jpg +adjoin page-%d.pdf
```