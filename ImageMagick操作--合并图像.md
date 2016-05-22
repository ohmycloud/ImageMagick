## ImageMagick操作--合并图像

本帖介绍了ImageMagick软件合并图像的常用操作，所有命令均在Windows命令行环境下进行测试通过。

- 背景图片background.png
- 顶层图片overlay.png
- 背景图片background.png
- 顶层图片overlay.png


- 1、图像合并基本操作（覆盖）

将一张图片覆盖到另一张图片的指定位置。

指定操作方法（over）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert background.png -compose over overlay.png -geometry 100x100+0+0 -composite new.png
```

- 2、图像合并基本操作（异或）

两图相交处变为无色，不相交处保持不变。
指定操作方法（xor）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert background.png -compose xor overlay.png -geometry 100x100+0+0 -composite new.png
```

- 3、图像合并基本操作（in）

顶层图片与背景图片交汇处不变，未交汇处变为无色，背景图片不显示。
指定操作方法（in）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert background.png -compose in overlay.png -geometry 100x100+0+0 -composite new.png
```


- 4、图像合并基本操作（out）

顶层图片与背景图片交汇处变为无色，未交汇处不变，背景图片不显示。
指定操作方法（out）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert  background.png  -compose out  overlay.png  -geometry 100x100+0+0  -composite  new.png
```

- 5、图像合并基本操作（atop）

顶层图片与背景图片交汇处不变，未交汇处变为无色，背景图片显示。
指定操作方法（atop）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert  background.png  -compose atop  overlay.png  -geometry 100x100+0+0  -composite  new.png
```

- 6、图像合并基本操作（dstover）

顶层图片与背景图片交汇处变为无色，未交汇处不变，背景图片显示。
指定操作方法（dstover）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert  background.png  -compose dstover  overlay.png  -geometry 100x100+0+0  -composite  new.png
```

- 7、图像合并基本操作（dstin）

背景图片与顶层图片交汇处不变，未交汇处变为无色，顶层图片不显示。
指定操作方法（dstin）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert  background.png  -compose dstin  overlay.png  -geometry 100x100+0+0  -composite  new.png
```

- 8、图像合并基本操作（dstout）

背景图片与顶层图片交汇处变为无色，未交汇处不变，顶层图片不显示。
指定操作方法（dstout）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert  background.png  -compose dstout  overlay.png  -geometry 100x100+0+0  -composite  new.png
```

- 9、图像合并基本操作（dstatop）

背景图片与顶层图片交汇处不变，未交汇处变为无色，顶层图片显示。
指定操作方法（dstatop）、顶层图片尺寸及坐标位置（100x100+0+0）。

```
convert  background.png  -compose dstatop  overlay.png  -geometry 100x100+0+0  -composite  new.png
```

- 10、图像上添加光源

在图像制定位置上添加圆形光源，形成阳光照射的效果。
指定光源尺寸（50x50）、光源位置（+5+30）。

```
convert  old.png  -compose atop ( -size 50x50  canvas:none  -draw"circle 25,25 25,40" –negate  -channel A  -blur 0x8 )  -geometry +5+30  -composite  new.png
```

- 11、图片指定区域变色

指定区域尺寸和起始坐标（50x60+20+10）、区域颜色（rgb(255,0,0)）、着色程度（20%）。

```
convert  old.png  -region 50x60+20+10  -fill "rgb(255,0,0)"  -colorize 20%  new.png
```