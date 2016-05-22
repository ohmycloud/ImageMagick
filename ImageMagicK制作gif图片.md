## ImageMagicK制作gif图片

gif动画由一系列图片按照一定的时间间隔来播放的，每张单独的图片作为gif动画的一帧。使用ImageMagicK的convert命令很容易获取gif动画中的每桢图片，例如命令 `convert exam.gif p.png` 就会把生产 p-0.png,p-1.png 等一系列图片。gif动画的原理就是把一些列动画合成在一起。所以通过convert很容易做到。例如命令　`convert *.jpg dest.gif` 是把当前目录下的所有 jpg格式的图片生成一个名为dest.gif的文件，有两个参数比较重要，分别是-delay和-loop，其中-delay是控制每桢的切换时间，-loop是控制gif动画的播放次数,默认是0，0表示无尽的循环播放。

 

如果想控制每桢的间隔时间不一致，可以使用类似 `convert -delay 50 0.jpg 1.jpg -delay 100 2.jpg 3.jpg 4.jpg dest.gif` 这样的操作来完成,甚至可以先制作两个临时的gif,然后把临时的gif合成自己想要的,例如

```
convert -delay 50 0.jpg 1.jpg t1.gif
convert -delay 100 2.jpg 3.jpg 4.jpg t2.gif
convert t1.gif t2.gif dest.gif
```

通过上述的素材加一个logo图片制作一个如下的gif动画


```
convert -size 84x200 xc:"#f396eb" bg.gif 
convert bg.gif logo.gif -geometry +2+2 -composite bg.gif

convert bg.gif 0.jpg -geometry +2+55 -composite 0.png
convert bg.gif 1.jpg -geometry +2+55 -composite 1.png
convert bg.gif 2.jpg -geometry +2+55 -composite 2.png
convert bg.gif 3.jpg -geometry +2+55 -composite 3.png
convert bg.gif 4.jpg -geometry +2+55 -composite 4.png

convert -delay 50 *.png dest1.gif
```
 

 

说明：思路是先创建一张空白背景图片，然后把logo合成在背景上，再依次把素材的每张图片和背景生成一张新图片作为gif动画的一帧，最后使用convert把每桢图片合成一张gif 。这样的缺点是生成的gif图片尺寸会比较大，下面的方法能改进在尺寸上的缺点，但是在gif的循环上又有点不足。

 
```
convert -delay 50 *.jpg t.gif
convert -size 84x200 xc:"#f396eb" bg.gif
convert bg.gif logo.gif -geometry +2+2 -composite bg.gif
convert -loop 0 bg.gif -page +2+55 t.gif dest2.gif
```