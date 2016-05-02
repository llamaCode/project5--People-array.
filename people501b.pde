//// Project 5 sample

String title=  "Project 5 -- Array of people";
String subtitle=  "r to reset, q to quit, ? for help, SPACE for reports"; 
String author=  "Firstname Lastname";
float sidewalk=550;

boolean ascending=true, report=false, help=false, bird=false, cat=false;
String up="    --->", down="    <---";

int xReport=250, line=10, next=12;      // Line height.
float birdX=1, birdY=0;
float catX=1, catY=sidewalk+50;
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

Button buttons[]=  new Button[6];
int numButtons=3;


//// SETUP.
void setup() {
  size(1250, 600);
  sidewalk=  height-100;
  catY=sidewalk+50;
  reset();
  //
  int x=20, y=height-40, b=0;
  buttons[0]=  new Button( "    RESET ALL", x+120*b++, y );
  buttons[1]=  new Button( "Sort by HEIGHT", x+120*b++, y );
  buttons[2]=  new Button( "Sort by WIDTH", x+120*b++, y );
  buttons[3]=  new Button( "Sort by AGE", x+120*b++, y );
  buttons[4]=  new Button( up, x+120*b++, y );
  numButtons=5;
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
  lineup();
  animals();
  messages();
  if (help) {  
    help();
  }
  // Display reports OR buttons.
  if (report) reports();
  else {
    for (int j=0; j<numButtons; j++) {
      buttons[j].show();
    }
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
  String s="KEYS:";
  s += "\n    r to reset, q to quit";
  s += "\n    ? turns off help messages";
  s += "\n    SPACE BAR turns on reports.";
  s += "\n";
  s += "\nMOVE TO END (one Person only):";
  s += "\n  t/s:  tallest/shortest.";
  s += "\n  w/n:  widest/narrowest.";
  s += "\n  o/y  oldest/youngest.";
  s += "\n";
  s += "\nSORTING KEYS:  T/S, W/N, O/Y,";
  s += "\n  T/S:  Sort by height.";
  s += "\n  W/N:  Sort by width.";
  s += "\n  O/Y:  Sort by age.";
  s += "\n";
  s += "\nOTHER:";
  s += "\n  + makes everyone older.";
  s += "\n  b sends bird to top of tallest!";
  s += "\n  c sends cat to feet of fattest!";
  fill(0);
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

  xReport=250;


  // Height Report //
  //
  fill(200, 0, 0);
  jmax=  whereTall(people, many);
  jmin=  whereShort(people, many);
  total=0;
  for (int j=0; j<many; j++ ) { 
    total += people[j].h;
  }
  average=  total / many;
  compare( "Tallest", "Shortest", people, jmax, jmin, average );


  // Width Report //
  //
  fill(0, 150, 0);
  jmax=  whereWide(people, many);
  jmin=  whereNarrow(people, many);
  total=0;
  for (int j=0; j<many; j++ ) { 
    total += people[j].w;
  }
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
  textSize(12);
}
void compare( String max, String min, Person p[], int jmax, int jmin, float average ) {
  // Display two people. //
  int line=5;
  rectMode(CENTER);
  rect( xReport+75, 6+next*line, 150, 8 );
  rect( xReport+75, next*(line+22), 150, 8 );
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
  //
  // MOVE ONE //
  if (key == 't') tall( people, many );
  if (key == 's') shorty( people, many );
  if (key == 'w') swap( people, many-1, whereWide(people, many) );
  if (key == 'n') swap( people, many-1, whereNarrow(people, many) );
  if (key == 'o') swap( people, many-1, whereOld(people, many) );
  if (key == 'y') swap( people, many-1, whereYoung(people, many) );
  //
  // SORT //
  if (key == 'H') heightOrder( people, many );    // Order by height
  if (key == 'W') widthOrder( people, many );     // Order by width
  if (key == 'A') ageOrder( people, many );       // Order by age
  if (key == 'U') ascending=true;
  if (key == 'D') ascending=false;                // UP or DOWN
  //
  if (key == ' ') report=  ! report;
  if (key == 'h') help=  ! help;
  if (key == '?') help=  ! help;
  if (key == 'b') bird = ! bird;
  if (key == 'c') cat = ! cat;
  if (key == '+') older( people, many );
  //
  birdX=1;      // Reset bird (and cat).
  birdY=1;
  catX=1;
  catY=sidewalk+50;
}
void mousePressed() {
  int n=0;
  if ( buttons[n++].hit(mouseX, mouseY) ) reset();
  else if ( buttons[n++].hit(mouseX, mouseY) ) heightOrder( people, many );    // Order by height
  else if ( buttons[n++].hit(mouseX, mouseY) ) widthOrder( people, many );    // Order by width
  else if ( buttons[n++].hit(mouseX, mouseY) ) ageOrder( people, many );    // Order by age
  else if ( buttons[n++].hit(mouseX, mouseY) ) {
    ascending = ! ascending;
    buttons[4].name=  ascending ? up : down;
  }
  else {
    bird=  true;
    birdX=  mouseX;
    birdY=  mouseY;
  }
  catX=  0;
  catY= height-50;
}
void heightOrder( Person[] p, int m ) {
  if ( ascending ) 
    tallOrder( p, m ); 
  else 
    shortOrder( p, m ); 
}
void widthOrder( Person[] p, int m ) {
  if ( ascending ) wideOrder( p, m ); 
  else narrowOrder( p, m ); 
}
void ageOrder( Person[] p, int m) {
  if ( ascending ) oldOrder( p, m ); 
  else youngOrder( p, m ); 
}


// Make everybody older. //
void older( Person[] p, int m ) {
  for (int j=0; j<many; j++ ) {
    p[j].age++;
    if ( p[j].age > 100 ) p[j]=  new Person( p[j].name );    // New person; same name!
    if (p[j].age < 25) {
      p[j].h *= 1.05;        // Grow 5%
      p[j].w *= 1.02;        // Grow 3%
    } else if (p[j].age < 60) {
      // (No height change.)
      p[j].w *= 1.01;        // Gain weight 1%/yr.
    } else {
      p[j].h *= 0.99;       // Shrink 1/2%/yr
      p[j].w *= 1.02;        // Gain weight 2%/yr.
    }
  }
}

void animals() {
  // Bird flies to top of tallest.
  if (bird) {
    int k=  whereTall( people, many );
    fly( 20+k*50, sidewalk - 1.5*people[k].h );
  }
  // cat crawls to feet of fattest.
  if (cat) {
    int k=  whereWide( people, many );
    crawl( 20+k*50, sidewalk );
  }
  //
}
// Bird flies to tallest Person. //
void fly( float x, float y) {
  birdX += (x-birdX) / 30;
  birdY += (y-birdY) / 30;
  fill(255, 255, 0);
  ellipse( birdX, birdY, 30, 20);
  ellipse( birdX+20, birdY, 10, 10);
  // Animated wing flapping.
  float up=  birdX%30<10?-30:30;
  triangle( birdX-10, birdY, birdX+10, birdY, birdX, birdY-up );
}
// cat crawls to fattest Person. //
void crawl( float x, float y) {
  catX += (x-catX+30) / 150;
  catY += (y-catY) / 150;
  fill( 50, 20, 0);
  ellipse( catX, catY, 30, 15);
  ellipse( catX+20, catY, 12, 10);
  triangle( catX+16, catY-4, catX+20, catY-4, catX+18, catY-10 );
  triangle( catX+20, catY-4, catX+24, catY-4, catX+22, catY-10 );
  // Animated crawling.
  float leg=  catX%10<5 ? -10 : 10;
  for (int j=0; j<4; j++ ) {
    stroke( 50, 20, 0 );
    line( catX-12+j*8, catY+5, catX-12+leg+j*8, catY+10  );
  }
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
  int k=  whereShort( p, m );
  swap( p, k, m-1 );
}
void wide( Person[] p, int m ) {
  swap( p, whereWide( p, m ), m-1 );
}
void narrow( Person[] p, int m ) {
  swap( p, whereNarrow( p, m ), m-1 );
}
void old( Person[] p, int m ) {  
  swap( p, whereOld( p, m ), m-1 );
}
void young( Person[] p, int m ) {  
  swap( p, whereYoung( p, m ), m-1 );
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

// Find the index of oldest (or youngest).
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
// Move one to end, then shrink the array.
void tallOrder( Person q[], int m ) {
    for (int k=m; k>1; k--) {
      tall( q, k );                // Move tallest to end.
    }                              // Now, shrink the array!
    return;
}
void shortOrder( Person q[], int m ) {
  // Shortest-first.
    for (int k=m; k>1; k--) {
      shorty( q, k );
    }
}
void wideOrder( Person q[], int m ) {
    for (int k=m; k>1; k--) {
      wide( q, k );
    }
}
void narrowOrder( Person q[], int m ) {
    for (int k=m; k>1; k--) {
      narrow( q, k );
    }
}
void oldOrder( Person q[], int m ) {
    for (int k=m; k>1; k--) {
      old( q, k );
    }
}
void youngOrder( Person q[], int m ) {
    for (int k=m; k>1; k--) {
      young( q, k );
    }
}



//// CLASS DEFINITIONS ////
class Person {
  float w, h;
  float r, g, b;
  int age;
  boolean male=false;
  String name="?";
  //// CONSTRUCTORS ////
  Person( String who ) {
    name=  who;
    male=  random(100)<50;
    age=  int( random(1, 99) );
    if (age<20) {
      w=  random( 5+age*2, 5+age*2 );
      h=  random( 10+age*1, 10+age*2 )
        + (male ? 3 : 0);
    } else {
      w=  random( 20, 40 );
      h=  random( 50, 100 )
        + (male ? 15 : 0);
    }
    // Random colors.
    r=  random(200);
    g=  random(200);
    b=  random(200);
  }

  //// METHODS  ////
  // show() -- Display this object.
  void show( float x, float y ) {
    fill( r, g, b );
    rectMode( CENTER );
    if (male) {
      rect( x, y-h/2, w, h );
    }
    else{
      triangle( x-w/2, y, x+w/2, y, x, y-h );
      ellipse( x, y-h*3/4, w*3/4, h/2 );      
    }
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
    text( name, 2+x-w/2, 2+y-h*2/3 );
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
    if (male)
      triangle( x-hh/2, headY+3-hh/2, x+hh/2, headY+3-hh/2, x, headY-15-hh/2 );
    else
      rect( x, headY-3-hh/2, w*2/3, -hh/3 );
  }
  void eye( float x, float y ) {
    fill(255);
    ellipse( x, y, 8, 8 );
    fill(0, 0, 255);
    ellipse( x, y, 4, 4 );
  }
}


class Button {
  String name="";
  float x, y;
  float w=100, h=30;
  float r=255, g=255, b=255;
  Button( String name, float x, float y ) {
    this.name=  name;
    this.x=  x;
    this.y=  y;
  }
  void show() {
    fill(r, g, b);
    rectMode(CORNER);
    stroke(0);
    strokeWeight(4);
    rect( x, y, w, h );
    strokeWeight(1);
    fill( 0 );
    text( name, x+5, y+h*2/3 );
  }
  boolean hit( float xx, float yy ) {
    // Return true if xx,yy within this button.
    return (xx>x && xx<x+w && yy>y && yy<y+h);
  }
}
