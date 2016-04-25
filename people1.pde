//// People objects (different widths & heights)
//// (Without arrays.)

Person a, b, c, d;
float horizon;
String who[]=  { "Alpha", "Beta", "Gamma", "Delta",
    "Epsilon", "Zeta", "Eta", "Theta",
    "Iota", "Kappa", "Lambda", "Mu",
    "Nu", "Xi", "Omicron", "Pi",
    "Rho", "Sigma", "Tau", "Upsilon",
    "Phi", "Chi", "Psi", "Omega" };

void setup() {
  //// Setup:  window size, instantiate objects.
  size( 640, 480 );
  horizon=  height*3/4;
  reset();
}
void reset() {
  //// Create several people
  a=  new Person( 255,0,0, who[0] );
  b=  new Person( 0,200,0, who[1] );
  c=  new Person( 0,0,255, who[2] );
  d=  new Person( 255,0,255, who[3] );
}
//// Next frame:  display all people & statistics.
void draw() {
  background(150,200,250);
  // Sidewalk
  fill( 220, 220, 220 );
  rect( 0,horizon, width,height-horizon );
  // Instructions.
  fill(0);
  text( "r to reset, randomly.", 10,12 );
  text( "t to move tallest to end.", 10,24 );
  text( "f to move fattest to end.", 10,36 );
  //  Display them, 100 pixels apart.  
  a.show( 50, horizon );
  b.show( 100, horizon );
  c.show( 150, horizon );
  d.show( 200, horizon );
  //
  stat();
}
void stat() {
  //// Statistics
  float sum;
  float many=4;
  fill(0);
  sum=  a.h + b.h + c.h + d.h;
  text( "Average height is "+int(sum/many), 10,height-40 );
  sum=  a.pounds() + b.pounds() + c.pounds() + d.pounds();
  text( "Average weight is "+int(sum/many), 10,height-20 );
}

//// EVENT HANDLERS ////
void keyPressed() {
  // Handle keys.
  if (key == 'q') exit();
  if (key == 'r') reset();
  if (key == 't') tallest();
  if (key == 'f') fattest();
}
//// Move the tallest one to the end.
void tallest() {
  if (a.h>b.h && a.h>c.h && a.h>d.h) {
    Person tmp=  a;    // a is tallest -- moe to end.
    a= d;
    d= tmp;
  }  
  if (b.h>c.h && b.h>d.h) {
    Person tmp=  b;
    b= d;
    d= tmp;
  }  
  if (c.h>d.h) {
    Person tmp=  c;
    c= d;
    d=  tmp;
  }  
}
// Move the fattest one to the end.
void fattest() {
  Person tmp=  d;
  if (a.pounds()>b.pounds() && a.pounds()>c.pounds() && a.pounds()>d.pounds()) {
    d=  a;
    a= tmp;
  }  
  if (b.pounds()>c.pounds() && b.pounds()>d.pounds()) {
    d=  b;
    b= tmp;
  }  
  if (c.pounds()>d.pounds()) {
    d=  c;
    c=  tmp;
  }  
}


//// CLASS DEFINITIONS ////
class Person {
  float w,h;
  int r,g,b;
  String name="?";
  //// CONSTRUCTORS ////
  Person( int r, int g, int b, String who ) {
    // 3-argument constructor:  colors + Random w, h //// 
   this.r=  r;   this.g=  g;   this.b=  b;
   this.w=  random(20,40);
   this.h=  random(50,150);
   name=  who;
  }
  //// METHODS ////
  void show( float x, float y) {
    fill(r,g,b);
    rectMode(CORNER);
    rect( x,y, w,-h );
    //
    text ( name, x,y+20);
    int feet, inches;
    feet=  int( h / 12 );
    inches=  int( h % 12 );
    text ( feet+"' " + inches+"''", x,y+35);
    float pounds=  (h * w * w) / 500 ;
    text ( int(pounds())+"#", x,y+50);
  } 
  float pounds() {
     return (h * w * w) / 500 ;
  }
}  
