安装完ImageMagick后记得更新Path环境变量

```
# 用ImageMagick批量去水印
@echo off
mogrify  -path g:\ -sigmoidal-contrast 10,20%  *.jpg
pause
```

除去水印后的图片被放置在G盘根目录了，如果不指定路径，就会在当前文件夹进行操作，并且直接修改原图像，所以要记得备份。
