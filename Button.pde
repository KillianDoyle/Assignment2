class Button 
{
 //variables
 float xloc;
 float yloc;
 int fillC;
 int fillS;
 int r1 = 20;
 int r2 = 20;
 
 //the co-ordinates and the two different colors of the buttons are passed.
 Button(float x, float y, int Cfill, int Sfill )
 {
   xloc = x;
   yloc =y;
   fillC = Cfill;
   fillS = Sfill;
 }
 
 void run()
 {
   display();
 }//end run
  
 void display()
  {
    stroke(fillS);
    fill(fillC);
    ellipse(xloc, yloc, r1, r2);
    if(mousePressed)
    {
      if(mouseX >=xloc-r1 && mouseX <=xloc+r1 && mouseY >= yloc-r2 && mouseY <= yloc+r2)
      {
        if(fillC==darkBlue)
        {
          state = LoadingScreen;
        }//end if
        
        if(fillC==darkRed)
        {
          state= test2;
        }//end if
      }//end if
     }//end if
  }//end display()
}//end Button