boolean write;

void setup() {
  size(424, 426);
  //String l = key + ".png";
  write = false;

}

void keyPressed(){
  if (key == char(10)) {
      write = true;
      System.out.println("became true");
  }
  else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
       for (int i = 0; i < 20; i++){
         for (int j = 0; j < 20; j++) {
             color c = letter.pixels[j+i*423];
             //colors of text
             int red = (int)red(c);
             int green = (int)green(c);
             int blue = (int)blue(c); 
             
             //colors of image
             color o = newie.pixels[j+i*20]; 
             int oreo = (int)red(o);
             int ogreen = (int)green(o);
             int oblue = (int)blue(o);
             
             //bitwise or
             int nreo = oreo | red;
             int ngreen = ogreen | green;
             int nblue = oblue | blue;
             newie.pixels[i] = color(nreo, ngreen, nblue);
         }
       }
    }
}
