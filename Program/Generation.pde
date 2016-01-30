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
  
  Generation(Blob[] bs, int rowNum)
  {
    println("next gen");
    blobs = bs; //<>//
    println(blobs.length);
    
    for (int i=0; i < blobs.length; i++)
    {
      println(i);
      int diameter = 25;
      int y = (rowNum * diameter) + diameter;
      int x = (i * diameter) + diameter;

      blobs[i].centerX = x;
      blobs[i].centerY = y;
      blobs[i].displaySize = diameter;
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
      
      //println(i + " - value: " + b.fitnessValue + ", rank: " + b.fitnessRank + ", stroke: "+ b.strokeColor);
    }
        //<>//
    println("lowest: " + lowestScore);
    println("highest: " + highestScore);
    println();
    

    //set the fitness rank
    for (int i=0; i < blobs.length; i++)
    {
      Blob b = blobs[i];
      //b.fitnessRank = round(map(b.fitnessValue, lowestScore, highestScore, 1, blobs.length));
      b.strokeColor = round(map(b.fitnessValue, lowestScore, highestScore, 0, 255));
      b.strokeWeight = round(map(b.fitnessValue, lowestScore, highestScore, 0, 10));
      
    }
    
    Arrays.sort(blobs, new BlobComparatorDESC());
    for (int i=0; i < blobs.length; i++)
    {
      Blob b = blobs[i];
      println(i + " - value: " + b.fitnessValue + ", rank: " + b.fitnessRank + ", stroke: "+ b.strokeColor);
    }
  }
  
  Blob[] CreateOffspring()
  {
    println("Selecting");
    //pick the top n individuals
    Blob[] matingGroup = (Blob[])subset(blobs, 0, blobs.length/2);
        
    Blob[] newGen = new Blob[blobs.length];
    
    println("Mating");
    println(matingGroup.length);
    for(int i = 0; i < matingGroup.length; i = i+2)
    {
      println("mating pair; " + i);
      if(i <= matingGroup.length -2)
      {
        Blob male = matingGroup[i];
        Blob female = matingGroup[i+1];
        
        Gamete[] maleGametes = male.produceGametes();
        int maleIndex1 = (int)random(0, maleGametes.length);
        int maleIndex2 = maleIndex1;
        println(maleIndex1);
        while(maleIndex2 == maleIndex1)
        {
         maleIndex2 = (int)random(0, maleGametes.length);
        }
        println(maleIndex2);
        Gamete[] femaleGametes = female.produceGametes();
        int femaleIndex1 = (int)random(0, femaleGametes.length);
        int femaleIndex2 = femaleIndex1;
        
        while(femaleIndex2 == femaleIndex1)
        {
         femaleIndex2 = (int)random(0, femaleGametes.length);
        }
        
        Blob child1 = new Blob(0,0,0, maleGametes[maleIndex1].chromosome, femaleGametes[femaleIndex1].chromosome);
        Blob child2 = new Blob(0,0,0, maleGametes[maleIndex2].chromosome, femaleGametes[femaleIndex2].chromosome);
        Blob child3 = new Blob(0,0,0, maleGametes[maleIndex1].chromosome, femaleGametes[femaleIndex2].chromosome);
        Blob child4 = new Blob(0,0,0, maleGametes[maleIndex2].chromosome, femaleGametes[femaleIndex1].chromosome);
        
        newGen[i*2] = child1;
        newGen[(i*2)+1] = child2;
        newGen[(i*2)+2] = child3;
        newGen[(i*2)+3] = child4;
        
      }
    }
    println(newGen.length);
    for (int i=0; i < newGen.length; i++)
    {
      Blob b = newGen[i];
      println(i + " - value: " + b.fitnessValue + ", rank: " + b.fitnessRank + ", stroke: "+ b.strokeColor);
    }
    
    return newGen;
  }

  void display()
  {
    for (int i=0; i < blobs.length; i++)
    {
      blobs[i].update();
    }
  }
}