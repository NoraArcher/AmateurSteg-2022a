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

import java.util.*
void setup() {
    int i = new Integer.parseInt(args[0]);
    int j = new Integer.parseInt(args[1]);
    size(i, j); //should we have the user input the pixel size or should we create a method to automatically detect the pixel size? 
    PImage img = loadImage("YourImage.png");
    img.loadPixels();
}