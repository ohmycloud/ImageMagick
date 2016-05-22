## mencoder 的一些常用参数

```
mencoder -o out.mp3 -ovc frameno -oac mp3lame -lameopts cbr:br=128 -of rawaudio -ss 1:30 -endpos 2:45 test.rmvb
```

```
#rmvb转为mp3

-o out.mp3            输出的目标文件名称
-ovc frameno          不处理视频编码
-oac mp3lame          输出的音频编码格式为mp3
-lameopts cbr:br=128  音频附件选项，cbr(常量比特率)编码格式，音频码流为128bps(对于mp3来说，128已经足够了)
-of rawaudio          输出文件为原始音频流
-ss 1:30              音频截取的起始时间(表示从影片的第1分30秒开始截取)
-endpos 2:45          预截取音频的长度(表示预截取的音频长度是2分45秒，那么可以计算出其结束时间是4:15)
test.rmvb             输入源文件
```

`-ss` 参数使用参考示例：

```
-ss 10 从10秒开始
-ss 10:10 从10分10秒开始
-ss 1:10:10 从1小时10分10秒开始
```

`-endpos` 参数使用参考示例：

```
-endpos 10      编码的时间为10秒
-endpos 10:10   编码的时间为10分10秒
-endpos 1:10:10 编码的时间为1小时10分10秒
-endpos 10mb    编码数据量为10M
```

## 格式转换

- RMVB转AVI

```
mencoder input.rmvb -oac mp3lame -lameopts preset=64 -ovc xvid -xvidencopts bitrate=600 -of avi -o rm.avi
```

- RM转AVI

```
mencoder input.rm -oac mp3lame -lameopts preset=64 -ovc xvid -xvidencopts bitrate=600 -of avi -o rm.avi
```

- MPEG转AVI

```
mencoder mp4.mpeg -oac mp3lame -lameopts preset=64 -ovc xvid -xvidencopts bitrate=600 -of avi -o mp4.avi
```

- MOV转AVI

```
mencoder qtime.mov -oac mp3lame -lameopts preset=64 -ovc xvid -xvidencopts bitrate=600 -of avi -o mo.avi
```

- WMV转AVI 包括WMV7到WMV9，只实验到WMV9

```
mencoder m7.wmv -oac mp3lame -lameopts preset=64 -ovc xvid -xvidencopts bitrate=600 -of avi -o m7.avi
```

- RV转AVI

```
mencoder 1.rv -oac mp3lame -lameopts preset=64 -ovc xvid -xvidencopts bitrate=600 -of avi -o rv.avi
```

接下来是FFMPEG上场。

- AVI转FLV

```
ffmpeg -i test.avi -ab 56 -ar 22050 -b 500 -r 15 -s 320x240 test.flv
```

- 抓图JPG

```
ffmpeg -i input.wmv -y -f image2 -ss 8 -t 0.001 -s 350x240 test.jpg
```

- 3GP转FLV

```
mencoder -vf scale=320:240 -ffourcc FLV1 -of lavf -lavfopts i_certify_that_my_video_stream_does_not_use_b_frames -ovc lavc -lavcopts vcodec=flv:vbitrate=200 -srate 22050 -oac lavc -lavcopts acodec=mp3:abitrate=56 ok\1.3gp -o ok\3gp.flv
```

- MOV转FLV

```
mencoder -vf scale=320:240 -ffourcc FLV1 -of lavf -lavfopts i_certify_that_my_video_stream_does_not_use_b_frames -ovc lavc -lavcopts vcodec=flv:vbitrate=200 -srate 22050 -oac lavc -lavcopts acodec=mp3:abitrate=56 ok\qtime.mov -o ok\mov.flv
```

- RMVB转FLV

```
mencoder -vf scale=320:240 -ffourcc FLV1 -of lavf -lavfopts i_certify_that_my_video_stream_does_not_use_b_frames -ovc lavc -lavcopts vcodec=flv:vbitrate=200 -srate 22050 -oac lavc -lavcopts acodec=mp3:abitrate=56 ok\1.rmvb -o ok\rmvb.flv
```

- WMV转FLV

```
mencoder -vf scale=320:240 -ffourcc FLV1 -of lavf -lavfopts i_certify_that_my_video_stream_does_not_use_b_frames -ovc lavc -lavcopts vcodec=flv:vbitrate=200 -srate 22050 -oac lavc -lavcopts acodec=mp3:abitrate=56 ok\m9.wmv -o ok\m9.flv
```


mencoder可以做视频剪辑和视频格式转换。它既能在Windows操作系统上使用，又
能在Linux操作系统上使用。它只能通过命令行的形式使用。

例一：

```
mencoder basket.rm -ovc lavc -oac lavc -o basket.avi
# 把basket.rm文件转换为basket.avi文件，其中，视频转换为mp4格式,音频转换为
# mp2格式。"-o basket.avi"定义转换成的文件名为"basket.avi","-ovc lavc"表示
# 用默认的mp4格式编码图象，"-oac lavc"表示用默认的mp2格式编码声音。
```

例二：

```
mencoder basket.rm -ovc lavc -oac mp3lame -o basket.avi
# "oac mp3lame"表示用mp3格式编码声音。
```

例三：

```
mencoder basket.rm -ovc lavc -oac mp3lame -o basket.avi -ss 5:00 -endpos 8:00
# "-ss 5:00 -endpos 8:00"告诉mencoder仅仅转换从5分0秒到13分0秒的片段。
```

例四：

```
mencoder basket.avi -ovc copy -oac copy -o newbasket.avi -ss 5:00 -endpos 8:00
# "-ovc copy"表示不作视频转换，"-oac copy"表示不作音频转换。这个命令把
# basket.avi文件中的5分0秒到13分0秒的部分拷贝到newbasket.avi文件中，即：剪切部分音频。
```

例五：

```
mencoder a1.avi a2.avi -ovc copy -oac copy -o asum.avi
# 这个命令把a1.avi和a2.avi文件合并为asum.avi文件。
```

例六：

```
mencoder basket.rm -ovc lavc -oac lavc -lavcopts vbitrate=100 -lavcopts abitrate=32 -o basket.avi
# 限制目的文件的大小。目的文件中，一秒种图象占用100kbit空间,一秒钟声音占用
# 32kbit空间。较小的目标文件大小，一般意味着较低的图象和声音的质量。
```

FFmpeg堪称音频和视频应用程序的瑞士军刀,提供了丰富的选项和灵活性.很多时候用户为了看视频和听音乐都安装了ffmeg.更多关于ffmeg的详细介绍:here,可以通过ffmpeg -formats查看FFmpeg支持的视音频格式,左侧若是E表明可以编码,D表明可以解码

本文着重介绍命令行下ffmeg的7个技巧:

- 1、 音频转换

```
ffmpeg -i my_audio.wav  my_audio.mp3
# -i 后为要转换的音频文件,my_audio.mp3为目的音频文件
```

- 2 、视频转换

```
ffmpeg -i my_video.mpeg -s 500×500 my_video.flv
# -i 后为源视频文件, -s 表示设置目标视频文件的分辨率   my_video.flv为目的视频文件
```

- 3、 从视频中截取图片

```
ffmpeg -i test.mpg image%d.jpg
# 默认1s截取25张图片,可以通过-r设置每秒截取的图片数量
# -r fps 设置帧率,也就是每秒截取图片的数量(默认25)
```

```
ffmpeg -i test.mpg -r 1 image%d.jpg
# 这样子每1s截取1张图片
```

```
# 还可以设置截取间隔,起止
-ss 设定时间位置,语法:hh:mm:ss[.xxx]
-t 时长:限制转码/捕获视频的时间,语法:hh:mm:ss[.xxx]
```


```
ffmpeg -i test.mpg -r 25 -ss 00:00:10 -t 00:00:05 imagesd.png
# 在第10秒开始,以每秒截取25张图片的速度,截取5秒时长的图片
```

- 4 、从视频中采集音频

```
ffmpeg -i video.avi -f mp3 audio.mp3 # -f 强制选择格式
ffmpeg -i video.avi -vn audio.mp3    # -vn 取消截取视频(也就是只输出音频文件)
```

- 5、创建截屏视频

```
ffmpeg -f x11grab -r 25 -s wxga -i :0.0 /tmp/outputFile.mpg
```

0.0 是你X11 server的屏幕显示号吗,和DISPLAY一样样的.

此条命令以每秒25帧的速率来截取wxga屏幕视频,当然这里可以用-s 来设置视频分辨率,输出文件是/tmp/outputFile.mpg

- 6、用图片制作视频

```
ffmpeg -f image2 -i img%d.jpg /tmp/a.mpg
# 将`img001.jpg`, `img002.jpg`这种顺序排列的图片文件转制作为视频
```

- 7、从webcam中截取视频

```
ffmpeg -f video4linux2 -s 320x240 -i /dev/video0 out.mpg
```

同时截取音频和视频:

```
ffmpeg -f oss -i /dev/dsp -f video4linux2 -s 320x240 -i /dev/video0 out.mpg
```

/dev/video0为视频设备 /dev/dsp为音频设备

- 8、截取一段MP3

```
ffmpeg -ss 00:01:10 -t 0:0:50 -i 1.mp3 -vcodec copy -acodec copy output_copy.mp3
```