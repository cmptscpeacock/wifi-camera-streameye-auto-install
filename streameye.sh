#!/bin/bash

# variables

streamPort=8081
brightness=50
contrast=50
saturation=50
sharpness=50
width=640
height=480
rotation=0
vflip=--vflip
hflip=--hflip
framerate=15
quality=25
zoom=0.0,0.0,1.0,1.0
iso=400
shutter=0
exposure=auto
ev=0
awb=auto
metering=average
drc=off
vstab=--vstab
denoise=--denoise
imxfx=none

# run streameye with python

/home/pi/streameye/extras/raspimjpeg.py --brightness $brightness --contrast $contrast --saturation $saturation --sharpness $sharpness --width $width --height $height --rotation $rotation $vflip $hflip --framerate $framerate --quality $quality --zoom $zoom --preview --iso $iso --shutter $shutter --exposure $exposure --ev $ev --awb $awb --metering $metering --drc $drc $vstab $denoise --imxfx $imxfx | streameye -p $streamPort
