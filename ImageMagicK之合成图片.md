## ImageMagicK之合成图片

原文地址：http://www.netingcn.com/imagemagick-composite.html


ImageMagicK能方便的把多张小图片合成一张大图片。合成的方式大致有三种,

- 使用convert命令加 +append或-append参数 
- 使用convert命令加 -composite参数 
- 直接使用composite命令来完成 
 

其中方式１处理图片只能左右或上下来拼接图片，方式２最为灵活，可以一次性把多张图片合成在一起，方式３处理多张图片时需要一张一张来处理。下面的例子是把google地图中的4个256×256块合成一张512×512的大图，原始图片如下：

  
d0  d1  u0  u1 
- 使用方式1 

```
convert +append u0.png u1.png u.png
convert +append d0.png d1.png d.png
convert -append u.png d.png dest.png
```

说明：其中 +append 横向把多张图片拼接在一起，可以多于2张，图片按上边缘对齐,最后一个参数是目标图片,而-append是纵向拼接图片,图片按左边缘对齐。

 

- 使用方式2
 
```
convert -size 512x512 -strip -colors 8 -depth 8 xc:none u0.png -geometry +0+0 -composite u1.png -geometry +256+0 -composite d0.png -geometry +0+256 -composite d1.png -geometry +256+256 -composite dest4.png
```
 
说明：convert -size 512×512 xc:none 创建一张空白图片,然后把小图片合成到其上面。合成的命令大致为：convert 背景图片 图片 定义坐标原点 图片的位置 -composite 目标图片，其中“图片 定义坐标原点 图片的位置 -composite”　可以重复，从而把多张图片一次性合成到背景图片上。使用　-gravity　定义坐标原点，默认是左上角，可以用east,north,northwest等来重新定义原点，-geometry相对于原点的位置

 

- 使用方式3

```
convert -size 512x512 -strip -colors 8 -depth 8 xc:none dest1.png
composite -geometry +0+0 u0.png dest1.png dest1.png
composite -geometry +256+0 u1.png dest1.png dest1.png
composite -geometry +0+256 d0.png dest1.png dest1.png
composite -geometry +256+256 d1.png dest1.png dest1.png
```
 
说明： composite 定义坐标原点 图片的位置 图片 背景图片 目标图片
