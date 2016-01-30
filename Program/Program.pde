ArrayList<Generation> generations;
color testColor = color(0,255,0);

// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(800, 800);  // Size must be the first statement
  fill(255);
  //noStroke();
  stroke(255);     // Set line drawing color to white
  frameRate(30);

  generations = new ArrayList<Generation>();
  generations.add(new Generation(20, generations.size()));
  
  println("hue: " + hue(testColor));
  println("saturation: " + saturation(testColor));
  println("brightness: " + brightness(testColor));
}
// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() { 
  background(127);   // Clear the screen with a black background

pushMatrix();
  fill(testColor);
  //ellipse(50,50,50,50);
  popMatrix();

  for (Generation gen : generations)
  {
    gen.display();
  }
}

void mouseClicked()
{
  //test for fitness
  ///select the latest generation
  Generation latestGeneration = generations.get(generations.size() -1);
  latestGeneration.AssessFitness();
  
  //create offspring 
  generations.add(new Generation(latestGeneration.CreateOffspring(), generations.size()));
}