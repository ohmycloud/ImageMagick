convert %1 -sepia-tone 75%% ( %1 -fill #FFFFFF -colorize 100%% +noise Random -colorspace gray -alpha on -channel A -evaluate Set 100 ) -compose overlay -composite %2
::使用方法：在命令提示符下输入 imagemagick-老照片效果.bat input.jpg output.jpg
REM 上述命令完成如下工作：
REM 1：将输入图像使用sepia-tone滤镜处理
REM 2：生成一个白色蒙版，填充随机噪声，转化为灰度，并加上alpha通道
REM 3：步骤1和步骤2的结果使用overlay的方式compose
