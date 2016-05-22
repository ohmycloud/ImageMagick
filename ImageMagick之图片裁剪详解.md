## ImageMagick之图片裁剪详解

imagemagick 的 convert 命令通过 crop 参数，可以把一幅大图片分成若干块大小一样的图片，同时也可以在大图上截取一块图片来。命令格式为

```
convert 原始图片 -crop widthxheight+x+y 目标图片
```
其中 `widthxheight` 是目标图片的尺寸，`+x+y` 是原始图片的坐标，这两组值至少要出现一组，也可以同时存在。另外该命令也可使用 gravity来重新定义坐标系统。关于更多 gravity 的信息，请参考：ImageMagicK 之 gravity 参数详解。下面介绍几种常用的命令。

- 把原始图片分割成多张小图 （可能是同样大小） 

```
convert src.jpg -crop 100x100 dest.jpg 
```

假设src.jpg的大小是300x200,执行命令后将得到名为dest-0.jpg、dest-1.jpg...dest-5.jpg的6张大小为100x100的小图片。注意如果尺寸不是目标图片的整数倍，那么右边缘和下边缘的一部分图片就用实际尺寸

- 在原始图片上剪裁一张指定尺寸的小图 

```
convert src.jpg -crop 100x80+50+30 dest.jpg 
```

在原始图片的上，距离顶部30像素、距左侧50像素为起点的位置,分别向左向下截取一块大小为100x80的图片。如果x相对于坐标，宽度不够100，那就取实际值。

```
convert src.jpg -gravity center -crop 100x80+0+0 dest.jpg
```

在原始图上截取中心部分一块100x80的图片

```
convert src.jpg -gravity southeast -crop 100x80+10+5 dest.jpg
```

在原始图上截取右下角距离下边缘10个像素，右边缘5个像素一块100x80大小的图片
