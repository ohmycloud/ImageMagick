## ImageMagick操作--动态图像生成

- 1、简单gif图片制作（10_1.gif）

图片依次出现，不消失。
指定每帧图片间隔时间（100）、处理方法（none）、画布尺寸（150x50）、画布颜色（rgb(202,225,255)）、在指定坐标位置添加图片（例+0+10 1.gif）、循环次数（0表示无限循环）。

```
convert -delay 100 -dispose none -size 150x50 xc:"rgb(202,225,255)" -page +0+10 1.gif -page +40+10 2.gif -page +80+10 3.gif -page +120+10 4.gif -loop 0 10_1.gif
```

- 2、简单gif图片制作（10_2.gif）

图片依次出现，并消失。
指定画布处理方法（none）、画布尺寸（150x50）、画布颜色（rgb(202,225,255)）、每帧图片间隔时间（100）、图片处理方法（previous）、在指定坐标位置添加图片（例+0+10 1.gif）、循环次数（0表示无限循环）。

```
convert -dispose none -size 150x50 xc:"rgb(202,225,255)" -delay 100 -dispose previous -page +0+10 1.gif -page +40+10 2.gif -page +80+10 3.gif -page +120+10 4.gif -loop 0 10_2.gif
```

- 3、简单gif图片制作（10_3.gif）

图片依次出现，并消失，并且清除当前图片占据位置的所有颜色。
指定画布处理方法（none）、画布尺寸（150x50）、画布颜色（rgb(202,225,255)）、每帧图片间隔时间（100）、图片处理方法（background）、在指定坐标位置添加图片（例+0+10 1.gif）、循环次数（0表示无限循环）。

```
convert -dispose none -size 150x50 xc:"rgb(202,225,255)" -delay 100 -dispose background -page +0+10 1.gif -page +40+10 2.gif -page +80+10 3.gif -page +120+10 4.gif -loop 0 10_3.gif
```

- 4、拆分gif图片

将gif动态图片拆分为组合前的单图
指定待拆分的图片（10_1.gif），生成图片名为10_1_x.gif（x从0开始依次增大）。

```
convert 10_1.gif +adjoin +repage 10_1_%d.gif
```


- 5、gif图片截图

将gif动态图片每帧进行截图
指定待截图的动态图片（10_1.gif）。

```
convert 10_1.gif -coalesce 10_1_%d.gif
```
