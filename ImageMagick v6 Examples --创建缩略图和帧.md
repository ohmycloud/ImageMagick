## ImageMagick v6 Examples --创建缩略图和帧

几种存储方式：

第一种方式可以使用mogrify，不会破坏源图像，需指定-format选项

第二种方式，指定-path选项也可以使用mogrify进行批量处理

eg：mkdir thumbs

```
mogrify -format gif -path thumbs -thumbnail 100x100 *.jpg
```
 

选择输出格式

JPEG 对于大文件很好，对于缩略图效果不好，有失真。非要使用这，建议加上"-quality 百分比"参数。

使用 "-sampling-factor 2x1"也会产生小的图像尺寸。

 

GIF 对于小图片效果好。256种颜色。只有布尔(on / off)透明度。

 

PNG 对于缩略图很理想，无损，能显示所有的颜色。更重要的是该格式理解半透明的颜色，让阴影和边缘更强烈和清晰。对于缩略图可以通过减少颜色的深度和数量来减少最终图像的尺寸，就像设置了一个高的"bzip"压缩质量，例如
```
-strip -quality 95 PNG8:thumbnail.png
```
 

重要提示：不要使用JPEG，PNG8，或GIF作为中间的图像格式！最好使用PNG或MIFF。

因为png会保留图像更多的颜色信息。



 Profiles, Stripping, and JPEG Handling

 

缩略图没必要保留图像的配置信息，可以移除：

```
convert input.jpg  -strip output.jpg
```

或 `mogrify -strip  *.jpg`


也可以使用"-profile '*'"选项移除配置信息。

 

It is however recommended you only strip profiles when you modify an image, especially if reducing it in size for web displays, or thumbnail images.

 

 

Stripping profiles while resizing, particularly for generating smaller thumbnail images, is so common that both "-resize" and "-strip" were combined into a new operation, just for this very purpose. Naturally enough this resize operation is called "-thumbnail".

For example...

```
 convert -define jpeg:size=240x180 image.jpg -thumbnail 120x90 thumbs/image.gif mogrify -path thumbs -format gif -define jpeg:size=240x180 -thumbnail 120x90 '*.jpg'  
 ```

 

 

例子：

General Thumbnail Creation

```
convert -define jpeg:size=500x180  hatching_orig.jpg  -auto-orient \
          -thumbnail 250x90   -unsharp 0x.5  thumbnail.gif
```

```
mogrify  -format gif -define jpeg:size=500x180 -auto-orient \
                -thumbnail 250x90 -unsharp 0x.5  '*.jpg'
```

Resize Thumbnail to Fit

```
convert -define jpeg:size=200x200 hatching_orig.jpg \
          -thumbnail '100x100>' rectangle.gif
```

Pad Out the Thumbnail

```
convert -define jpeg:size=200x200 hatching_orig.jpg -thumbnail '100x100>' \
          -background skyblue -gravity center -extent 100x100 pad_extent.gif
```

```
convert -define jpeg:size=200x200 hatching_orig.jpg -thumbnail '100x100>' \
          -bordercolor skyblue  -border 50 \
          -gravity center  -crop 100x100+0+0 +repage pad_crop.gif
```

 
```
 convert thumbnail.png  -background Lavender -fill navy -font Candice -pointsize 24 ^   label:Hatching   -gravity South -append   labeled.gif
```

刚开始没有将Candice花式字体安装到c:\windows\fonts目录中，到网上搜索安装，然后将path变量中添加一条：c:\windows\fonts （你也可以将字体和图像放在同一个文件夹中，但是麻烦）
