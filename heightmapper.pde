int cols, rows;
int w, h;
//Parameters:
int scl = 3; // Basically fidelity. Lower numbers means more details, but lower performance.
float midlevel = 1.2; // If map is above view, make number bigger. If below, make number smaller. Kinda fiddly.
int depth = 500; //Range of values available, from -depth to depth. Change to affect how high highs are, and how low lows are.

float spin = 0;
float[][] terrain;

void setup(){
  size(1000, 1000, P3D);
  colorMode(RGB, 255);
  
  PImage img = loadImage("tre.png"); //Image file to load.
  img.loadPixels();
  
  frameRate(24);
  
  w = img.width;
  h = img.height;
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  
  for (int y = 0; y < rows; y++){
    for (int x = 0; x < cols; x++){
      color currPx = img.get(x, y);
      float currBr = brightness(currPx);
      terrain[x][y] = map(currBr, 0, 255, -depth, depth);
    }
  }
}

void draw(){
  background(0);
  stroke(255);
  noFill(); 
  spin += 0.05; // Causes the spinning
  
  translate(width/2, height/2);
  rotateX(PI/3);
  rotateZ(spin);
  translate(-w/2, -h/2);
  
  for (int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++){
      vertex(x*scl, y*scl, (terrain[x][y] + (depth / midlevel)));
      vertex(x*scl, (y + 1) * scl, (terrain[x][y+1] + (depth / midlevel)));
    }
    endShape();
  }
}
