Usage : nconvert [options] file ...

```
 Options :
-quiet            : 不显示该软件的信息
-info             : 只显示信息
-fullinfo         : 显示全部信息包括该软件的信息
-v[.]             : 冗长模式



          -in format        : 输入图片格式如jpg，bmp
          -page num         : 页数/页码
          -xall             : 提取所有图像
          -multi            : 创建多页（只适用tiff，dcx，ldf）
          -npcd num         : PCD 0:192x128, 1:384x256, 2:768x512 (default) pcd格式
          -ngrb npic        : HP-48 number of grey : 1, 2 or 4 (default : 1) 灰度:数值
          -no#              : # not used for numeric operator
          -clipboard        : 从剪切板导入


          -ctype type       : 通道类型 (Raw)
              grey  : 灰度（默认）
              rgb   : 红,绿,蓝
              bgr   : 蓝,绿,红
              rgba  : 红,绿,蓝,透明
              abgr  : 透明,蓝,绿,红
              cmy   : 青紫,洋红,黄色
              cmyk  : 青紫,洋红,黄色,黑色
          -corder order     : 通道排列(Raw) 
              inter : 交错的(default)
              seq   : 连续的
              sep   : 独立的
          -size geometry    : 宽和高(Raw/YUV)
                几何是高*宽+偏移

          -i file :           使用文件作为文件列表
             => nconvert -i test.txt 从test文件中读取图片可用dir /b *.jpg>test.txt做列表

          -n start end step :开始，结束，步长（为了图像序列）

          -o filename       : 输出文件名
              使用#号指定数字计数器的位置
-------------------------------------------------------------------------------------------------
                            => nconvert -o c:\#.jpg *.jpg 将图片按数字递增排序
-------------------------------------------------------------------------------------------------
             使用%号指定源文件名
-------------------------------------------------------------------------------------------------
                            => nconvert -o c:\%.jpg *.jpg  原名复制到c:盘
-------------------------------------------------------------------------------------------------
              使用$号指定源文件夹
-------------------------------------------------------------------------------------------------
格式转换：
-------------------------------------------------------------------------------------------------
      -out format       : 输出格式名称
------------------------------------------------------------------------------------------------- 
     　　　             => nconvert -out jpeg -truecolors in.bmp  将bmp格式转换为jpeg
-------------------------------------------------------------------------------------------------
          -D            : 删除源文件
-------------------------------------------------------------------------------------------------  	 
                        => nconvert -D -out jpeg -truecolors in.bmp   转换后删除源文件
-------------------------------------------------------------------------------------------------

          -c value          : 压缩率(默认为0)
              PDF    : 1 (Fax), 2 (Rle), 3 (LZW), 4(ZIP), 5 (JPEG)
              TIFF   : 1 (Rle), 2 (LZW), 3 (LZW+Prediction)
                       4 (ZLIB)
                       5 (CCITT G3), 6 (CCITT G3-2D), 7 (CCITT G4) only B/W
                       8 (JPEG) only 24/32 bits
              TARGA, Softimage, SGI, PCX, IFF, BMP : 1 (Rle)
          -q value          : JPEG/PNG/FPX/WIC/PDF 质量，默认100）
          -clevel value     : png压缩水平（默认为6）
          -i                : 交错的gif/渐进的jpeg
          -icc              : 使用icc配置
          -keep_icc         : 保留源文件的icc配置
          -icc_in filename  : 输入颜色配置
          -icc_out filename : 输出颜色配置
          -icc_intent value : 目的值
          -icc_bcp          : 黑点补偿
          -icc_ie           : 忽略嵌入的Icc配置
          -merge_alpha      : 使用32位‘透明色’合并透明度
          -transparent value: 透明度索引(GIF/PNG) 
          -transpcolor red green blue: 透明度颜色(GIF/PNG) 
          -opthuff          : 优化霍夫曼表
          -bgcolor red green blue: 背景色(旋转/画布调整时的背景色)
-----------------------------------------------------------------------------------------
设置分辨率：
          -dpi res_dpi      : 设置DPI分辨率
-----------------------------------------------------------------------------------------
                                  =>  nconvert  -dpi 10 in.jpg
-----------------------------------------------------------------------------------------

          -keepdocsize      : Resize bitmap function of the old and new DPI value
          -keepfiledate     : 保留原文件的数据/时间
          -keepcspace       : 保留原有色彩空间,如果可能的话


-----------------------------------------------------------------------------------------

          -jpegtrans op     : JPEG无损转换

              rot90  : 旋转90度
              rot180 : 旋转180度
              rot270 : 旋转270度
              exif   : 使用定向的exif标签
              vflip  : 垂直翻转
              hflip  : 水平翻转

          -jpegcrop x y w h : 无损剪切 x,y是坐标，w,h是宽高
-----------------------------------------------------------------------------------------
                      =>  nconvert -jpegcrop 600 500 300 450 in.jpg
-----------------------------------------------------------------------------------------

          -clean value : 清除元数据(EXIF/IPTC/...)
              1      : 注释
              2      : exif信息
              4      : XMP
              8      : exif缩略图
              16     : IPTC
              32     : icc配置
              64     : 其他标志
-----------------------------------------------------------------------------------------

          -rmeta              : 移除元数据 （可移除注释）
          -rexifthumb         : 移除exif缩略图
          -buildexifthumb     : 尝试重建exif缩略图
          -thumb width height : 提取缩略图
----------------------------------------------------------------------------------------------------
                              => nconvert -thumb 160 150 in.jpg 　制作缩略图，原图被毁坏
----------------------------------------------------------------------------------------------------

          -use_cie   : 使用CIE颜色(PS/EPS/PDF ghostscript)
          -wflag flag: 写入标记，标志
              os2    : Write OS/2 bmp
              gif87  : Write GIF87a
              hp49   : Write HP49

          -high_res             : 载入高分辨率(Camera RAW) 
          -ascii                : Ascii (PPM)
          -one_strip            : 剖光(TIFF) 
          -raw_autobalance      : 自动平衡(Camera RAW)
          -raw_camerabalance    : 相机平衡(Camera RAW)
          -raw_autobright       : 自动亮度调节(Camera RAW)
          -raw_gamma value      : 高斯模糊(Camera RAW)default=0.6
          -raw_brightness value : 亮度(Camera RAW)default=0.8 
          -raw_redscale value   : 红缩放(Camera RAW)
          -raw_bluescale value  : 蓝缩放(Camera RAW)
          -ilut file            : 输入LUT文件(DPX/Cineon) 
          -olut file            : 输出lut文件(DPX/Cineon)

-----------------------------------------------------------------------------------------
添加水印：
-----------------------------------------------------------------------------------------
          -wmfile file      : 作为水印的文件
          -wmpos x y        : 水印位置
          -wmflag flag      : 水印位置
              top-left, top-center, top-right
              center-left, center, center-right
              bottom-left, bottom-center, bottom-right
          -wmopacity value  : 水印透明度（0-100）
---------------------------------------------------------------------------------------------------------------------------------
                           => nconvert -wmpos 100 200 -wmflag center -wmopacity 30 -wmfile sample.jpg origin.jpg
---------------------------------------------------------------------------------------------------------------------------------
                              将sample.jpg作为水印添加到 origin.jpg，并设置透明度为30

						   
---------------------------------------------------------------------------------------------------------------------------------			
        Process :
          -32bits             : 32比特转换
          -average size       : 平均(3,5,7,9,11,13)
          -autocrop tol r g b : 自动剪切
          -balance r g b      : 色彩平衡
---------------------------------------------------------------------------------------------------------------------------------		  
       =>   nconvert -average 9 in.jpg                      模糊
       =>   nconvert -balance 255 0 255 in.jpg              红色
       =>   nconvert -balance 20 65 255 in.jpg              偏绿色
---------------------------------------------------------------------------------------------------------------------------------
颜色转换：
---------------------------------------------------------------------------------------------------------------------------------
          -binary dither    : 二进制转换
                         =>  nconvert -binary halft45   in.jpg
                         =>  nconvert -binary floyd     in.jpg    颜色转换成灰色
                         =>  nconvert -binary nodither  in.jpg    黑色了
dither取值：  
              pattern : 有序模式
              floyd   : 256色抖动
              halft45 : 中间色调 45
              halft90 : 中间色调 90
              nodither: 无递色
          -blur percent:模糊污点(1...100)
-----------------------------------------------------------------------------------------
亮度调整：
-----------------------------------------------------------------------------------------
          -brightness value : 修改亮度（-100..100）
                            => nconvert -brightness -100 in.jpg 调整亮度 
          -conbright value  : 修改亮度(-100...100) 
-----------------------------------------------------------------------------------------
调整画布：
-----------------------------------------------------------------------------------------
          -canvas w h pos   : 重新调整画布大小，pos是位置参数
                            w h 可以是百分数(例如: -resize 100% 200%)
              或者 #x #y 作为偏移量  x，y是偏移值

                  pos top-left, top-center, top-right
                  center-left, center, center-right
                  bottom-left, bottom-center, bottom-right
                  
         =>  nconvert -canvas 200% 200% center in.jpg  # 调整画布大小和位置
　　　　 =>　nconvert -canvas 200% 200% center  -bgcolor 255 0 225 in.jpg  # 调整画布大小和位置，画布背景为红色
　　　　　                                                              
-----------------------------------------------------------------------------------------
          -colours num
          -colors num       : 在索引颜色中转换(256, 216, 128, 64, 32, 16 or 8)
                            => nconvert -colours 32 in.gif # 对jpg无效果，转换后gif成静态
-----------------------------------------------------------------------------------------
          -contrast value   : 修改对比度(-100...100)
                            => nconvert -contrast 100 in.jpg      # 修改对比度
                            => nconvert -conbright -100 in.jpg    # 调整图片亮度
          -crop x y w h     : 剪切图片
                            => nconvert -crop 20 50 10 20 in.jpg   # 剪切图片
                            => nconvert -crop 0 0  1000 800 in.jpg # x，y是坐标
-----------------------------------------------------------------------------------------

          -dither           : Use dither for conversion (Colors and Grey only)

          -deinter k n      : De-interlace
              k : even or odd
              n : dup or int
                           => nconvert -deinter odd int in.jpg

          -edetail          : 提高细节

          -eedge percent    : 强化边缘 (1...100)
                            => nconvert -eedge 100 in.jpg

          -edgedetect type  : 探测边缘
                              type值为：light/medium/heavy
                            =>  nconvert -edgedetect medium in.jpg 

          -efocus           : 提高焦点

          -emboss           : 浮雕效果
                            =>  nconvert -emboss in.jpg

          -embossmore       : 增强浮雕效果
                            =>  nconvert -embossmore in.jpg

          -equalize         : 色彩均衡
                            =>  nconvert -Equalize in.jpg
          -frestore         : 焦点复原
          -gamma value      : Modify gamma (0.01<->5.0   灰度系数
          -gammasat value   : Modify gamma (0.01<->5.0

          -gauss size       : 高斯模糊(3,5,7,9,11,13..)，值越大执行时间越长

          -grey num         : 转换成灰阶(256, 128, 64, 32, 16, 8 or 4) 
                            =>  nconvert -grey 256 in.jpg 

          -hls h l s        : 调整亮度饱和度，色调
                            =>  nconvert -hls 10 12 10 in.jpg

          -lens percent     : 透镜放大效果(1...100)
                            =>  nconvert -lens 100 in.jpg

          -levels b w       : 色阶
                            =>  nconvert -levels 100 200 in.jpg

          -log              : 运用对数修正
                            =>  nconvert -log in.jpg

          -maximum size     : 最大过滤(3,5,7,9,11,13)
                            =>  nconvert -maximum 13 in.jpg
          -medianb size     : Median Box filter (3,5,7,9,11,13)      平均盒过滤(变模糊了)
          -medianc size     : Median Cross filter (3,5,7,9,11,13)    平均交叉过滤（模糊）
          -minimum size     : Minimum filter (3,5,7,9,11,13)          最小过滤 
                            =>  nconvert -minimum 13 in.jpg

          -mosaic size      : 马赛克效果(1...64)   size越大效果越明显
							=>  nconvert -mosaic 10 in.jpg

          -negate           : 负片效果
                            => nconvert -negate 64 in.jpg （还可跟数字来调整效果）
          -new bpp w h      : 创造新的位图
          -noise reduce     : 减少杂色
          -noise type value 
              uniform   : 增加唯一杂色
              gaussian  : 增加高斯杂色
              laplacian : 增加拉普拉斯杂色
              poisson   : 增加泊松杂色
                              =>   nconvert -noise poisson 5 in.jpg # 增加泊松杂色（老照片效果）
          -normalize        : 使正态化
          -oil size         : 油画效果(1...16)
                              =>   nconvert -oil 5 in.jpg   油画效果
          -posterize count  : 色调分离(2...256) 
                              =>   nconvert -posterize 2  in.jpg

          -ratio            : 保持比例缩放
          -rtype            : 重新采样
              quick    : 快速调整
              linear   : 线性调整
              hermite  : 艾米插值曲线
              gaussian : 高斯
              bell     : 钟状物
              bspline  : B样条
              mitchell : 米歇尔
              lanczos  : 兰索斯法
 
         -rflag      : 重设标志大小尺寸
              incr   : 只增加
              decr   : 只减少
              orient : 自适应
-----------------------------------------------------------------------------------------
调整图片宽高比：
-----------------------------------------------------------------------------------------

          -resize w h      : Scale width-height  宽高比
                             w h 可以是百分数 (example: -resize 100% 200%)
            =>  nconvert -resize 100% 200% 97.jpg in.jpg   调整宽高比
-----------------------------------------------------------------------------------------

          -rotate_flag      : 旋转标志
              smooth : 使用平滑的旋转
-----------------------------------------------------------------------------------------
旋转图片：
-----------------------------------------------------------------------------------------

          -rotate degrees   : 顺时针旋转
                              => nconvert  -rotate 30 96.jpg  # 顺时针旋转30度
                              => nconvert -rotate 30 -bgcolor 255 0 245 in.jpg # 旋转时背景色设置为红色
-----------------------------------------------------------------------------------------

          -sepia            : Sepia

          -sharpen percent  : 锐化(1...100)
                            =>  nconvert  -sharpen 100 in.jpg

          -shear            : 波浪化
          -slice            : 切片效果
          -soften percent   : 柔化(1...100)  

          -solarize value   : 曝光率(1...255) 
                            => nconvert  -solarize 5  in.jpg

          -spread amount    : 扩散(1...32)
                            => nconvert  -spread  20  in.jpg
          -swap type        : 交换通道
              rbg   : RGB->RBG
              bgr   : RGB->BGR
              brg   : RGB->BRG
              grb   : RGB->GRB
              gbr   : RGB->GBR
                    => nconvert  -swap rbg in.jpg   # 效果不错啊
                    => nconvert  -swap brg in.jpg   # 红色明显
-----------------------------------------------------------------------------------------
中心旋转：
-----------------------------------------------------------------------------------------

          -swirl degrees    : 中心旋转(1...360) 
                    => nconvert  -swirl 200 in.jpg   # 以图片中心为轴旋转200度
-----------------------------------------------------------------------------------------
在图片上添加文字：
-----------------------------------------------------------------------------------------
          -text string      :在图片上添加文字
          -text_font name size  :文字类型和大小
          -text_color r g b : 文字颜色
          -text_back r g b  : 文字背景颜色
          -text_flag pos    : 文字位置
                         top-left, top-center, top-right
                         center-left, center, center-right
                         bottom-left, bottom-center, bottom-right
          -text_pos x y     : 位移或偏移量
          -text_rotation degrees : 文字旋转度

         => nconvert -text_pos 100 150 -text_rotation 30  -text_back 255 255 120 -text  雨木林风 in.jpg
		    # 在图片上顺时针30度打上文字,文字背景为黄色

nconvert -text_font Verdana 72 -text_pos 90 100 -text_rotation 120  -text_flag center -text_color 255 0 255 -text_back 255 255 255 -text 焉知非鱼 *.jpg

        

             
-----------------------------------------------------------------------------------------

          -tile size        : 瓦片效果(1...64)
                            => nconvert  -tile 10 in.jpg
          -truecolors　　　 : 真彩效果
          -truecolours      : 真彩效果

          -xflip            : 水平翻转
                            => nconvert  -xflip   in.jpg

          -yflip            : 垂直翻转
                            => nconvert  -yflip   in.jpg

          -waves wavelength phase amount : Waves
              wavelength   : 波长(1.0 50.0) 
              phase        : 相位(0.0 360.0)
              amount       : 数量(0.0 100.0)

-----------------------------------------------------------------------------------------

                      =>   nconvert    -waves 15 12 50   in.jpg

-----------------------------------------------------------------------------------------
```