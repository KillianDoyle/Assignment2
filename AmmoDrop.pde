
class AmmoDrop 
{
 //variables
 float xloc;
 float[] ammoX = {getRandomX()};
 int[] ammoY = {0};
 int speed= 2;
 
 //the co-ordinates and the two different colors of the buttons are passed.
 AmmoDrop(float x)
 {
   xloc = x;
 }
 
 void run()
 {
   display();
 }//end run
  
  
  
 void display()
  {
    stroke(darkGreen);
    fill(darkGreen);
    for (int i=0; i<1; i++)
    {
      ammoY[i]= ammoY[i] + speed;
      rect(ammoX[i], ammoY[i]++, 40, 20);      //ammo box
      textFont(ArialBold14); 
      fill(yellow);
      text("AMMO", ammoX[i]+1, ammoY[i]+12);    //ammo text on box
      if(ammoX[i] > mouseX - 50 && ammoX[i] < mouseX + 50 && ammoY[i] > 530)      //if the player picks up ammo
      {
          reload.play();
          reload.rewind();
          ammo = ammo + 10;
          ammoX[i] = random(10, 580);
          ammoY[i] = -1200;
      }//end if
      if(ammo >= 25)        //maximum ammo is 25
      {
          ammo = 25;      
      }//end if
      if(ammoY[i] > 600)    //if ammo is missed
      {
        timer = millis();
        ammoY[i] = 0;
      } //end if  
    }//end for
  }//end display()
}//end Button