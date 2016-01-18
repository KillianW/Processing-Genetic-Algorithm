ArrayList<Generation> generations;
color testColor = color(0,255,0);

// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(640, 360);  // Size must be the first statement
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

  //select mates

  //create offspring
  generations.add(new Generation(20, generations.size()));
}

class Generation
{
  Blob[] blobs;
  Generation(int size, int rowNum)
  {
    blobs = new Blob[size];

    for (int i=0; i < blobs.length; i++)
    {
      int diameter = 25;
      int y = (rowNum * diameter) + diameter;
      int x = (i * diameter) + diameter;

      Gene r1, r2, g1, g2, b1, b2;
      r1 = new Gene(random(-255, 255));
      r2 = new Gene(random(-255, 255));
      g1 = new Gene(random(-255, 255));
      g2 = new Gene(random(-255, 255));
      b1 = new Gene(random(-255, 255));
      b2 = new Gene(random(-255, 255));

      Chromosome c1, c2;
      c1 = new Chromosome(r1, g1, b1);
      c2 = new Chromosome(r2, g2, b2);

      Blob b = new Blob(x, y, diameter, c1, c2);

      blobs[i] = b;
    }
  }

  void AssessFitness()
  {
    println("Checking fitness");


    //get the fitness value for each blob
    float lowestScore = 0;
    float highestScore = 0;
    for (int i=0; i < blobs.length; i++)
    {
      Blob b = blobs[i];
      //fitness is judged on the 'greeness' of the blob
      //greeness is based on the amount of green expressed minus the amount of red and blue (/2 to show a secondary preference for blue)
      //multiply by brightness value
      b.fitnessValue = (green(b.fillColor) -255) - (red(b.fillColor) + (blue(b.fillColor)/2));

      if (b.fitnessValue < lowestScore)
      {
        lowestScore = b.fitnessValue;
      }
      if (b.fitnessValue > highestScore)
      {
        highestScore = b.fitnessValue;
      }
    }
    println("lowest: " + lowestScore);
    println("highest: " + highestScore);
    println();

    //set the fitness rank
    for (int i=0; i < blobs.length; i++)
    {
      Blob b = blobs[i];
      b.fitnessRank = round(map(b.fitnessValue, lowestScore, highestScore, 1, blobs.length));
      b.strokeColor = round(map(b.fitnessValue, lowestScore, highestScore, 0, 255));
      b.strokeWeight = round(map(b.fitnessValue, lowestScore, highestScore, 0, 10));
      println(i + " - value: " + b.fitnessValue + ", rank: " + b.fitnessRank + ", stroke: "+ b.strokeColor);
    }
  }

  void display()
  {
    for (int i=0; i < blobs.length; i++)
    {
      blobs[i].update();
    }
  }
}