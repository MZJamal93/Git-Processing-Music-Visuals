
import processing.sound.*;

AudioIn sample; //declare audio input to variable sample
Amplitude amp; //declare amplitude to variable amp
Waveform waveform; //declare waveform to variable waveform
PImage bg; //declare image to bg
int samples = 150; //number of samples read from input

float a;                 // Angle of rotation
float offset = PI/15.0;  // Angle offset between boxes
int num = 100;            // Number of shapes

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D, 1);

  //background(bg);
  colorMode(HSB);

  bg = loadImage("test.jpg");
  //load background image into variable bg
  bg.resize(width, height);
  //resize background
  frameRate(60);
  sample = new AudioIn(this, 0);
  //sample = new SoundFile(this, "mayajanediehard.wav");
  //sample.loop();

  // Create the Waveform analyzer and connect the playing soundfile to it.
  waveform = new Waveform(this, samples);
  waveform.input(sample);

  sample.start();
  // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);

  amp.input(sample);
}


void draw() {

  ambientLight(random(10, 39), 220, 110);
  
    background(bg);

  //lights();
  //noStroke();
  noFill();
  amp.analyze();
  waveform.analyze();
  translate(width/2, height/2);

  for (int i = 5; i < num; i=i+1) {
    float wd = waveform.data[i];
    float x = amp.analyze();
    pushMatrix();
    //fill(0, 0, 0);
    stroke(random(224, 315), 100, 250);
    strokeWeight((2000 * wd) * x);
    //hint(ENABLE_STROKE_PERSPECTIVE);
    rotateY(a - offset * (i));
    rotateX(a*2 + offset * (i));
    rotateZ(a/2 + offset * (wd));
    box(400);
    popMatrix();
    //fill(50, 200, 20);
  }

  a += 0.01;
}
