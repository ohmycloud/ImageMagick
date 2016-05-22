## 利用ImageMagicK给图片加水印

水印可能是文字，也可能是网站的logo等。图片水印比较简单，就是把自己水印图标合成到原始图片上；文字水印中如果字符包含中文，处理就稍微麻烦一些。

 

- 图片水印处理
 

假设把名为logo.gif的水印图标添加在原始图片（src.jpg）右下角，且水印的下边缘距原始图片10像素、右边缘距原始图片5像素。使用如下命令即可：

```
convert src.jpg logo.gif -gravity southeast -geometry +5+10 -composite dest.jpg
```

- 文字水印处理
 
如果不含中文字符，可以直接通过convert draw text的方式将文字添加到图片，否则就需要使用其它的办法。命令行中不能包括中文字符，但是能通过读取文件的方式来操作，即先把中文信息保存到文本文件中。注意：文本文件的编码最好用UTF-8，同时也需要选取一个支持中文的字体。直接把文本文本中的信息输出到图片上使用命令mogrify，不过也可以使用convert命令把文本文件中的信息生成一个图片，然后再把图片合成到原始图片中。下面分别介绍这几种方法。

不含中文字符：例如把www.netingcn.com作为水印加上图片上，命令如下 
 
```
convert src.jpg -gravity southeast -fill black -pointsize 16 -draw "text 5,5 'http://www.netingcn.com'" dest-c.jpg

mogrify -pointsize 16 -fill black -weight bolder -gravity southeast -annotate +5+5 "http://www.netingcn.com" src.jpg
```
 

说明：上述两条命令达到同样的结果，但是第一次命令可以保留原始图片，第二条是直接在原始图片上打上水印。

存在中文的情况：假设存有信息的文件叫t.txt，字体文件是msyh.ttf。 
 
方法1：
```
//把文件t.txt中的信息生成图片txt.png, -transparent white让图片的背景透明，-size x30设置图片的高度
convert -transparent white -font msyh.ttf -fill black -pointsize 24 label:@t.txt txt.png

//把txt.png合成到src.jpg上
convert src.jpg txt.png -gravity southeast -geometry +10+5 -composite dest.jpg
```
 

方法2：

```
convert src.jpg -transparent white -font msyh.ttf -fill black -pointsize 24 -size x30 label:@t.txt -gravity southeast -geometry +10+5 -composite dest.jpg
```
 

方法3：

```
mogrify -font msyh.ttf -pointsize 24 -fill black -weight bolder -gravity southeast -annotate +20+20 @"t.txt" src.jpg
```
 
说明：上述第一、二种方法都有瑕疵，第二种背景不能变成透明，第一种虽然生成的图片可以透明，但是合成到原始图上效果不是很理想，第三种是完全透明的，所以推进用第三种方式来操作
