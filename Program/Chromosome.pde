class Chromosome
{
  Gene red, green, blue;
  Chromosome(Gene r, Gene g, Gene b)
  {
    red = r;
    green = g;
    blue = b;
  }
  
  Chromosome[] Meiosis()
  {
   Chromosome[] copies = new Chromosome[2];
   Gene[] redCopies = this.red.Meiosis();
   Gene[] greenCopies = this.green.Meiosis();
   Gene[] blueCopies = this.blue.Meiosis();
   
   copies[0] = new Chromosome(redCopies[0], greenCopies[0], blueCopies[0]);
   copies[1] = new Chromosome(redCopies[1], greenCopies[1], blueCopies[1]);
   
   return copies;
  }
}