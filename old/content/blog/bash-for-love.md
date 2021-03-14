---
kind: article
created_at: "2018-01-07"
title: Bash in the name of love
---

For my aniversary I tried to express my love in the most pure form I could, making an animated gif of great moments in your relationship.  Obviously my tool of choice where was bash, because I could have used a gui tool but where's the fun in that.

### The aim

A large format animated GIF based off a bunch of JPG images, or different resolutions, in a random order.

### The process

First I gathered all the images into a directory from my Shotwell collecion and Google Photos.  There was one name clash, easily dealt with.

#### Make them all JPG
If I'd had any images with a different file type I'd have converted them now.  `convert` is part of ImageMagick and makes this super simple.

```
convert image.png image.jpg
```

#### Random order

Because I was going to use the files with `ls` other then having a random file name makes this easier.  Punting the filename thought md5sum gives  nice random file to order.

```
for FILE in `ls`
do
export NEWFILE=$(echo $FILE | md5sum| cut -f1 -d" ")
mv $FILE $NEWFILE.jpg
done
```

#### Resize them

I needed a bunch of images that were all the same size, but without having small images being blown up huge and blurring.  Step in convert, again.  `-extent` resizes the image, `-gravity center` centres it.

```
for FILE in `ls *.jpg`
do
convert $NAME -gravity center -background white -extent 1600x1200 centred_${NAME}
done
```

#### String them all together

I messed about with `ffmepg` for hours (literally) trying to get the right magic incantations of flags.  Luckily, `convert` stepped in and saved the day.

The only flag I needed was `-delay` which is the numbe of milliseconds between frames

```
convert -delay 100  -loop 0 *.jpg final.gif
```

#### The result

I'm not sharing it.  There was squeeing though.