////  People objects (different widths & heights)
//// (Faking it with bad arrays.)

float horizon;
Person a, b, c, d, e, f, g, h;
Person[] people= {
  a, b, c, d, e, f, g, h
};
//// Fake the array. ////

String who[]= { 
  "Alpha", "Beta", "Gamma", "Delta", 
  "Epsilon", "Zeta", "Eta", "Theta", 
  "Iota", "Kappa", "Lambda", "Mu", 
  "Nu", "Xi", "Omicron", "Pi", 
  "Rho", "Sigma", "Tau", "Upsilon", 
  "Phi", "Chi", "Psi", "Omega"
};


void setup() {
  //// Setup:  window size, instantiate objects.
  size( 640, 480 );
  horizon=  height*3/4;
  reset();
}
void reset() {
  //// Create several people
  a=  new Person( 255, 0, 0, who[0] );
  b=  new Person( 0, 200, 0, who[1] );
  c=  new Person( 0, 0, 255, who[2] );
  d=  new Person( 255, 0, 255, who[3] );
  e=  new Person( 255, 127, 0, who[4] );
  f=  new Person( 0, 200, 200, who[5] );
  g=  new Person( 127, 0, 0, who[6] );
  h=  new Person( 200, 200, 0, who[7] );
  // Fake the array. //
  fill( people );
}


//// Next frame:  display all people & statistics.
void draw() {
  background(150, 200, 250);
  // Sidewalk
  fill( 220, 220, 220 );
  rect( 0, horizon, width, height-horizon );
  // Instructions.
  fill(0);
  text( "r to reset, randomly.", 10, 12 );
  text( "t to move tallest to end.", 10, 24 );
  text( "f to move fattest to end.", 10, 36 );
  //  Display them, 100 pixels apart.  
  a.show( 50, horizon );
  b.show( 100, horizon );
  c.show( 150, horizon );
  d.show( 200, horizon );
  e.show( 250, horizon );
  f.show( 300, horizon );
  g.show( 350, horizon );
  h.show( 400, horizon );
  //
  stat();
}
void stat() {
  //// Statistics
  float sum;
  float many=4;
  float x=width*2/3, y=100;
  fill(0);
  sum=  a.h + b.h + c.h + d.h;
  text( "Average height is "+int(sum/many), x, y );
  sum=  a.pounds() + b.pounds() + c.pounds() + d.pounds();
  text( "Average weight is "+int(sum/many), x, y+20 );
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
  Person tmp=  h;          // Save end person in tmp.
  if (a.h>b.h && a.h>c.h && a.h>d.h && a.h>e.h && a.h>f.h && a.h>g.h && a.h>h.h ) {
    h=  a;
    a= tmp;
  }
  if (b.h>c.h && b.h>d.h && b.h>e.h && b.h>f.h && b.h>g.h && b.h>h.h ) {
    h=  b;
    b= tmp;
  }
  if (c.h>d.h && c.h>e.h && c.h>f.h && c.h>g.h && c.h>h.h ) {
    h=  c;
    c= tmp;
  }
  if (d.h>e.h && d.h>f.h && d.h>g.h && d.h>h.h ) {
    h=  d;
    d= tmp;
  }
  if (e.h>f.h && e.h>g.h && e.h>h.h ) {
    h=  e;
    e= tmp;
  }
  if (f.h>g.h && f.h>h.h ) {
    h=  f;
    f= tmp;
  }
  if (g.h>h.h ) {
    h=  g;
    g= tmp;
  }
}

//// Move the fattest one to the end.
void fattest() {
  Person tmp=  h;          // Save end person in tmp.
  if (a.w>b.w && a.w>c.w && a.w>d.w && a.w>e.w && a.w>f.w && a.w>g.w && a.w>h.w ) {
    h=  a;
    a= tmp;
  }
  if (b.w>c.w && b.w>d.w && b.w>e.w && b.w>f.w && b.w>g.w && b.w>h.w ) {
    h=  b;
    b= tmp;
  }
  if (c.w>d.w && c.w>e.w && c.w>f.w && c.w>g.w && c.w>h.w ) {
    h=  c;
    c= tmp;
  }
  if (d.w>e.w && d.w>f.w && d.w>g.w && d.w>h.w ) {
    h=  d;
    d= tmp;
  }
  if (e.w>f.w && e.w>g.w && e.w>h.w ) {
    h=  e;
    e= tmp;
  }
  if (f.w>g.w && f.w>h.w ) {
    h=  f;
    f= tmp;
  }
  if (g.w>h.w ) {
    h=  g;
    g= tmp;
  }
}


//// CLASS DEFINITIONS ////
class Person {
  float w, h;
  float r, g, b;
  String name="?";
  //// CONSTRUCTORS ////
  Person( int r, int g, int b, String who ) {
    // 3-argument constructor:  colors + Random w, h //// 
    this.r=  r;   
    this.g=  g;   
    this.b=  b;
    this.w=  random(20, 40);
    this.h=  random(50, 150);
    name=  who;
  }
  //// METHODS ////
  void show( float x, float y) {
    fill(r, g, b);
    rectMode(CORNER);
    rect( x, y, w, -h );
    //
    text ( name, x, y+20);
    int feet, inches;
    feet=  int( h / 12 );
    inches=  int( h % 12 );
    text ( feet+"' " + inches+"''", x, y+35);
    float pounds=  (h * w * w) / 500 ;
    text ( int(pounds())+"#", x, y+50);
  } 
  float pounds() {
    return (h * w * w) / 500 ;
  }
}  





// DO NOT COPY ANY OF HIS UNREADABLE CODE!!!! //
void fill(Person[]p) {
  int i=0;  // DO NOT COPY THIS! //
  p[i++]=a;  p[i++]=b;  p[i++]=c;  p[i++]=d    // DO NOT COPY THIS! //
  ;;
  p[i++]=e;  p[i++]=f;  p[i++]=g;  ;  p[i++]=h;
}    // DO NOT COPY THIS! //
// DO NOT COPY ANY OF HIS UNREADABLE CODE!!!! //
