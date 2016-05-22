- Usage: convert [options ...] file [ [options ...] file ...] [options ...] file

## 图像设置

```
  -adjoin              附加,连接图像成为一个单一的多图像文件
  -affine matrix       仿射矩阵, 仿射变换矩阵
  -antialias           反锯齿, 移除像素走样
  -authenticate value  decrypt image with this password
  验证         值      用此密码破译图像
  -background color    background color
  背景       颜色      背景色
  -bias value          add bias when convolving an image
  偏斜   值            回旋图像时增加偏斜度
  -black-point-compensation 黑点补偿
                       use black point compensation 使用黑点补偿
  -blue-primary point  chromaticity blue primary point
  主蓝色               染为主蓝色点
  -bordercolor color   border color
  边框颜色     颜色    边框颜色
  -caption string      assign a caption to an image
  标题     字符串      给图像添加一个标题
  -channel type        apply option to select image channels
  通道    类型         应用选项选择图像通道
  -colors value        preferred number of colors in the image
  色彩    值           图像的色彩数
  -colorspace type     alternate image colorspace
  色彩空间   类型      交替图像色彩空间
  -comment string      annotate image with comment
  注释      字符串     为图像添加注释
  -compose operator    set image composite operator
  -compress type       type of pixel compression when writing the image
  压缩     类型        写入图像时的像素压缩类型
  -debug events        display copious debugging information
  排错  事件           显示丰富的调试信息
  -define format:option
                       define one or more image format options
  -delay value         display the next image after pausing
  延时   值            暂停一定时间后显示下张图像
  -density geometry    horizontal and vertical density of the image
  密度     几何        图像的水平和垂直密度
  -depth value         image depth
  深度   值            图像深度
  -display server      get image or font from this X server
  显示     服务器      从此服务器获取图像或字体
  -dispose method      GIF disposal method
  处理     方法        gif处理方法
  -dither              apply Floyd/Steinberg error diffusion to image
 
  -encoding type       text encoding type
  编码      类型       正文编码类型
  -endian type         endianness (MSB or LSB) of the image
  -family name         render text with this font family
 
  -fill color          color to use when filling a graphic primitive
  填充  颜色           填充简单图表时使用的颜色
  -filter type         use this filter when resizing an image
  滤镜    类型         调整图像大小时使用的滤镜
  -font name           render text with this font
  字体  字体名         用此字体描绘正文
  -format "string"     output formatted image characteristics
  样式     字符串      输出格式化的图像属性
  -fuzz distance       colors within this distance are considered equal
  柔化  距离           在此距离之内的颜色被认为是相同的
  -gravity type        horizontal and vertical text placement
  引力     类型        正文的水平和垂直位置
  -green-primary point chromaticity green primary point
  -intent type         type of rendering intent when managing the image color
  -interlace type      type of image interlacing scheme
  -interpolate method  pixel color interpolation method
  -label string        assign a label to an image
  标签   字符串        为图像分配一个标签
  -limit type value    pixel cache resource limit
  限额   类型  值      像素缓存资源限制
  -log format          format of debugging information
  日志格式            调试信息的格式
  -loop iterations     add Netscape loop extension to your GIF animation
  循环  反复
  -mask filename       associate a mask with the image
  遮罩  文件名         连结遮罩和图像
  -matte               store matte channel if the image has one
  不光滑的             存储不光滑的通道如果图像有一个的话
  -mattecolor color    frame color
                       帧色彩
  -monitor             monitor progress
  监测                 监测进展
  -orient type         image orientation
  -origin geometry     image origin
  -page geometry       size and location of an image canvas (setting)
  页    几何           图像画布大小和位置
  -ping                efficiently determine image attributes
                       高效测定图像属性
  -pointsize value     font point size
   像素大小  值        字体像素大小
  -preview type        image preview type
  预览     类型        图像预览类型
  -quality value       JPEG/MIFF/PNG compression level
  质量     值          JPEG/MIFF/PNG压缩水平
  -quiet               suppress all error or warning messages
  安静模式             不显示错误和警告信息
  -red-primary point   chromaticity red primary point
  -regard-warnings     pay attention to warning messages
  注意警告             注意警告信息
  -sampling-factor geometry 抽样因子  几何
                       horizontal and vertical sampling factor 水平和垂直抽样因子
  -scene value         image scene number
  场景   值            图像场景数
  -seed value          pseudo-random number generator seed value
  种子  值             伪随机数
  -size geometry       width and height of image
  大小  几何数         图像宽和高
  -stretch type        render text with this font stretch
  伸展度   类型        用此字体伸展度描绘正文
 
  -stroke color        graphic primitive stroke color
  笔调    颜色         简单图表笔调颜色
  -strokewidth value   graphic primitive stroke width
  -style type          render text with this font style
  风格   类型          用此字体风格描绘正文
  -support factor      resize support: > 1.0 is blurry, < 1.0 is sharp
  支柱     因子        调整支柱大小：>1.0为模糊，<1.0为清晰
  -taint               image as ineligible for bi-modal delegate
  污点                
  -texture filename    name of texture to tile onto the image background
  质地     文件名      覆盖到图像背景上的质地名
  -treedepth value     color tree depth
  树深        值       色彩树深
  -transparent-color color 色彩透明
                       transparent color 色彩透明
  -undercolor color    annotation bounding box color
  -units type          the units of image resolution
  单位   类型          图像分辨率类型
  -verbose             print detailed information about the image
  详细                 打印图像详细信息
  -view                FlashPix viewing transforms
  -virtual-pixel method
                       virtual pixel access method
  -weight type         render text with this font weight
  重量    类型         用此字体重量描绘正文
  -white-point point   chromaticity white point
  白点                 染为白点

Image Operators: 图像操作

  -adaptive-blur geometry 自适应模糊 
                       adaptively blur pixels; decrease effect near edges
        自适应模糊像素；减少靠近边缘的影响
  -adaptive-resize geometry 自适应调整大小
                       adaptively resize image with data dependent triangulation
        依靠三角测量自适应调整图像大小
  -adaptive-sharpen geometry 自适应锐化
                       adaptively sharpen pixels; increase effect near edges
        自适应提升像素；增加靠近边缘的影响
  -annotate geometry text 注释 几何数 正文
                       annotate the image with text
        用正文为图像注释
  -auto-orient         automatically orient image
  自适应               使图像自适应
  -black-threshold value 黑色阀值 值
                       force all pixels below the threshold into black
        强制使阀值以下的像素变为黑色
  -blur geometry       reduce image noise and reduce detail levels
  模糊  几何数         减少图像噪点和减少细节水平
  -border geometry     surround image with a border of color
  边框   几何数        用一种边框颜色包围图像
  -charcoal radius     simulate a charcoal drawing
  炭笔      半径       模拟炭笔绘图
  -chop geometry       remove pixels from the image interior
  切    几何数         从图像内部移除像素
  -clip                clip along the first path from the 8BIM profile
  剪                   沿第一条路径剪切
  -clip-mask filename  associate a clip mask with the image
 
  -clip-path id        clip along a named path from the 8BIM profile
  -colorize value      colorize the image with the fill color
  使变成彩色           用填充颜色使图像变为彩色
  -contrast            enhance or reduce the image contrast
  对比度               提高或减少图像对比度
  -contrast-stretch geometry 拉伸对比度
                       improve contrast by `stretching' the intensity range
        通过‘拉伸’强度范围提高对比度
  -convolve coefficients 回旋 系数
                       apply a convolution kernel to the image
        应用一个回旋中心到图像
  -cycle amount        cycle the image colormap
  -despeckle           reduce the speckles within an image
  减少斑点             减少图像上的斑点
  -draw string         annotate the image with a graphic primitive
                       注释
  -edge radius         apply a filter to detect edges in the image
  边缘化  半径         应用滤镜探测图像边缘
  -emboss radius       emboss an image
  浮雕    半径         使图像浮雕化
  -enhance             apply a digital filter to enhance a noisy image
  提高                 应用数码滤镜到一个噪点图像
  -equalize            perform histogram equalization to an image
  相等                
  -evaluate operator value 计算 操作数 值
                       evaluate an arithmetic, relational, or logical expression
        计算一个算术表达式，关系表达式或逻辑表达式
  -extent geometry     set the image size
  面积    几何数       设置图像大小
  -extract geometry    extract area from image
  提取     几何数      从图像中提取面积
  -flip                flip image vertically
  翻转                 垂直翻转图像
  -floodfill geometry color填满  几何数 颜色
                       floodfill the image with color
        用颜色填满图像
  -flop                flop image horizontally
  翻动                 水平翻动图像
  -frame geometry      surround image with an ornamental border
  框架   几何数        用修饰边框围绕图像
  -gamma value         level of gamma correction
  -gaussian-blur geometry 高斯模糊 几何数
                       reduce image noise and reduce detail levels
  -geometry geometry   perferred size or location of the image
  几何                
  -help                print program options
  -identify            identify the format and characteristics of the image
  识别                 识别图像格式和属性
  -implode amount      implode image pixels about the center
  内爆     数量        向心聚爆
  -lat geometry        local adaptive thresholding
  -layers method       optimize or compare image layers
  图层   方法          优化或对比图层
  -level value         adjust the level of image contrast
  强度   值            调整图像对比强度
  -linear-stretch geometry
                       improve contrast by `stretching with saturation' the intensity range
  -median radius       apply a median filter to the image
  -modulate value      vary the brightness, saturation, and hue
  调整                 改变亮度，饱和度，色调
  -monochrome          transform image to black and white
  黑白照片             转换图像为黑白色
  -motion-blur geometry 动感模糊 几何值
                       simulate motion blur 模仿动感模糊
  -negate              replace every pixel with its complementary color
  负片
  -noise radius        add or reduce noise in an image
  噪点   半径          增加或减少图像噪点
  -normalize           transform image to span the full range of colors
  恢复正常            
  -opaque color        change this color to the fill color
  不透明  颜色         改变此颜色为填充色
  -ordered-dither NxN
                       add a noise pattern to the image with specific amplitudes
  -paint radius        simulate an oil painting
  油画
  -polaroid angle      simulate a Polaroid picture
  倾斜角度            模仿相片
  -posterize levels    reduce the image to a limited number of color levels
  色调       水平      减少图像的颜色水平到一定限制值
  -print string        interpret string and print to console
  打印   字符串         解释字符串然后打印到控制台
  -profile filename    add, delete, or apply an image profile
  简介      文件名     增加，删除，或应用一个图像概况
  -quantize colorspace reduce colors in this colorspace
  量化色彩空间        在此色彩空间减少色彩
  -radial-blur angle   radial blur the image
  放射模糊  角度        放射模糊图像
  -raise value         lighten/darken image edges to create a 3-D effect
  提升   值            增亮/减暗图像边缘创建3-D效果
  -random-threshold low,high 随机阀值 低，高
                       random threshold the image
  -recolor matrix      translate, scale, shear, or rotate image colors
  重新染色矩阵        转化，刮去，变形，旋转图像颜色
  -region geometry     apply options to a portion of the image
  选区   几何          应用选项到图像选区
  -render              render vector graphics
  描绘                 描绘矢量图
  -repage geometry     size and location of an image canvas
 
  -resample geometry   change the resolution of an image
  重新取样  几何数     改变图像分辨率
  -resize geometry     resize the image
  调整大小几何数      调整图像大小
  -roll geometry       roll an image vertically or horizontally
  展平  几何数
  -rotate degrees      apply Paeth rotation to the image
  旋转    度数        
  -sample geometry     scale image with pixel sampling
  样品    几何数       用像素样本绘制图像
  -scale geometry      scale the image
  绘制   几何数        按比例绘制图像副本
  -segment values      segment an image
  片段
  -sepia-tone threshold 棕色调  阀值
                       simulate a sepia-toned photo
  -set property value  set an image property
  -shade degrees       shade the image using a distant light source
  阴影   度数          用远光源为图像添加阴影
  -shadow geometry     simulate an image shadow
  阴影    几何数        模仿图像阴影
  -sharpen geometry    sharpen the image
  锐化     几何数      锐化图像
  -shave geometry      shave pixels from the image edges
  修理   几何数      
  -shear geometry      slide one edge of the image along the X or Y axis
  剪切
  -sigmoidal-contrast geometry
                       lightness rescaling using sigmoidal contrast enhancement
  -sketch geometry     simulate a pencil sketch
  素描     几何数      模拟铅笔素描
  -solarize threshold  negate all pixels above the threshold level
  过度曝光  阀值
  -splice geometry     splice the background color into the image
  胶结                 把背景色胶结到图像上
  -spread amount       displace image pixels by a random amount
  散布    数量
  -strip               strip image of all profiles and comments
  剥夺                 剥去图像所有的简介和注释
  -swirl degrees       swirl image pixels about the center
  中心旋转度数        以图像像素为中心旋转图像
  -threshold value     threshold the image
  阀值       值
  -thumbnail geometry  create a thumbnail of the image
  缩略图     几何数    创建图像的缩略图
  -tile filename       tile image when filling a graphic primitive
  覆盖  文件名         填充图像时覆盖图像
  -tint value          tint the image with the fill color
  染色  值             使用填充色为图像染色
  -transform           affine transform image
  改变                 仿射改变图像
  -transparent color   make this color transparent within the image
  透明         颜色    使图像内的此颜色变为透明
  -transpose           flip image vertically and rotate 90 degrees
  变换顺序             垂直剪切图像，旋转90度
  -transverse          flop image horizontally and rotate 270 degrees
  横切                 水平翻动图像，旋转270度
  -trim                trim image edges
  修剪                 修剪图像边缘
  -type type           image type
  类型  类型           图像类型
  -unique-colors       discard all but one of any pixel color
  单色                 保留单色
  -unsharp geometry    sharpen the image
  钝化                
  -version             print version information
  -vignette geometry   soften the edges of the image in vignette style
  -wave geometry       alter an image along a sine wave
  波浪  几何数         伴随正弦波改变图像
  -white-threshold value 白色阀值  值
                       force all pixels above the threshold into white
                       强制阀值以上的所有像素变为白色
                       
Image Sequence Operators:

  -append              append an image sequence
  附加                 附加一个图像序列
  -average             average an image sequence
  平均                 求图像序列的平均数
  -coalesce            merge a sequence of images
  合并                 合并图像序列
  -combine             combine a sequence of images
  联结                 联结图像序列
  -composite           composite image
  合成                 合成图像
  -crop geometry       cut out a rectangular region of the image
  剪切  几何           剪出一矩形图像
  -deconstruct         break down an image sequence into constituent parts
  解构                 分解图像序列为组成部分
  -flatten             flatten a sequence of images
  平滑                 平滑图像序列
  -fx expression       apply mathematical expression to an image channel(s)
      表达式           应用数学表达式到图像通道
  -map filename        transform image colors to match this set of colors
  绘制文件名          改变图像颜色去匹配这颜色集
  -morph value         morph an image sequence
  变化   值            变换图像序列
  -mosaic              create a mosaic from an image sequence
  马赛克               从图像序列中制作马赛克
  -process arguments   process the image with a custom image filter
  处理     幅角        用定制的滤镜处理图像
  -reverse             reverse image sequence
  反向                 反转图像序列
  -separate            separate an image channel into a grayscale image
  分离                 将一个图像通道分离为灰度图像
  -write filename      write images to this file
  写      文件名       把图像写入此文件
  
Image Stack Operators:
  -clone index         clone an image
   复制  索引           复制图像
  -delete index        delete the image from the image sequence
   删除   索引          从图像序列删除此图
  -insert index        insert last image into the image sequence
   插入    索引         将最后的图片插入图像序列
  -swap indexes        swap two images in the image sequence
   交换    索引         交换图像序列中的两图像
```

By default, the image format of `file' is determined by its magic
number.  To specify a particular image format, precede the filename
with an image format name and a colon (i.e. ps:image) or specify the
image type as the filename suffix (i.e. image.ps).  Specify 'file' as
'-' for standard input or output.

```
convert label.gif +matte ^
( +clone -shade 110x90 -normalize -negate +clone -compose Plus -composite ) ^
( -clone 0 -shade 110x50 -normalize -channel BG -fx 0 +channel -matte ) ^
-delete 0 +swap -compose Multiply -composite button.gif
```

```
convert -size 320x90 canvas:none -stroke snow4 -size 1x90 -tile gradient:white-snow4 ^
  -draw "roundrectangle 16, 5, 304, 85 20,40" +tile -fill snow ^
  -draw "roundrectangle 264, 5, 304, 85  20,40" -tile gradient:chartreuse-green ^
  -draw "roundrectangle 16,  5, 180, 85  20,40" -tile gradient:chartreuse1-chartreuse3 ^
  -draw "roundrectangle 140, 5, 180, 85  20,40" +tile -fill none ^
  -draw "roundrectangle 264, 5, 304, 85 20,40" -strokewidth 2 ^
  -draw "roundrectangle 16, 5, 304, 85 20,40" ( +clone -background snow4 ^
  -shadow 80x3+3+3 ) +swap -background none -layers merge ( +size ^
  -pointsize 90 -strokewidth 1 -fill red label:"50 %" -trim +repage ( +clone ^
  -background firebrick3 -shadow 80x3+3+3 ) +swap -background none -layers merge ) ^
  -insert 0 -gravity center -append -background white -gravity center -extent 320x200 ^
  cylinder_shaded.png
```
