class Gene
{
  float value;
  Gene(float val)
  {
    value = val;
  }
  
  Gene[] Meiosis()
  {
    Gene[] copies = new Gene[2];
    copies[0] = new Gene(copyWithRandomMutation(this.value));
    copies[1] = new Gene(copyWithRandomMutation(this.value));
    
    return copies;
  }
  
  float copyWithRandomMutation(float inputValue)
  {
   int random1 = (int)random(1,10);
   int random2 = (int)random(1,10);
   
   if(random1 == random2)
   {
    return inputValue * -1; 
   }
   else
   {
    return inputValue; 
   }
  }
}