## 使用ImageMagicK给图片瘦身

影响图片大小（占用空间）主要取决于图片的profile和quality。

quality：图片的品质，品质越高，占用的空间越大。适当降低品质能很大程度的减少图片的尺寸。一般来说，从品质100降到85，基本上肉眼很难区别其差别，但尺寸上减少很大。imagemagick通过通过 -quality 来设置。 

profile：记录图片一些描述信息。例如相机信息（光圈，相机型号）、photoshop元数据，颜色表等信息。它占用的空间可以从几KB到几百KB，甚至可能更大。ImageMagicK可以通过两种方式来去掉这些信息。+profile “*” 　或　-strip 

下述图片中第一张原始图片为56KB，第二张图片执行了　`convert +profile “*” -strip src.jpg src-profile.jpg`　后变成了26.3KB, 第三张设置图片品质为85，`convert -quality 85 src.jpg src-quality85.jpg`，图片大小变成了19.5KB，第四张是同时使用去掉profile和设置品质为85, `convert -quality 85 -strip src.jpg src-p-q85.jpg`，图片只有18.7KB。经过一个简单的命令处理，就可以把原始图片体积减小到原来的的三分之一。一般来说jpg格式的图片有比较大的操作空间，而png、gif有时候处理了反而变大。所以具体问题需要具体分析。


在linux下可以很方便把某个目录下的所有jpg文件来一次瘦身运动，例如命令　`find /tmp/images -iname “*.jpg” -exec convert -strip +profile “*” -quality 85 {} {} \;`　可以把 `/tmp/images`目录下所有jpg图片进行压缩