

class HomeButton 
{
 //variables
 int xloc;
 int yloc;
 
 //the co-ordinates and the two different colors of the buttons are passed.
 HomeButton(int x, int y)
 {
   xloc = x;
   yloc =y;
 }
 
 void run()
 {
   display();
 }//end run
  
 void display()
 {
  image(img, xloc, yloc, 50, 50);
  if(mousePressed && mouseX > xloc && mouseX < xloc+50 && mouseY > yloc && mouseY < yloc+50)
  {
    reset();
  }//end if
 }//end display()
}//end HomeButton