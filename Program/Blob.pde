import java.util.*;

class Blob
{
  float centerX, centerY, displaySize;
  Chromosome chromo1, chromo2;
  int strokeColor = 0;
  int strokeWeight = 1;
  float fitnessValue = 0;
  float fitnessRank = 0;
  color fillColor;

  Blob(float x, float y, float size, Chromosome c1, Chromosome c2)
  {
    centerX = x;
    centerY = y;
    displaySize = size;
    chromo1 = c1;
    chromo2 = c2;
    
    fillColor = this.GetColor();
  }

  color GetColor()
  {
    //get the expressed value as an average of the encoded genetic values - cap the lower limit to 0.
    float redVal = this.GetExpressedValue('r');
    float greenVal = this.GetExpressedValue('g');
    float blueVal = this.GetExpressedValue('b');
    return color(redVal, greenVal, blueVal);
  }

  float GetExpressedValue(char gene)
  {
    float returnValue = 0;
    switch(gene)
    {
    case 'r':
      returnValue = max((this.chromo1.red.value + this.chromo2.red.value)/2, 0);
      break;
    case 'g':
      returnValue = max((this.chromo1.green.value + this.chromo2.green.value)/2, 0);
      break;
    case 'b':
      returnValue = max((this.chromo1.blue.value + this.chromo2.blue.value)/2, 0);
      break;
    }
    return returnValue;
  }
  
  void Highlight()
  {
    this.strokeColor = 255;
    this.strokeWeight = 40;
  }

  void update()
  {
    pushMatrix();
    fill(this.fillColor);
    strokeWeight(this.strokeWeight);
    stroke(this.strokeColor);
    
    ellipse(centerX, centerY, displaySize, displaySize);
    popMatrix();
  }
  
  Gamete[] produceGametes()
  {
    Gamete[] gametes = new Gamete[4];
    Chromosome[] c1Copies = chromo1.Meiosis();
    Chromosome[] c2Copies = chromo2.Meiosis();
    
    gametes[0] = new Gamete(c1Copies[0]);
    gametes[1] = new Gamete(c1Copies[1]);
    gametes[2] = new Gamete(c2Copies[0]);
    gametes[3] = new Gamete(c2Copies[1]);
    
    return gametes;
  }
}

class BlobComparatorASC implements Comparator
{
  int compare(Object o1, Object o2)
  {
    Float r1 = ((Blob) o1).fitnessValue;
    Float r2 = ((Blob) o2).fitnessValue;
    return r1.compareTo(r2);
  }
}

class BlobComparatorDESC implements Comparator
{
  int compare(Object o1, Object o2)
  {
    Float r1 = ((Blob) o1).fitnessValue;
    Float r2 = ((Blob) o2).fitnessValue;
    return -1 * r1.compareTo(r2);
  }
}