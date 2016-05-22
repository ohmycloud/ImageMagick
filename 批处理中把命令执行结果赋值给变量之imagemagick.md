在批处理中，如果需要把一个命令的处理结果赋值给一个变量，可以使用如下方法：

```
for /f "delims=" %%t in ('命令字符串') do set str=%%t echo %str%
``` 

当命令字符串中含有%时，需要转义。使用imagemagick中的identify命令获取图片的宽和高：

```
identify -format %wx%h demo.jpg
```

直接在命令行中使用上述命令可以看到输出了图片的高和宽，但是用它放在批处理脚本中来获取命令的输出结果，则失败，原因是命令字符串中含有%符号，它在批处理有特殊含义，所有需要转义，转义的方法是使用两个%%，正确的做法是：

```
for /f "delims=" %%t in ('identify -format %%wx%%h demo.jpg') set str=%%t
```

为什么用2个%号？ 因为这是在批处理脚本中而非命令行下！
