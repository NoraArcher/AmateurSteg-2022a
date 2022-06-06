import java.util.*;
import java.lang.*;

//Button
int bx, by;
int bSize = 50;
color bColor = color(150,0,30); color bHighlight = color(120,0,0);
boolean bOver = false;

int currentF = 0;
PImage img;
PImage newie;
PImage encoded; //draw method's PImage if necessary
PImage disguised;
boolean dover = false;
boolean edit = false;

void setup() {
    size(950, 600);
    bx = width - 55;
    by = height - 30;
    img = loadImage("YourImage.png"); //replace the image name here!
    img.loadPixels();
    newie = loadImage("YourImage.png"); //replace the image name here!
    newie.loadPixels();
    encoded = newie;
    encoded.loadPixels();
    
    textSize(30);
}

void draw() {
  encoded = newie.get();
  encoded.loadPixels();
  background(0,0,0);
  update();//for button
  String display = "";
  if (edit) {
    text("Editing Mode", 5, height-6);
    image(encoded, 0, 0);
  }
  else {
  if (currentF >= 62) {
    currentF = 0;
  }
  if (currentF == 0) {
    image(img, 0, 0);
    display = "Standard";
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
  } else if (currentF >= 38 && currentF < 62) {
    int channel = (currentF - 38) / 8;
    int num = Math.abs(7 - ((currentF - 38) % 8));
    planes2(channel, num);
    image(newie, 0, 0);
    if (channel == 0) { display = "Hue "; }
    if (channel == 1) { display = "Saturation "; }
    if (channel == 2) { display = "Brightness "; }
    display += "plane " + str(num);
  }
  }
  fill(250,0,15);
  text(display, 5, height-6);
  //bottom button (for changing filter methods)
  fill(255,255,255);
  textSize(10);
  text("→", 5, height-6);
  if (bOver) {
    fill(bHighlight);
  } else {
    fill(bColor);
  }
  rect(bx, by, bSize, bSize/2);
  //top button (for encoding)
  if (dover) {
    fill(150, 150, 150);
  } else {
    fill(255, 255, 255);
  }
  rect(width - 55, height - 60, bSize, bSize/2);
}

//filter methods
void planes(int channel, int num) {
  int numPixels = img.width * img.height;
  for (int i = 0; i < numPixels; i++) {
    color c = img.pixels[i];
    int other = (int)(Math.pow(2, num));
    int beet = (int)alpha(c);
    if (channel == 1) {
      beet = (int)red(c);
    } else if (channel == 2) {
      beet = (int)green(c);
    } else if (channel == 3) {
      beet = (int)blue(c);
    }
    beet = (beet & other) >> num;
    newie.pixels[i] = color(beet*255);
  }
  newie.updatePixels();
  newie.save("modifiedImage.png");
}

//isolation of RGB
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
//xor function
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
}
//planes for hue, saturation, and brightness
void planes2(int channel, int num) {
  int numPixels = img.width * img.height;
  for (int i = 0; i < numPixels; i++) {
    color c = img.pixels[i];
    int other = (int)(Math.pow(2, num));
    int beet = (int)hue(c);
    if (channel == 1) {
      beet = (int)saturation(c);
    } else if (channel == 2) {
      beet = (int)brightness(c);
    }
    beet = (beet & other) >> num;
    newie.pixels[i] = color(beet*255);
  }
  newie.updatePixels();
  newie.save("modifiedImage.png");
}

//Button methods
void update() {
  if (overButt(bx, by, bSize, bSize/2)) {
    bOver = true;
  } else {
    bOver = false;
  }
}

void mousePressed() {
  if (bOver && !edit) {
    currentF += 1;
    //print(currentF);
  }
  if (overStomach()) {
    dover = !dover;
    edit = !edit;
  }
}
//THE ACTUAL DRAWING/EDITING METHOD
void mouseDragged() {
  if (overPic() && edit) {
    int position = mouseX + mouseY*newie.width;
    //color c = newie.pixels[position];
    newie.pixels[position] = color(0);
    ori(position);
    newie.updatePixels();
  }
}
//if the mouse is over the red button
boolean overButt(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
//if the mouse is over the window of the image. 
boolean overPic() {
  if (mouseX >= 0 && mouseX <= img.width-1 &&
      mouseY >= 0 && mouseY <= img.height-1) {
      return true; 
  }
  else {
    return false;
  }
}
//if the mouse is over the top button
boolean overStomach() {
  if (mouseX >= width - 55 && mouseX <= width - 5 &&
      mouseY >= height - 60 && mouseY <= height - 35) {
    return true;
  } else {
    return false;
  }
}

//Reversing Functions
void ori(int pcor) {
  //color c = newie.pixels[pcor]; this is just black, 0, always
  color real = img.pixels[pcor];
  int a = (int)alpha(real);
  int r = (int)red(real);
  int g = (int)green(real);
  int b = (int)blue(real);
  int h = (int)hue(real);
  int s = (int)saturation(real);
  int v = (int)brightness(real);//value = brightness
  if (currentF == 1) {//standard
  } else if (currentF == 2) {//xor
  } else if (currentF >= 2 && currentF < 34) {//planes
    int channel = (currentF - 2) / 8;
    int num = Math.abs(7 - ((currentF - 2) % 8));
    if (channel == 0) { 
      a = (1 << num) ^ a;
      //real normal alpha: 1111 1111
      //newie color: 0 (plane 2)
      //disguised alpha: 1111 1011
    }else if (channel == 1) { 
      r = (1 << num) ^ r;
    }else if (channel == 2) { 
      g = (1 << num) ^ g;
    }else { 
      b = (1 << num) ^ b;
    }
    disguised.pixels[pcor] = color(r, b, g, a);
  } else if ((currentF >= 34) && (currentF < 38)) {//isolate
    
  } else if (currentF >= 38 && currentF < 62) {//more planes
    //switch color mode
    colorMode(HSB, 255);
    int channel = (currentF - 38) / 8;
    int num = Math.abs(7 - ((currentF - 38) % 8));
    if (channel == 0) { 
      h = (1 << num) ^ h;
    }else if (channel == 1) { 
      s = (1 << num) ^ s;
    }else{ 
      v = (1 << num) ^ v;
    }
    disguised.pixels[pcor] = color(h, s, v);
    //switch color mode back
    colorMode(RGB, 255);
  }
  disguised.updatePixels();
}

//if a key is pressed, then the following functions are done. 
void keyPressed(){
  if (key == 's') {
    //ori();
    disguised.save("secretImage.png");
  }
}
