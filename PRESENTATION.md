# WELCOME TO OUR STEGANOGRAPHIC IMAGE DECODING/ENCODING TOOL

## Explaining stegsolve
  Let's dive into an image! Images can have meta data, but a core source of
  information space is in their pixels. Obviously images range in pixel
  quantity, but each pixel contains four byte-sized channels, which is 32 bits
  per pixel!
  stegsolv.jar, that lovely program we're all glad to have access to via the
  cyber_resources folder, allows you to look into those 32 pockets for a whole
  image. Essentially, stegsolve reorganizes seemingly insignificant bits of an
  image to deduce whether there is a hidden message encoded.

## How did we make a sister replica of stegsolve?
With the help of experimentation and the pirate Mr. K, we were able to discover
the methodologies that stegsolve uses to flesh out images. We divided each option
of stegsolve into different void methods in Processing 3 and then coded whatever was
necessary to achieve our goals. For example, for the XOR option, we essentially XORed
the RGB values with 255 to get our inverse color result. Using a bunch of embedded
Processing methods, we discovered ways to manually create buttons, which
allow the user to rotate between certain viewing options (e.g. red planes, XOR, isolate),
and also display text to signify what viewing option is being presented.

We didn't include all of stegsolve's viewing modes, like gray bits and random colour map,
but we did add planes for the hue, saturation, and brightness of the pixels as well.
These are not necessarily separate values within the pixel but are different channels
that processing can express into easy bytes.

![Pixels are 4D but lets simplify it to cool gradient shapes](/images/rgb-vs-hsv.jpg)

## How to Use It
It's quite simple! Just click the button to try out different viewing options and discover
if there's a flag embedded in the image file. You must add an image called "YourImage.png" for
the program to work. Keep in mind also that the program only supports images with the dimensions
(950, 600) or smaller, unless the user wants a cropped image.

## What kind of problems can stegsolve solve?
In class we looked at hiding numbers that correspond to ASCII in the least significant bits, but there are other more image-specific ways to hide information. Whole words or QR codes can be written directly onto images, and to further obstruct detection such phrases can be
written in a cursive few machines could ever discern.

## Why Is This Tool Useful?
It's great for finding flags! These stegsolve tools might not come up in most
day-to-day cybersecurity work, but in the idealized dream of cybersecurity work
that involves international espionage and subliminal messaging, stegsolve could
mean life or death.
