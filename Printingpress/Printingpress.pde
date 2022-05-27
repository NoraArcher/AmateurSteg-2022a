void setup() {
  size(20,20);
  textSize(16);
  fill(0,0,0);
  char l;
  for (int i = 0; i < 26; i++){
    background(190, 190, 190);
    l = char(97+i);
    text(l,5,15);
    saveFrame(l+".png");
  }
  for (int i = 0; i < 26; i++){
    background(190, 190, 190);
    l = char(65+i);
    text(l,5,15);
    saveFrame(l+".png");
  }
}
