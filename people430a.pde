//// Project 5 sample

String title=  "Project 5";
String author=  "Firstname Lastname";
float sidewalk;

String who[]= { 
  "Alpha", "Beta", "Gamma", "Delta", 
  "Epsilon", "Zeta", "Eta", "Theta", 
  "Iota", "Kappa", "Lambda", "Mu", 
  "Nu", "Xi", "Omicron", "Pi", 
  "Rho", "Sigma", "Tau", "Upsilon", 
  "Phi", "Chi", "Psi", "Omega"
};
String alt[]= { 
  "`™£¢∞§¶•ªº–≠«",  "œ∑´†¥¨ˆπ“‘",  "åß∂ƒ©˙∆˚¬…æ",  "Ω≈ç√∫˜≤≥÷",
  "`⁄€‹›ﬁﬂ‡°·‚—±»",  "Œ„´‰ˇÁ¨ˆØ∏”’",  "ÅÍÎÏ˝ÓÔÒÚÆ",  "¸˛Ç◊ı˜Â¯˘¿"
};
//
int many=16;
Person[] people=  new Person[many];

//// SETUP.
void setup() {
  size(800, 600);
  sidewalk=  height-100;
  reset();
}

void reset() {
  for (int j=0; j<many; j++ ) {
    people[j]=  new Person( who[j] );
  }
}

//// NEXT FRAME
void draw() {
  background(200, 243, 252);
  scene();
  messages();
  lineup();
  reports();
  //
  fill(200);
  textSize(20);
  for (int j=0; j<alt.length; j++) {
    text( alt[j], 50, 200+20*j );
  }
}

void scene() {
  noStroke();
  fill(214, 216, 216);
  rectMode(CORNERS);
  rect(0, sidewalk, width, height);
}
void messages() {
  fill(0);
  textSize(24);
  text( title, width/3, 30 );
  textSize(16);
  text( author, width*3/4, height-20 );
  textSize(12);
  help();
}
void help() {
  String s="KEYS:\n  r to reset, q to quit";
  s += "\n  t moves tallest to end; s moves shortest to end";
  s += "\n  w moves widest to end; n moves narrowest to end";
  s += "\n\n  b sends bird to top of tallest!";
  text( s, 50, 50 );
}


// Display all objects in array.
void lineup() {
  float x=30, y=sidewalk;
  for (int j=0; j<many; j++ ) {
    people[j].show( x, y );
    x=  x + 50;
  }
}  

void reports() {
  // Report min, max, avg for height & width.
  int x=width/2, y=50, line=5, next=12;        // Text position.
  int jmax, jmin;
  float total, average;
  jmax=  whereTall(people,many);
  jmin=  whereShort(people,many);
  total=0;
  for (int j=0; j<many; j++ ) {
    total += people[j].h;
  }
  average=  total / many;
  fill(0);
  text( "Tallest is:  " + people[jmax].name,  x, next*line++ );
  text( "Shortest is: " + people[jmin].name,  x, next*line++ );
  text( "Average H:  " + average,  x, next*line++ );
  //
  people[jmin].show( x+30, next+250 );
  people[jmax].show( x+90, next+250 );
  //
  x += 200;        // Next column
  y=  50;
  line=5;
  jmax=  whereWide(people,many);
  jmin=  whereNarrow(people,many);
  total=0;
  for (int j=0; j<many; j++ ) {
    total += people[j].w;
  }
  average=  total / many;
  fill(0);
  text( "Widest is:   " + people[jmax].name,  x, next*line++ );
  text( "Narrowest is:" + people[jmin].name,  x, next*line++ );
  text( "Average W:  " + average,  x, next*line++ );
  people[jmin].show( x+30, next+250 );
  people[jmax].show( x+90, next+250 );
}

void shorty( Person[] p, int m ) {
  int k;
  k=  whereShort( p, m );
  swap( p, k, m-1 );
}

//// EVENTS:  keys, clicks
void keyPressed() {
  if (key == 'q') exit();
  if (key == 'r') reset();
  if (key == 's') shorty( people, many );
  if (key == 't') tall( people, many );
  //
  if (key == 'w') swap( people, many-1, whereWide(people,many) );
  if (key == 'n') swap( people, many-1, whereNarrow(people,many) );
  //
  if (key == 'o') order( people, many );
}


// Move tallest (or shortest) to end
void tall( Person[] p, int m ) {
  println( "tall "+ m );
  int k;
  k=  whereTall( p, m );
  println( "swap "+ k +","+ (m-1) );
  swap( p, k, m-1 );
}
// Find the index of tallest (or shortest).
int whereTall( Person[] p, int m ) {
  int iTallest=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].h > p[iTallest].h ) iTallest=j;
  }
  return iTallest;
}
int whereShort( Person[] p, int m ) {
  int iShortest=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].h < p[iShortest].h ) iShortest=j;
  }
  return iShortest;
}
// Swap 2 elements of array.
void swap( Person[] p, int a, int b ) {
  Person tmp;
  tmp=  p[a];
  p[a]=  p[b];
  p[b]=  tmp;
}


// Find the index of wideest (or narrowest).
int whereWide( Person[] p, int m ) {
  int k=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].w > p[k].w ) k=j;
  }
  return k;
}
int whereNarrow( Person[] p, int m ) {
  int i=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].w < p[i].w ) i=j;
  }
  return i;
}


// Sort entire array by height. //
void order( Person q[], int m ) {
  for (int k=m; k>1; k--) {
    println( "*** k="+k );
    tall( q, k );
  }
}

//// CLASS DEFINITIONS ////
class Person {
  float w, h;
  float r, g, b;
  int age;
  String name="?";
  //// CONSTRUCTORS ////
  Person( String who ) {
    w=  random( 20, 50 );
    h=  random( 50, 100 );
    age=  int( random(99) );
    // Random colors.
    r=  random(200);
    g=  random(200);
    b=  random(200);
    name=  who;
  }

  //// METHODS  ////
  // show() -- Display this object.
  void show( float x, float y ) {
    fill( r, g, b );
    rectMode( CENTER );
    rect( x, y-h/2, w, h );
    float shoulder=  y-h;
    float hh=  h/3;        // Head height.
    head( x, shoulder-hh/2, hh );
    // Name.
    fill(r,g,b);
    text( name, x-20, y+20 );
    text( int(w), x-20, y+32 );
    text( int(h), x-20, y+44 );
    fill(255,255,0);
    text( name, 2+x-w/2, y-h/2 );
    text( age, x-5, y+12-h/2 );
  }
  void head( float x, float headY, float hh ) {
    ellipse( x, headY, hh, hh );
    // Mouth & eyes.
    fill( 255,0,0 );
    rect( x, headY+5, 4+w/4, 6 );
    fill( 255,255,255 );
    rect( x, headY+6, w/4, 2 );
    eye( x-6, headY-6 );
    eye( x+6, headY-6 );
    // Hat
    fill( 255-r, 255-g, 255-b );
    triangle( x-hh/2,headY+3-hh/2, x+hh/2,headY+3-hh/2, x,headY-15-hh/2 );
  }
  void eye( float x, float y ) {
    fill(255);
    ellipse( x, y, 8, 8 );
    fill(0, 0, 255);
    ellipse( x, y, 4, 4 );
  }
}
