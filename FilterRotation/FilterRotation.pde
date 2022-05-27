//I think we should have a bunch of filters that show yk only the green or only the blue or
//only the red of the image being displayed, and then the draw method would rotate through that
//if we wanted to be really extra a button could rotate through them so the user has control

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

//Button
int bx = 550; int by = 0;
int bSize = 50;
color bColor = color(190); color bHighlight = color(175);
boolean bOver = false;

int currentF = 0;
PImage img;
PImage newie;
PImage encoded;//draw method!!

void setup() {
    //int i = Integer.parseInt(args[0]);
    //int j = Integer.parseInt(args[1]);
    //size(i, j); //should we have the user input the pixel size or should we create a method to automatically detect the pixel size?
    size(900, 600);

    img = loadImage("YourImage.png");
    img.loadPixels();
    newie = loadImage("YourImage.png");
    newie.loadPixels();

    textSize(30);
}

void draw() {
  background(0,0,0);
  update();//for button
  if (currentF > 38) {
    currentF = 0;
  }
  String display = "Standard";

  if (currentF == 0) {
    image(img, 0, 0);
  } else if (currentF == 1) {
    xoranio();
    image(newie, 0, 0);
    display = "Inverse";
  } else if (currentF >= 2 && currentF < 34) {
    int channel = (currentF - 2) / 8;
    //int num = (currentF - 2) % 8; //this system does least significant bit first
    int num = Math.abs(7 - ((currentF - 2) % 8)); //this system does most significant bit first
    planes(channel, num);
    image(newie, 0, 0);
    if (channel == 0) { display = "Alpha "; }
    if (channel == 1) { display = "Red "; }
    if (channel == 2) { display = "Green "; }
    if (channel == 3) { display = "Blue "; }
    display += "plane " + str(num);
  } else if (currentF >= 34 && currentF < 38) {
    int channel = (currentF - 34) % 8;
    isolate(channel);
    image(newie, 0, 0);
    if (channel == 0) { display = "Alpha "; }
    if (channel == 1) { display = "Red "; }
    if (channel == 2) { display = "Green "; }
    if (channel == 3) { display = "Blue "; }
    display = "Full " + display;
  }
  
  fill(255,255,255);
  text(display, 550, 60);
  
  if (bOver) {
    fill(bHighlight);
  } else {
    fill(bColor);
  }
  stroke(0);
  rect(bx, by, bSize, bSize/2);
}

//Filter methods

void planes(int channel, int num) {
  int numPixels = img.width * img.height;
  for (int i = 0; i < numPixels; i++) {
    color c = img.pixels[i];
    int other = (int)(Math.pow(2, num));
    if (channel == 0){
      channel = (int)alpha(c);
    } else if (channel == 1) {
      channel = (int)red(c);
    } else if (channel == 2) {
      channel = (int)green(c);
    } else if (channel == 3) {
      channel = (int)blue(c);
    }
    channel = (channel & other) >> num;
    newie.pixels[i] = color(channel*255);
  }
  newie.updatePixels();
  newie.save("modifiedImage.png");
}

void isolate(int channel) {
  int numPixels = img.width * img.height;
  for (int i = 0; i < numPixels; i++) {
    color c = img.pixels[i];
    int red = (int)red(c);
    int blue = (int)blue(c);
    int green = (int)green(c);
    int alpha = (int)alpha(c);
    if (channel == 0) {
      newie.pixels[i] = color(0, 0, 0, alpha);
    }
    else if (channel == 1) {
      newie.pixels[i] = color(red, 0, 0);
    }
    else if (channel == 2) {
      newie.pixels[i] = color(0, green, 0);
    }
    else {
       newie.pixels[i] = color(0, 0, blue);
    }
  }
  newie.updatePixels();
  newie.save("modifiedImage.png");
}

void xoranio() {
  int numPixels = img.width * img.height;
  for (int i = 0; i < numPixels; i++) {
    color c = img.pixels[i];
    int red = ((int)red(c) ^ 255);
    int green = ((int)green(c) ^ 255);
    int blue = ((int)blue(c) ^ 255);
    newie.pixels[i] = color(red, green, blue);
  }
  newie.updatePixels();
  newie.save("modifiedImage.png");
}

//Button methods

void update() {
  if ( overButt(bx, by, bSize, bSize/2) ) {
    bOver = true;
  } else {
    bOver = false;
  }
}

void mousePressed() {
  if (bOver) {
    currentF += 1;
    print(currentF);
  }
}

boolean overButt(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
