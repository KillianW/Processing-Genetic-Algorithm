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
}

class Chromosome
{
  Gene red, green, blue;
  Chromosome(Gene r, Gene g, Gene b)
  {
    red = r;
    green = g;
    blue = b;
  }
}

class Gene
{
  float value;
  Gene(float val)
  {
    value = val;
  }
}

class Gamete
{
  Chromosome chromosome;
}