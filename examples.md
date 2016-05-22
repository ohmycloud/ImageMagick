## Simple Border Overlay

One simple type of framing is to create a fancy frame, or shaped image into which you can place your image, under the frame.

For example here we generate a simple frame slightly larger than our image with a fancy shaped hole. The shape was extracted from the 'WebDings' font (character 'Y'), but there are a lot of possible sources for fancy shapes that could be used for picture framing.

 

 
```
convert -size 120x140 -gravity center -font WebDings label:Y ^
          -negate -channel A -combine +channel -fill LightCoral -colorize 100% ^
          -background none -fill none -stroke firebrick -strokewidth 3 label:Y ^
          -flatten +gravity -chop 0x10+0+0 -shave 0x10 +repage border_heart.png
```


 

 

For other ways of generating a edge on an existing shaped image see the Edge Transform.

You can also optionally give the frame a little depth by using a Shadow Effect. 

 

```
convert border_heart.png  ( +clone -background black -shadow 60x3+3+3 ) ^
          -background none -compose DstOver -flatten   border_overlay.png
```







## Lighting Mask Technique

Glass Bubble Button
The next level of complexity in thumbnail processing is the application of very complex lighting effects. The trickiness here is not so much the application of a lighting effect to an image, but the generation of the appropriate shading effect.

For example using a Aqua Effect you can give an thumbnail a very complex shading effect that makes it look like it has been enclosed by a 'bubble' of glass. Also this works better with a thumbnail that has Rounded Corners.

For lets generate a rounded corners mask for our thumbnail image, using a pure gray color.

```
 convert thumbnail.gif -alpha off -fill white -colorize 100% \ -draw 'fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0' \ \( +clone -flip \) -compose Multiply -composite \ \( +clone -flop \) -compose Multiply -composite \ -background Gray50 -alpha Shape thumbnail_mask.png  
```
 


Now that we have a pure gray 'shape mask' we want to use, I can apply the Aqua Effect effect to generate a lighting overlay, for this shape.

```
 convert thumbnail_mask.png -bordercolor None -border 1x1 \ -alpha Extract -blur 0x10 -shade 130x30 -alpha On \ -background gray50 -alpha background -auto-level \ -function polynomial 3.5,-5.05,2.05,0.3 \ \( +clone -alpha extract -blur 0x2 \) \ -channel RGB -compose multiply -composite \ +channel +compose -chop 1x1 \ thumbnail_lighting.png  
```
 


With a final light/shade overlay image such as the above we can easily apply it to any thumbnail image of the right size.

```
 convert thumbnail.gif -alpha Set thumbnail_lighting.png \ \( -clone 0,1 -alpha Opaque -compose Hardlight -composite \) \ -delete 0 -compose In -composite \ glass_bubble.png  
```
 


Not only does this add the appropriate shading effects to any thumbnail of this size, but the same lighting image masks the thumbnail into the proper shape.

It is important to not that only the color channels are used to apply the lighting effect, the alpha channel is not used. Similarly when masking only the alpha channel is used, not the color channels. This is very important for without it you will not get the correct result.

For a discussion on extracting a lighting effect from images see the IM user forum topic Extracting light layer from two images.


This can be taken much further however in that we can also directly add shadow effects to this lighting mask. The added color however must be pure black, and you need to ensure the lighting effect composition chosen will make a image perfectly black is the lighting mask is black.

However this is actually how shadow effects are normally added to an image, as such you can just add shadows to the "lighting effect mask" directly, and all will be well!

The same thing is true for adding lighting 'flares', but only using white pixels for the flare overlay.

In essence a "lighting effect image" can again actually merge the two Mask 'n' Paint images back into a single image. As you will see in the next example.


 

Windows 中：

```
convert thumbnail.gif -alpha off -fill white -colorize 100% ^
     -draw "fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0" ^
     ( +clone -flip ) -compose Multiply -composite ^
     ( +clone -flop ) -compose Multiply -composite ^
     -background Gray50 -alpha Shape    thumbnail_mask.png
```
 

```
convert thumbnail_mask.png -bordercolor None -border 1x1 ^
          -alpha Extract -blur 0x10  -shade 130x30 -alpha On ^
          -background gray50 -alpha background -auto-level ^
          -function polynomial  3.5,-5.05,2.05,0.3 ^
          ( +clone -alpha extract  -blur 0x2 ) ^
          -channel RGB -compose multiply -composite ^
          +channel +compose -chop 1x1 ^
          thumbnail_lighting.png
```

```
 convert thumbnail.gif -alpha Set thumbnail_lighting.png ^
          ( -clone 0,1 -alpha Opaque -compose Hardlight -composite ) ^
          -delete 0 -compose In -composite ^
          glass_bubble.png
```

 

 

## Polaroid-like Thumbnails
You can make your thumbnail image look like a polaroid photo, give it a shadow, and even rotate it a little so as to appear to be just sitting on a table.

```
 convert thumbnail.gif ^
          -bordercolor white  -border 6 ^
          -bordercolor grey60 -border 1 ^
          -background  none   -rotate 6 ^
          -background  black  ( +clone -shadow 60x4+4+4 ) +swap ^
          -background  none   -flatten ^
          poloroid.png
```
 

 
```
convert -size 150x150 xc:none -background none ^
          -fill white -stroke grey60 ^
          -draw "rectangle 0,0 130,100" thumbnail.gif ^
                -geometry +5+5 -composite -rotate -10 ^
          -draw "rectangle 0,0 130,100" thumbnail.gif ^
                -geometry +5+5 -composite -rotate -10 ^
          -draw "rectangle 0,0 130,100" thumbnail.gif ^
                -geometry +5+5 -composite -rotate +10 ^
          -trim +repage -background LightSteelBlue -flatten ^
          poloroid_spread.gif
```



```
convert null: -format "%[fx:rand()*30-15]" info:7.63333
```

```
convert null: -format "%[fx:rand()*30-15]" info:-3.26918
```
 

```
convert thumbnail.gif  ^
     -bordercolor white  -border 6  ^
     -bordercolor grey60 -border 1  ^
     -bordercolor none  -background  none  ^
     ( -clone 0 -rotate 12.254 )  ^
     ( -clone 0 -rotate -12.025 ) ^
     ( -clone 0 -rotate -6.632 )  ^
     ( -clone 0 -rotate 2.652 )  ^
     -delete 0  -border 100x80  -gravity center ^
     -crop 200x160+0+0  +repage  -flatten  -trim +repage ^
     -background black ( +clone -shadow 60x4+4+4 ) +swap  ^
     -background none  -flatten  ^
     poloroid_stack.png
```
