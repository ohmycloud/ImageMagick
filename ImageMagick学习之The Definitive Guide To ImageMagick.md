## ImageMagick学习之 The Definitive Guide To ImageMagick

```
convert -contrast -contrast -contrast -contrast in.jpg out.png  # 增强对比，contrast选项可以有多个
convert -append zx.jpg modulate.jpg modulate145.jpg append.jpg  # 垂直排列
convert -append zx.jpg modulate.jpg modulate145.jpg -border 5 append-border.jpg # 垂直排列后加上边框
```

## The Definitive Guide To ImageMagick之添加边框

给图像添加边框

A commonly requested operation that ImageMagick can help you with is creating borders on
images. To make simple, single-colored borders, you just use the border command-line option.
This option takes two arguments—the horizontal width of the border and the vertical height
of the border. For this example, I’ll show how to put a 5×10-pixel border around an image. This
will result in the image being 10 （5+5）pixels wider and 20（10+10） pixels higher than it was before. The com-
mand line to do this is as follows:

```
convert -border 5x10 input.jpg output.jpg
#添加一个宽度为5，长度为10的边框
```

You can specify the color of the border by using the bordercolor command-line option.
For example, if you want to make the border green, then you use the following command line:

```
convert -bordercolor green -border 5x10 input.jpg output.jpg
```

如果想要边框的宽和高一样，只要在命令行中使用一个数字即可： 例如，下面的:

```
convert -border 5 input.jpg output.jpg
```

与此相同:

```
convert -border 5x5 input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之旋转图像

The rotate command-line option takes one argument, which is the number of degrees by
which to rotate the image. A positive number is the number of degrees to the right, and a neg-
ative number is the number of degrees to the left.

To rotate this picture 45 degrees to the left, use the following command line:

```
convert -rotate -45 input.jpg output.jpg
```

Rotating the image 30 degrees to the right requires the following command line:

```
convert -rotate 30 input.jpg output.jpg
```
 
You can also apply conditional schematics to the rotation by adding a greater-than or
less-than sign to the argument. For example, to rotate the image only if its width is greater
than its height, then add a greater-than sign:

```
convert -rotate -15^> input.jpg output.jpg
```

To perform the inverse and rotate only if its height is greater than its width, use a less-than sign:

```
convert -rotate 60^< input.jpg output.jpg
```

Remember that depending on your operating system and the shell you use, greater-than
and less-than signs might be interpreted as shell commands. If they are, then you’ll need to
escape them using whatever mechanism your shell uses.Winddows中用^转义>号.


添加背景色：

```
convert -background red -rotate 30 input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之对比度

ImageMagick can manipulate the amount of contrast in an image, either by adding more
contrast to images or by reducing it. To add more contrast to an image, use the contrast
command-line option:

```
convert -contrast input.jpg output.jpg
```

If you need to add even more contrast, then specify the command-line option more than
once. For example:

```
convert -contrast -contrast input.jpg output.jpg #增加更多的对比度
```

较少对比度：

You can also reduce the contrast present in an image. To do this, use a plus sign as the first
character of the command-line option instead of aminus sign, like this:

```
convert +contrast input.jpg output.jpg
```

Again, specifying more than one occurrence of the +contrast command-line option will
result in the effect of the operation being more pronounced.

```
convert +contrast +contrast input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之图像抖动

Dithering an Image

Dithering reduces the number of colors in an image. The most common example in everyday
use is turning color images into strict black-and-white images for use in newspapers. Dithering
works in amonochrome context by determining the brightness of a given color and then using
the right frequency of black dots per area to imply that brightness.

To dither this image into monochrome（黑白相片）, you use a command line like this:
convert -dither -monochrome input.jpg output.jpg

You don’t have to dither to monochrome, though—you can also dither to different num-
bers of colors using the colors command-line option discussed in Chapter 2. For example,
this command limits the picture to using eight colors:

```
convert -dither -colors 8 input.jpg output.jpg
```

To use the dither command-line option, you must specify either the monochrome
command-line option or the colors command-line option

## The Definitive Guide To ImageMagick之图像均衡

Equalizing an Image

ImageMagick can also apply histogram equalization to an image

Flipping an Image

ImageMagick refers to turning an image upside down as a flip.

You use this command line:

```
convert -flip input.jpg output.jpg
```

To flip the image horizontally, use the flop operation:

```
convert -flop input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之图像着色

You can also apply tint colors to images with ImageMagick. The tint command-line option
will add the specified percentage of the current fill color to the image. Only the nonpure colors
in the image will be affected; in other words, pure colors such as red and green won’t change.

```
convert -fill blue -tint 15% zx.jpg zx15blue.jpg
convert -fill blue -tint 35% zx.jpg zx35blue.jpg
convert -fill blue -tint 55% zx.jpg zx55blue.jpg
convert -fill blue -tint 75% zx.jpg zx75blue.jpg
```

If you don’t specify a fill color, you get the default tint of black. To apply a 10 percent tint
to an image, you use a command line like this:

```
convert -fill red -tint 10% input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之负片

Negating a pixel is the process of inverting its value. ImageMagick can negate images with the
negate command-line option. This is similar to the solarize option except that no threshold is applied to the decision to negate a given pixel.

In contrast, the solarize （曝光）command gives you the images for varying
levels of threshold（阈值）.

```
convert -solarize 1 input.jpg output.jpg
convert -solarize 31 input.jpg output.jpg
convert -solarize 61 input.jpg output.jpg
convert -solarize 91 input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之正态化，增强和调整图像

Normalization is the process of improving the contrast in an image so that it uses all the avail-
able color range.


Another way to correct contrast problems in an image is to enhance the photo using the
level command-line option. This option lets you specify the black point (the color that is con-
sidered black in the image) that you’d like in the output image. You can specify this as an
absolute value ranging from zero to the maximum RGB value possible in the image, but in this
example I’ll specify this as a percentage, because this is amore generically useful technique.
To specify a black point of 20 percent of the maximum possible RGB value, use a command
like this:

```
convert -level 20% input.jpg output.jpg
convert -level 35% input.jpg output.jpg
convert -level 55% input.jpg output.jpg
convert -level 75% input.jpg output.jpg
```

You can also specify a desired white point for the image. You do this by adding another
value to the specification argument. The following command specifies a white point of 50
percent of the maximum RGB value for the image, again using percentages:

```
convert -level 20%,50% input.jpg output.jpg
convert -level 20%,15% input.jpg output.jpg
convert -level 20%,35% input.jpg output35.jpg
convert -level 20%,55% input.jpg output55.jpg
convert -level 20%,75% input.jpg output75.jpg
```

A border has been added to these images for clarity. You can see from these examples that
a white point higher than the black point produces a much nicer result. Finally, you can also
specify a gamma correction value like this:

```
convert -level 20%,50%,1.0 input.jpg output.jpg
```

where the default is 1.0, which is what is specified in this example.Another way of tweaking the way an image looks is to modify the brightness, color saturation, and hue through modulation. You do this with ImageMagick with the modulate
command. The following command line manipulates the brightness of an image:

```
convert -modulate 80% input.jpg output.jpg
```

This changes the brightness to 80 percent of the current brightness of the image.

```
convert -modulate 15% input.jpg output.jpg
convert -modulate 55% input.jpg output.jpg
convert -modulate 95% input.jpg output95.jpg
convert -modulate 145% input.jpg output145.jpg
```

## The Definitive Guide To ImageMagick之调整亮度、色度、饱和度

Let’s select a brightness of 100 percent based on the images  and then modify
the color saturation（色度） of the image. You do this by specifying a second part to the argument of the modulate command-line option, like this:

```
convert -modulate 100%,80% input.jpg output.jpg
```

调整亮度和色度：

```
convert -modulate 100%,80% input.jpg output.jpg
```

一下四个处理：

```
convert -modulate 100%,15%  input.jpg output.jpg
convert -modulate 100%,55%  input.jpg output.jpg
convert -modulate 100%,90%  input.jpg output.jpg
convert -modulate 100%,145% input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之调整亮度、饱和度、色度

Finally, you can also adjust the hue with the modulate command, like this:

```
convert -modulate 100%,100%,80% input.jpg output.jpg
convert -modulate 100%,100%,15% zx.jpg zxliangdu-baohedu-sedu15.jpg
convert -modulate 100%,100%,55% zx.jpg zxliangdu-baohedu-sedu55.jpg
convert -modulate 100%,100%,95% zx.jpg zxliangdu-baohedu-sedu95.jpg
convert -modulate 100%,100%,145% zx.jpg zxliangdu-baohedu-sedu145.jpg
```

## 使用convert命令做简历的小图案

这张图是128x128像素的，想弄成16x16或8x8像素的，用-resize选项：

```
convert -resize 16x16 mail.png m16.png
```

使用convert命令做简历的小图案

批量的话用

```
mogrify -resize 8x8 mail.png 8x8.png
```
 
有篇文章：http://home.lupaworld.com/home-space-uid-980-do-blog-id-230184.html

比如我们要把一张1600*1200的图片改成600*600大小，裁减掉多余边框, 首先缩放

```
convert -resize 800x600 a.jpg b.png
```

800x600表示宽800像素高600像素，这样就生成了一张800*600的图片, 然后截取需要的大小:

```
convert -crop 600x600+50+0 b.png c.gif
```

这样就把左面50个像素和右面50个像素去掉了
注意如果直接convert -resize 600x600 a.jpg会得到一张600*450的图片。
另外，从上面的命令可以看出，convert对图片后缀不感冒，它先把源文件解码，然后处理，然后编码成你需要的格式，当然，如果你的文件后缀和文件类型不符也没关系。

## The Definitive Guide To ImageMagick之Shearing an Image

Shearing an Image

The shear effect puts the input image at an angle. You can tilt the image horizontally and
vertically in both directions (in other words, from left to right, from right to left, from top to
bottom, and from bottom to top). The tilt is specified as an angle; for example, in the horizontal
direction, a negative tilt(倾斜;倾侧) is a tilt to the left, and a positive tilt is a tilt to the right. For example,
to tilt an image to the right 45 degrees, you use this command line:

```
convert -shear 45 input.jpg output.jpg
```

The folowing shows some examples of shearing horizontally. In these examples I have also
specified a vertical shear of zero.

```
convert -shear -45x0 -background red input.jpg output.jpg
convert -shear -20x0 input.jpg output.jpg
convert -shear 20x0 input.jpg output.jpg
convert -shear 40x0 input.jpg output.jpg
```

The empty triangles created by the shearing are filled with the color currently specified
as the background color. You can also shear vertically by specifying a zero shear angle for the horizontal axis and then a vertical
shearing. A positive angle is toward the top of the image, and a negative angle is toward the
bottom. For example, to shear vertically toward the top 30 degrees, use this command line:

```
convert -shear 0x30 input.jpg output.jpg
convert -shear 0x-40 input.jpg output.jpg
convert -shear 0x-20 input.jpg output.jpg
convert -shear 0x20 input.jpg output.jpg
```

You can, of course, shear in the horizontal and vertical directions at the same time. To
perform the shear operation, specify the horizontal and vertical angles as arguments to the
shear command-line option. For example, for a horizontal shear of 10 degrees and a vertical
shear of 20 degrees, use this command line:

```
convert -shear 10x20 input.jpg output.jpg
```

## The Definitive Guide To ImageMagick之Rolling an Image

Rolling an Image

The roll effect provided by ImageMagick can roll an image horizontally or vertically. A vertical
roll involves taking a rectangle(矩形) from the top of the image and moving it to the bottom of the image; a horizontal roll moves some of the image from the left side to the right side. You do
this by specifying the horizontal roll and then the vertical roll. For example, to roll the image
100 pixels to the right and 200 pixels to the bottom, use this command line:

```
convert -roll +100+200 input.jpg output.jpg
```

To roll horizontally only, don’t specify a vertical roll. To roll just vertically, specify a zero
horizontal roll. To roll to the left or upward, use a negative number.

```
convert -roll -120+200 input.jpg output.jpg
```

## Turning Multiple Images into One Image

Appending Images

To append these three figures in a vertical column, you can use this ImageMagick
command line:

```
convert -append input1.jpg input2.jpg input3.jpg output.jpg
```

To make it more obvious what is happening because of the different size of the last image,
here is the same append command but with a border added:

```
convert -append input2.jpg input2.jpg input3.jpg -border 5 output.jpg
```

The color used to fill in the vacant space to the right of the first two images
is the background color. This is much more obvious if you set the background color to something a little more obvious than the default of white:

```
convert -background red -append input1.jpg input2.jpg input3.jpg output.jpg
```

You can also create a horizontal row of images with the append command. To do this, just
use a plus sign instead of aminus sign as the first character of the append command. For example,
you can create that same column in a horizontal style:

```
convert -background red +append inpuot.jpg input.jpg output.jpg result.jpg
```

## Using the Drawing Commands

Specifying Colors
Many of the drawing commands demonstrated in this chapter take an argument that is a color, so
in the following three sections, I’ll discuss how to specify colors for these commands. ImageMagick
supports three major ways of specifying a color: named colors, HTML-style strings, and RGB
tuples.

Using Named Colors

As mentioned in Chapter 1, it’s possible for the administrator who set up ImageMagick to have
defined a set of named colors. These names act as shortcuts to the RGB value associated with
that name. The default names should still work if the administrator hasn’t removed them. You
can find out what named colors exist using the following command line:

```
convert -list color
```

This will list the colors that have been defined in the colors.xml file discussed in Chapter 1.
Here’s a sample of the list that is returned from my default installation of ImageMagick:

Using HTML-Style Color Strings

ImageMagick also takes color arguments in the form of HTML-style color strings. For example,
all the following are valid color strings:

```
#RGB                 (R,G,B are hex numbers, 4 bits each)
#RRGGBB              (8 bits each)
#RRRGGGBBB           (12 bits each)
#RRRRGGGGBBBB        (16 bits each)
#RGBA                (4 bits each)
#RRGGBBAA            (8 bits each)
#RRRGGGBBBAAA        (12 bits each)
#RRRRGGGGBBBBAAAA    (16 bits each)
```

To understand these values, you have to know that color is represented to ImageMagick in
the form of an RGB value, which consists of red, green, and blue values. You can represent any
color with an RGB value, and this is the color format used by many image formats, as well as
a lot of hardware such as computer monitors. Of course, other ways of representing colors exist,
such as CMYK and YUV, but given that ImageMagick uses RGB, I’ll limit this discussion to the
RGB values.


Using RGB Tuples

The final method of specifying a color is useful if you know what the decimal values for the
various channels you want to set are. Two types of RGB tuples exist. To specify the RGB values,
then use this form:

```
rgb(value, value, value)
```

where value is replaced by the red, green, and blue values, respectively. Alternatively, if you
want to specify an alpha channel as well, then use this form:

```
rgba(value, value, value, value)
```

Specifying a Page Size

For example, to create a new image that is 100 pixels wide and 200 pixels tall and is
green, then you use a command line like this:

```
convert -size 100x200 xc:green output.jpg
```

The xc: syntax specifies that ImageMagick should create an image and use green as the
color of that image.


Specifying a Background Color

```
convert -background red -rotate 30 input.jpg output.jpg
```

Specifying the Fill Color and Stroke Color填充色和画笔颜色

```
convert -size 200x100 xc:lightgray -stroke green -draw "rectangle 10,10,190,90" output.jpg
```

This command line creates a light-gray image that is 200 pixels wide and 100 pixels high;
it then sets the stroke color to green and draws a rectangle inset 10 pixels from all the edges of
the image. This image is filled with the default fill color of black. The image is then saved to
output.jpg.

You can also fill that rectangle with, for instance, light gray. For this command, use a whit
background for the image:

```
convert -size 200x100 xc:white -stroke green -fill lightgray -draw "rectangle 10,10,190,90" output.jpg
```

You can also specify the width of the stroked line. In this example, the green line is harder
to see now that the rectangle is filled. If you make the line 5 pixels wide, then you get amuch
more visible border around the fill color:

```
convert -size 200x100 xc:white -stroke green -strokewidth 5 -fill lightgray -draw "rectangle 10,10,190,90" output.jpg
```

## Setting Gravity

ImageMagick lets you specify how some graphical operations occur using a concept called
gravity. For instance, in Chapter 4, you saw an example that used the composite command
and some corner images to create a curved corner effect on an image. The gravity command
told ImageMagick which corner of the large image to place the corner images in.

So, the top of the image is North, and the right of the image is East. You can also specify
corners with this compass, in that the top-right corner is NorthEast, for instance. To specify the
center of the image, use the Center keyword. You specify the gravity on the command line with
the gravity option; for example, to put a rounded corner on the top-right corner of an image,
use this command:

```
composite -gravity NorthEast rounded-ne.png input.png output.png
```

圆角矩形也可以做出来。


## Annotating an Image with Text

添加文字：

```
convert -annotate 0x0+10+10 weibo.com input.jpg output.jpg
```

This will put the text text on the image at the top-left corner and inset it 10 pixels
from each edge. Note that this inset is the bottom-left corner of the first character, so you expect the text to look closer to the top of the image than it is to the left because of this.

```
convert -pointsize 24 -annotate 0x0+10+10 weibo.com input.jpg output.jpg
```

You can see that in this example the text falls off the edge of the image, so let’s shift the
bottom of the text down to 30 pixels:

```
convert -pointsize 24 -annotate 0x0+10+30  weibo.com input.jpg output.jpg
```

This is much nicer. Now let’s change the color of the text to red, which you can do with the
stroke color (as discussed in the earlier “Specifying the Fill Color and Stroke Color” section):

```
convert -pointsize 24 -stroke red -annotate 0x0+10+30 weibo.com input.jpg output.jpg
```

This doesn’t give you the result you probably expected, because the inside of the letters
isn’t the right color。

To make this look as you expect, you need to have the inside of the letters filled with the
red color as well. So, let’s specify a fill color:

```
convert -pointsize 24 -stroke red -fill red -annotate 0x0+10+30 www.sina.com input.jpg output.jpg
```

This is a much nicer result in this instance. It’s useful to note that the letters’ fill color
and stroke color don’t have to be the same, which can sometimes come in handy. For com-
pleteness, it’s worth noting that you can also specify the stroke width for text annotations. For
example, this sets the stroke width to 3 pixels:

```
convert -pointsize 24 -stroke red -strokewidth 3 -fill red -annotate 0x0+10+30 sina.com input.jpg output.jpg
```

You can also specify the font to use with the annotation. To do this, use the font command-
line argument, which takes the name of a font as its argument. For this example, I want to use
a TrueType font called Arbuckle that I downloaded from the Internet for free. The font is stored
in the Arbuckle.ttf file, which means I use this command line:

```
convert -pointsize 24 -font Arbuckle.ttf -stroke red -fill red -annotate 0x0+10+30 sina.com input.jpg output.jpg

convert -pointsize 24 -font c:\windows\fonts\Jokerman.ttf -stroke red -fill red -annotate 0x0+10+30 sina.com input.jpg output.jpg
```

It’s worth noting that ImageMagick has a separate specification for fixed-width fonts, which
you specify in the same manner as the font command-line option; it’s called text-font. You
also specify another two numbers in the offset specification, which are rotation parameters.

```
convert -pointsize 24 -stroke red -fill red -annotate 45x0+10+30 sina.com input.jpg output.jpg
```

To rotate the annotation vertically, use the other number:

```
convert -pointsize 24 -stroke red -fill red -annotate 0x45+10+30 sina.com input.jpg output.jpg
```

You can also use the gravity command-line argument to specify where on the image the
text should be placed. For example, to put this text in the bottom-right corner instead of the
top-left corner, then you use the gravity option like this:

```
convert -pointsize 24 -font  c:\windows\fonts\Jokerman.ttf -stroke red -fill red -gravity SouthEast -annotate 0x0+10+60 sina.com input.jpg output.jpg
```

The SouthEast argument to the gravity command-line option tells ImageMagick to put the
text at the bottom-right corner of the image.

You can also specify a box to be placed under the annotation text, which can make it a lot
easier to read—in return for being more intrusive on the original image. You do this by adding
the box command-line option to the command, with the argument to the box option being the
color of the box. For example, the following command line adds a blue box behind the text you
put on the image:

```
convert -pointsize 24 -stroke red -fill red -box blue -annotate 0x0+10+30 sina.com input.jpg output.jpg
```

Finally, you can have the annotation text come from a file if you don’t want to specify the
text on the command line. To do this, instead of the annotation text in the command line, use
an at sign and then the name of the file containing the annotation text. For example:

```
convert -annotate 0x0+10+30 @textfile.txt input.jpg output.jpg
```

## Drawing Simple Shapes

Drawing a Single Point

The simplest shape is just a single pixel. For example, the following command line puts a red
pixel onto a 100×100-pixel image at the point 50 pixels in from the top-left edge:

```
convert -size 100x100 -fill red -draw "point 50,50" xc:white output.png
```

Drawing a Straight Line

You can draw straight lines with the line shape. For example, the following command draws
a line between 10,10 and 90,90 on another blank 100×100-pixel image:

```
convert -size 100x100 -fill red -draw "line 10,10 90,90" xc:white output.png
```

Again, you can see that the fill color draws the line, not the stroke color. Note that setting
the stroke width doesn’t affect the image; however, the linewidth setting will change the width
of the line:

```
convert -size 100x100 -stroke black -fill red -linewidth 5 -draw "line 10,10 90,90" xc:white output.png
```

Drawing a Rectangle

```
convert -size 100x100 -stroke red -fill white -draw "rectangle 10,10 90,90" xc:white output.png
```

You can change the size of the line used by the rectangle by using the strokewidth
command-line option:

```
convert -size 100x100 -stroke red -strokewidth 5 -fill white -draw "rectangle 10,10 90,90" xc:white output.png
```

And finally, you can change the color with which the rectangle is filled:

```
convert -size 100x100 -stroke red -strokewidth 5 -fill lightgray -draw "rectangle 10,10 90,90" xc:white output.png
```

Drawing a Rectangle with Rounded Corners

ImageMagick can also round the corners of the rectangles that it draws. To do this, you change
the name of the shape you’re drawing to roundRectangle and append an extra argument to the
shape description. This extra argument is the width of the circle and the height of the circle
that forms those corners. For example:

```
convert -size 100x100 -stroke red -strokewidth 5 -fill lightblue -draw "roundRectangle 10,10 90,90 10,10" xc:white output.png
```

This rounded rectangle has corners that are based on a circle that is 10×10 pixels. The fol-
lowing command tweaks that to 20×10:

```
convert -size 100x100 -stroke red -strokewidth 5 -fill lightblue -draw "roundRectangle 10,10 90,90 20,10" xc:white output.png
```
Drawing a Circle

```
convert -size 100x100 -stroke red -fill lightblue -draw "circle 50,50 70,70" xc:white output.png
```

The arguments to the circle shape are slightly different from the rectangle shape. The first
argument is the center of the circle, and the second argument is how far the circle extends.

You can also increase the stroke width of a circle much like a rectangle:

```
convert -size 100x100 -stroke red -strokewidth 5 -fill lightblue -draw "circle 50,50 70,70" xc:white output.png
```

And finally, you can of course fill the circle:

```
convert -size 100x100 -stroke red -strokewidth 5 -fill red -draw "circle 50,50 70,70" xc:white output.png
```


Drawing an Arc 画弧

You can draw arcs with ImageMagick. You merely specify three pairs of numbers—the first two
pairs of numbers are control points that dictate the size of the ellipse in which the arc is drawn.
The third pair of numbers is the starting angle of the arc and the ending angle of the arc. This
is a simple command-line example:

```
convert -size 100x100 -stroke red -fill lightblue -draw "arc 10,10 90,90 45,270" xc:white output.png
```

You can see on this diagram that the arc starts at 45 degrees and ends at 270 degrees. 

Drawing an Ellipse 椭圆

You can use a similar effect with an ellipse:

```
convert -size 100x100 -stroke red -fill lightblue -draw "ellipse 50,50 20,40 45,270" xc:white output.png
```


The arguments to this primitive are the center of the ellipse, the horizontal radius, and
the vertical radius. The start and end angles are handled the same as in the arc primitive.

 
Drawing a Polyline 线段

```
convert -size 100x100 -stroke red -fill lightgray -draw "polyline 10,10 20,40 90,90 10,90" xc:white output.png
```

Drawing a Polygon 多边形

The polygon primitive is the same as the polyline primitive, but the polygon finishes by return-
ing to the starting point of the polygon:

```
convert -size 100x100 -stroke red -fill lightgray -draw "polygon 10,10 20,40 90,90 10,90" xc:white output.png
```

Drawing a Bezier 曲线

The Bezier primitive draws Bezier curves. Bezier curves are based on a series of control points.
The first and last points are the start and end points of the curve, and the intervening points
act like gravity points and “pull” the curve toward those points. Here’s an example of a Bezier
curve with four control points:

```
convert -size 100x100 -stroke red -fill lightgray -draw "bezier 10,10 30,100 70,0 90,90" xc:white output.png
```


Drawing Text

You saw how to annotate text earlier in this chapter in the “Annotating an Image with Text”
section. The annotate command-line option mentioned in that section is actually a shorthand
method of calling the draw command-line option’s text functionality, which is much the same
but offers tighter control.

To annotate an image using the draw command-line option, use the text primitive, which
takes a location and the string to write as arguments. For example, this command writes a word
on the blank image:

```
convert -size 100x100 -stroke red -draw "text 50,50 blah" xc:white output.png
```

```
convert -size 100x100 -stroke red -fill white -draw "rectangle 10,10 90,90" -fill black -draw "color 50,50 point" xc:white output.png
```

replace
The replace argument looks at the value of the pixel specified and then replaces all occurrences
of that color in the image with the current fill color:

```
convert -size 100x100 -stroke red -fill white -draw "rectangle 10,10 90,90" -fill black -draw "color 50,50 replace" xc:white output.png
```

floodfill
The floodfill argument fills the inside of the shape that contains the specified point with the
current fill color:

```
convert -size 100x100 -stroke red -fill white -draw "rectangle 10,10 90,90" -fill black -draw "color 50,50 floodfill" xc:white output.png
```

filltoborder
The filltoborder argument is similar to the floodfill option, but replaces the border as well:

```
convert -size 100x100 -stroke red -fill white -draw "rectangle 10,10 90,90" -fill black -draw "color 50,50 filltoborder" xc:white output.png
```

As this command sets the entire image to black, I haven't included an example of it's output.
reset
The reset argument colors all pixels anew:

```
convert -size 100x100 -stroke red -fill white -draw "rectangle 10,10 90,90" -fill black -draw "color 50,50 filltoborder" xc:white output.png
```

Similar to filltoborder, this command sets the entire image to black, so I haven't included
an example of it's output.

Transforming Your Drawings

 
The draw command-line option supports a number of transformations that you can apply to
the primitives you use. In this series of examples, I’ll show how to use the draw command-line
option to put some primitives on top of an existing image and then use the transformation’sprimitives to rearrange the elements I’m drawing. I’ll put them on top of the image shown in Figure to show that the draw transformations don’t affect that image.

 
This command line draws a simple stick-figure man and some text:

```
convert -fill blue -font  c:\windows\fonts\Jokerman.ttf -pointsize 48 -draw "circle 50,50 75,75 rectangle 45,75 65,150 text 100,150 Water" input.jpg output.jpg
```


Rotating the Drawing
The first transformation I’ll apply is the rotate transformation primitive. The rotate
command-line option takes an argument that is the number of degrees to rotate clockwise,
much like the rotate command-line option discussed in Chapter 6. Here’s an example:

```
convert -fill blue -font c:\windows\fonts\Jokerman.ttf -pointsize 36 -draw "rotate -15 circle 50,50 75,75 rectangle 45,75 65,150 text 100,150 Water" input.jpg output.jpg
```

This rotates all the drawn elements but not the original picture


You can choose to rotate only some of the drawn elements by changing where you place
the rotate command:

```
convert -fill blue -font c:\windows\fonts\Jokerman.ttf -pointsize 36 -draw "circle 50,50 65,45 rectangle 60,75 55,150 rotate -15 text 100,150 Water" input.jpg output.jpg
```


Translating a Drawing
You can also translate a drawing. Translation is the process of shifting a drawing by a given
amount, for example, 40 pixels to the left or 150 pixels down. The following command trans-
lates the drawing used in the previous example down 150 pixels:

```
convert -fill blue -font c:\windows\fonts\Jokerman.ttf -pointsize 36 -draw "translate 0,75 circle 50,50 65,65 rectangle 65,70 60,120 text 100,150 Water" input.jpg output.jpg
```


Scaling a Drawing
Perhaps you’re really happy with the drawing you’ve done but now realize that it’s the wrong
size and want to scale the whole drawing without changing all those coordinates. You just
provide a scale primitive with the horizontal scaling factor and vertical scaling factor. For
example, the following command makes the drawing one-and-a-half times its current width
but half its current height:

```
convert -fill blue -font c:\windows\fonts\Jokerman.ttf -pointsize 24 -draw "scale 1.5,0.5 circle 50,50 65,65 rectangle 65,70 75,100 text 100,100 Water" input.jpg output.jpg
```

Skewing a Drawing
Finally, for the transformations you can apply to your drawing, you can skew the drawing.
You can perform this skew either horizontally or vertically by using different commands. For
example, to skew horizontally, simply specify the number of degrees to skew with the skewx
primitive:（把字体复制到命令行所在路径，和照片放在一块）

```
convert -fill blue -font Jokerman.ttf -pointsize 24 -draw "skewx 30 circle 80,80 65,65 rectangle 65,70 75,100 text 100,150 Water" input.jpg output.jpg
```

You can also skew vertically with the skewy primitive:

```
convert -fill blue -font  Jokerman.ttf -pointsize 24 -draw "skewy 30 circle 50,50 55,55 rectangle 65,70 75,100 text 100,150 Water" input.jpg output.jpg
```

Combining Transformation Primitives
Of course, you can combine transformations; for example, to rotate just the word water but
move the whole drawing down 150 pixels, use a command line like this:

```
convert -fill blue -font   Jokerman.ttf -pointsize 24 -draw "translate 0,75 circle 50,50 65,65 rectangle 30,75 65,150 rotate -15 text 100,150 Water" input.jpg output.jpg
```

Using More Than One Draw Command
Nothing is stopping you from using more than one invocation of the draw command-line
option. In fact, this is sometimes required—for instance, if you want to change the color
you’re filling shapes with, you’ll have to use more than one command. The following com-
mand keeps the stick-figure man blue but makes the text red:

```
convert -fill blue -font Jokerman.ttf -pointsize 24 -draw "circle 50,50 65,65 rectangle 30,75 64,150" -fill red -draw "text 100,150 Water" input.jpg output.jpg
```
## Compositing Images with the draw Command

使用draw命令合成图片

 to place an image over another, you can use syntax like this:

```
convert -draw "image Over 100,100 118,111 fern.png" input.jpg output.jpg
```

The first pair of numbers in the command line is the inset to start the image at, and the
second pair of numbers is the size of the image. If you use 0,0, then the real size of the image is used; any other pair of numbers will result in the image being scaled to the specified size. You don’t just need to place images over one another, however. The following sections highlight
the available operators and show examples of their effects.

 
Using the Over Operator
This is the transformation used previously, so I won’t include an example here. It’s listed here
for completeness.


Using the In Operator
The In operator replaces the image data under the overlay image with the overlay image. None
of the image data from the original image in the covered area is used, even if the overlay image
specifies transparency:

```
convert -draw "image In 100,100 118,111 fern.png" input.jpg output.jpg
```

Using the Out Operator
The Out operator removes the section of the input image that would be covered by the overlay
image but doesn’t actually put the overlay image into that space:

```
convert -draw "image Out 100,100 218,111 fern.jpg" input.jpg output.jpg
```

Using the Atop Operator
The Atop operator produces something visually the same as the Over operator, except in the
case where the overlay image falls outside the input image’s original boundary. For example,
here’s the Atop operator with the coordinates tweaked so that the image does fall outside the
edge of the input image:

```
convert -draw "image Atop 125,75 109,80 fern.jpg" input.jpg output.jpg
```

In previous releases of ImageMagick, the Over operator would have extended the image to
include all of the overlay image. This is no longer the case, however.
Using the Xor Operator
The Xor operation will apply the exclusive “or” Boolean operator to the input image and the
overlay image and then place the result into the output image. The exclusive “or” operator is
often known as the logical difference, because it’s a simple bit difference operator. If the value of two Bits from the input images is different, then the value of the exclusive or operation is a 1.


Otherwise, the value of the exclusive or is 0. This command line:

```
convert -draw "image Xor 50,50 80,100 fern.jpg" input.jpg output.jpg
```

Using the Plus Operator
The Plus operator adds the existing pixel value in the input image to the pixel value of the over-
lay image and then uses that new value in the output image. If the new pixel value is higher than
can be stored in the output image, it’s truncated to the maximum possible value for that image.
The matte channel value is set to opaque. For example:

```
convert -draw "image Plus 50,50 100,80 fern.jpg" input.jpg output.jpg
```


Using the Minus Operator
Minus does the same as the Plus operator, except that the base image’s pixel value is subtracted
from the overlay image’s pixel value. If the new value is less than zero, then it’s made zero. The matte channel value is set to opaque. For example:

```
convert -draw "image Minus 50,50 100,50 fern.jpg" input.jpg output.jpg
```


Using the Difference Operator
Difference is similar to the Minus operator, except that an absolute value is applied to the
result of the subtraction, so the new pixel value doesn’t need to be forced to not be negative.
For example:

```
convert -draw "image Difference 50,50 108,90 fern.jpg" input.jpg output.jpg
```

Again, the image doesn’t show up well after the printing process has done its thing; but
again, if you look closely, you can see the outline of the letters. The ImageMagick documenta-
tion suggests that the Difference operator is useful to see differences in similar images.

Using the Multiply Operator
Multiplymultiplies the pixel value from the input image with the pixel value from the overlay
image to determine the value of the pixel in the output image:

```
convert -draw "image Multiply 50,50 100,90 fern.jpg" input.jpg output.jpg
```

Using the Bumpmap Operator
The Bumpmap operator takes the input image and shades it with the overlay image:

```
convert -draw "image Bumpmap 50,50 100,50 fern.jpg" input.jpg output.jpg
```


Performing Other Tasks with These Composition Operators
You can also use these composition operators with the composite command:

```
composite -compose In fern.jpg input.jpg output.jpg
```

## Antialiasing Your Images

反锯齿

Sometimes you don’t want antialiasing, however. For example, on LCD monitors, antialiased
text often looks fuzzy and slightly out of focus. ImageMagick therefore lets you turn antialiasing
on and off. To use antialiasing, which is the default, just use the antialias command-line option.
Here’s how to create the earlier antialiased example:

```
convert -antialias -font JOKERMAN.ttf -pointsize 48 -size 300x120 -fill black -annotate 0,0+10+100 "Magick" xc:white output.png
```

To disable antialiasing, use the +antialias command-line option, like this:

```
convert +antialias -font JOKERMAN.ttf -pointsize 48 -size 300x120 -fill black -annotate 0,0+10+100 "Magick" xc:white output.png
```

Framing an Image
ImageMagick can place frames around images, which is something I briefly touched upon in
Chapter 2 when I showed how to remove frames with the trim command-line option. The way
you create one of these frames with ImageMagick is with the frame command-line option. At
its most basic, the command takes the thickness of the frame horizontally and vertically as its
arguments, like this:

```
convert -frame 10x10 input.jpg output.jpg
```


Now, this gray frame isn’t very visible here, so I’ve opted to create a dark green frame using
the mattecolor option:

```
convert -mattecolor darkgreen -frame 10x10 input.jpg output.jpg
```

The first number is the amount to add to each side of the image, and the other number is
the amount to add to the top and the bottom of the image.


You can specify two other arguments with the frame command-line option. These are the
outer bevel width and the inner bevel width. Here’s an example of setting the outer bevel
width to 5 and the inner bevel width to 0:

```
convert -mattecolor darkgreen -frame 10x10+5+0 input.jpg output.jpg
```

You can also set the inner bevel:

```
convert -mattecolor darkgreen -frame 10x10+0+5 input.jpg output.jpg
```

Finally, you can set both and outer and an inner bevel:

```
convert -mattecolor darkgreen -frame 10x10+5+5 input.jpg output.jpg
```