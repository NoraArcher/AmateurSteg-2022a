//I think we should have a bunch of filters that show yk only the green or only the blue or 
//only the red of the image being displayed, and then the draw method would rotate through that
//if we wanted to be really extra a button could rorate through them so the user has control

//we should also have an encoding component, maybe with a separate processing sketch, where you 
//can choose a filter to encode in, enter a message, then see the final unfiltered image
//like the user could pick a number between 1-10, they pick 3 and that's blue, then they enter 
//"goober" and it displays the original image with the tail end of the blue component of some of the pixels changed to encode that message

//draft project description for google form:
//We will write a processing program that can display a given image with multiple 'filters' that 
//isolate the different bits that could be changed, as well as a mirror program that can encode short messages 
//in different groups of bits so that they will be displayed in a final image.

import java.util.*;
import java.lang.*;

int currentF = 0;
PImage img;

void setup() {
    //int i = Integer.parseInt(args[0]);
    //int j = Integer.parseInt(args[1]);
    //size(i, j); //should we have the user input the pixel size or should we create a method to automatically detect the pixel size? 
    size(900, 600);
    img = loadImage("YourImage.png");
    img.loadPixels();
}

void planes(int channel, int num) {
  image(img, 0, 0);
}

void isolate(int channel, int num) {
  image(img, 0, 0);
}

void xoranio() {
  image(img, 0, 0);
}

void draw() {
  //if button is pressed
      //currentF += 1
  if (currentF == 0) {
    image(img, 0, 0);
  } else if (currentF == 1) {
    xoranio();
  } else if (currentF >= 2 && currentF < 34) {
    int channel = (currentF - 2) / 8;
    int num = (currentF - 2) % 8;
    planes(channel, num);
  } else if (currentF >= 34 && currentF < 66) {
    int channel = (currentF - 34) / 8;
    int num = (currentF - 34) % 8;
    isolate(channel, num);
  }
}
