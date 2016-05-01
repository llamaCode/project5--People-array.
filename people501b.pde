//// Project 5 sample

String title=  "Project 5 -- Array of people";
String subtitle=  "r to reset, q to quit, ? for help, space for report"; 
String author=  "Firstname Lastname";
float sidewalk;
int line=10, next=12;      // Line height.
int xReport;
boolean report=false, bird=false;

float birdX=1, birdY=0;
float cloudX=0, cloudY=100;
int cloudN=7;

String who[]= { 
  "Alpha", "Beta", "Gamma", "Delta", 
  "Epsilon", "Zeta", "Eta", "Theta", 
  "Iota", "Kappa", "Lambda", "Mu", 
  "Nu", "Xi", "Omicron", "Pi", 
  "Rho", "Sigma", "Tau", "Upsilon", 
  "Phi", "Chi", "Psi", "Omega"
};
String alt[]= { 
  "`™£¢∞§¶•ªº–≠«", "œ∑´†¥¨ˆπ“‘", "åß∂ƒ©˙∆˚¬…æ", "Ω≈ç√∫˜≤≥÷", 
  "`⁄€‹›ﬁﬂ‡°·‚—±»", "Œ„´‰ˇÁ¨ˆØ∏”’", "ÅÍÎÏ˝ÓÔÒÚÆ", "¸˛Ç◊ı˜Â¯˘¿"
};
//
int many=24;
Person[] people=  new Person[many];


//// SETUP.
void setup() {
  size(1250, 600);
  sidewalk=  height-100;
  reset();
}

void reset() {
  for (int j=0; j<many; j++ ) {
    people[j]=  new Person( who[j] );
  }
  //--  birdX=0;
}

//// NEXT FRAME
void draw() {
  background(200, 243, 252);
  scene();
  messages();
  if (key == '?') {  help(); return; }
  lineup();
  if (report) reports();
  //
  if (bird) {
    int k=  whereTall( people, many );
    fly( 20+k*50, sidewalk - 1.5*people[k].h );
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
  text( subtitle, 20+width/3, 50 );
  text( author, width*3/4, height-20 );
  textSize(12);
}
void help() {
  String s="KEYS:   r to reset, q to quit";
  s += "\n  t moves tallest to end; s moves shortest to end";
  s += "\n  w moves widest to end; n moves narrowest to end";
  s += "\n  Sorting:  o, O, w, W, a, A";
  //--s += "\n\n  b sends bird to top of tallest!";
  text( s, 15, 15 );
}


// Display all objects in array.
void lineup() {
  float x=50, y=sidewalk;
  fill( 50 );
  text( "W:\nH:", 2, sidewalk+35 );
  for (int j=0; j<many; j++ ) {
    people[j].show( x, y );
    x=  x + 50;
  }
}  

void reports() {
  // Report min, max, avg for height & width.
  int jmax, jmin;
  float total, average;
  
  xReport=200;

  // Height Report //
  //
  fill(200, 0, 0);
  jmax=  whereTall(people, many);
  jmin=  whereShort(people, many);
  total=0;
  for (int j=0; j<many; j++ ) { total += people[j].h; }
  average=  total / many;
  compare( "Tallest", "Shortest", people, jmax, jmin, average );


  // Width Report //
  //
  fill(0, 150, 0);
  jmax=  whereWide(people, many);
  jmin=  whereNarrow(people, many);
  total=0;
  for (int j=0; j<many; j++ ) { total += people[j].w; }
  average=  total / many;
    compare( "Widest", "Narrowest", people, jmax, jmin, average );


  // Age Report //
  //
  fill(0, 0, 150 );
  jmax=  whereOld(people, many);
  jmin=  whereYoung(people, many);
  total=0;
  for (int j=0; j<many; j++ ) {
    total += people[j].age;
  }
  average=  total / many;
  compare( "Oldest", "Youngest", people, jmax, jmin, average );


  // ALT //
  line=7;
  fill(200);
  textSize(20);
  for (int j=0; j<alt.length; j++) {
    text( alt[j], xReport, line*next+20*j );
  }
}
void compare( String max, String min, Person p[], int jmax, int jmin, float average ) {
  // Display two people. //
  int line=5;
  rect( xReport+75, 6+next*line, 150, 8 );
  rect( xReport+75, next*(line+21), 150, 8 );
  line=7;
  text( max +" is:  " + people[jmax].name, xReport, next*line++ );
  text( min +" is:  " + people[jmin].name, xReport, next*line++ );
  text( "Average H:  " + average, xReport, next*line++ );
  people[jmax].show( xReport+30, next+250 );
  people[jmin].show( xReport+90, next+250 );
  xReport += 200;
}


//// EVENTS:  keys, clicks
void keyPressed() {
  if (key == 'q') exit();
  if (key == 'r') reset();
  if (key == 's') shorty( people, many );
  if (key == 't') tall( people, many );
  //
  if (key == 'w') swap( people, many-1, whereWide(people, many) );
  if (key == 'n') swap( people, many-1, whereNarrow(people, many) );
  //
  if (key == 'o') order( people, many );    // Order by height
  if (key == 'O') sOrder( people, many );    // Order by height
  if (key == 'w') wOrder( people, many );    // Order by height
  if (key == 'a') ageOrder( people, many );    // Order by height
  //
  if (key == ' ') report=  ! report;
  if (key == 'b') bird = ! bird;
  if (key == '+') older( people, many );
  //
  birdX=1;
  birdY=1;
}

void older( Person[] p, int m ) {
  for (int j=0; j<many; j++ ) {
    p[j].age++;
    if (p[j].age < 25) {
      p[j].h *= 1.05;        // Grow 5%
      p[j].w *= 1.02;        // Grow 3%
    }
    else if (p[j].age < 60) {
      // (No height change.)
      p[j].w *= 1.01;        // Gain weight 1%/yr.
    } 
    else {
      p[j].h *= 0.99;       // Shrink 1/2%/yr
      p[j].w *= 1.02;        // Gain weight 2%/yr.
    }
  }
}


void fly( float x, float y) {
  birdX += (x-birdX) / 30;
  birdY += (y-birdY) / 30;
  fill(255, 255, 0);
  ellipse( birdX, birdY, 30, 20);
  ellipse( birdX+20, birdY, 10, 10);
  float up=  birdX%30<10?-30:30;
  triangle( birdX-10, birdY, birdX+10, birdY, birdX, birdY-up );
}


// Swap 2 elements of array.
void swap( Person[] p, int a, int b ) {
  Person tmp;
  tmp=  p[a];
  p[a]=  p[b];
  p[b]=  tmp;
}


// Move tallest (or shortest) to end
void tall( Person[] p, int m ) {
  int k=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].h > p[k].h ) k=j;
  }
  swap( p, k, m-1 );
}
void shorty( Person[] p, int m ) {
  int k=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].h < p[k].h ) k=j;
  }
  swap( p, k, m-1 );
}

void wide( Person[] p, int m ) {
  int k;
  k=  whereWide( p, m );
  swap( p, k, m-1 );
}
void old( Person[] p, int m ) {
  int k;
  k=  whereOld( p, m );
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
  int n=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].h < p[n].h ) n=j;
  }
  return n;
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
int whereOld( Person[] p, int m ) {
  int k=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].age > p[k].age ) k=j;
  }
  return k;
}
int whereYoung( Person[] p, int m ) {
  int k=0;
  for (int j=1; j<m; j++ ) {
    if ( p[j].age < p[k].age ) k=j;
  }
  return k;
}


// Sort entire array by height, weight, or age. //
void order( Person q[], int m ) {
  for (int k=m; k>1; k--) {
    tall( q, k );
  }
}
void sOrder( Person q[], int m ) {
  for (int k=m; k>1; k--) {
    shorty( q, k );
  }
}
void wOrder( Person q[], int m ) {
  for (int k=m; k>1; k--) {
    wide( q, k );
  }
}
void ageOrder( Person q[], int m ) {
  for (int k=m; k>1; k--) {
    old( q, k );
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
    age=  int( random(1, 99) );
    if (age<20) {
      w=  random( 5+age*2, 5+age*2 );
      h=  random( 10+age*1, 10+age*2 );
    } else {
      w=  random( 20, 50 );
      h=  random( 50, 100 );
    }
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
    stats( x, y );
  }
  void stats( float x, float y ) {
    // Name, w, h - underneath. //
    fill(r, g, b);
    text( name, x-20, y+20 );
    text( int(w), x-20, y+35 );
    text( int(h), x-20, y+50 );
    fill(255, 255, 0);              // Yellow on shirt.
    text( name, 2+x-w/2, y-h/2 );
    text( age, x-5, y+12-h/2 );
  }
  void head( float x, float headY, float hh ) {
    ellipse( x, headY, hh, hh );
    // Mouth & eyes.
    fill( 255, 0, 0 );
    rect( x, headY+5, 4+w/4, 6 );
    fill( 255, 255, 255 );
    rect( x, headY+6, w/4, 2 );
    eye( x-6, headY-6 );
    eye( x+6, headY-6 );
    // Hat
    fill( 255-r, 255-g, 255-b );
    triangle( x-hh/2, headY+3-hh/2, x+hh/2, headY+3-hh/2, x, headY-15-hh/2 );
  }
  void eye( float x, float y ) {
    fill(255);
    ellipse( x, y, 8, 8 );
    fill(0, 0, 255);
    ellipse( x, y, 4, 4 );
  }
}
