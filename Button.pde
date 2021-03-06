class Button 
{
 //variables
 float xloc;
 float yloc;
 String text2;
 int number;
 int r1 = 20;
 int r2 = 20;
 
 //the co-ordinates and the two different colors of the buttons are passed.
 Button(float x, float y, String text, int num)
 {
   xloc = x;
   yloc =y;
   text2 = text;
   number = num;
 }
 
 void run()
 {
   display();
 }//end run
  
  boolean over()
  {
    if(mouseX >=xloc && mouseX <=xloc+160 && mouseY >= yloc-20 && mouseY <= yloc+10)
    {
      return true;
    }//end if
    return false;
  }//end over()
  
 void display()
  {
    if(over()==true)
    {
    fill(yellow);
    }
    else
    fill(white);
    textFont(Digi_tech16);
    text(text2, xloc, yloc);
    if(mousePressed)
    {
      if(mouseX >=xloc && mouseX <=xloc+160 && mouseY >= yloc-20 && mouseY<= yloc+10)
      {
        if(number == 1)
        {
          state = LoadingScreen;
        }//end if
        if(number == 2)
        {
          state = instructions;
        }//end if
        if(number == 3)
        {
          state = options;
        }//end if
      }//end if
     }//end if
  }//end display()
}//end Button