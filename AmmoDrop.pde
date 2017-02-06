
class AmmoDrop 
{
 //variables
 float xloc;
 float[] ammox = {getRandomX()};
 int[] ammoy = {0};
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
      ammoy[i]= ammoy[i] + speed;
      rect(ammox[i], ammoy[i]++, 40, 20);      //ammo box
      textFont(ArialBold14); 
      fill(yellow);
      text("AMMO", ammox[i]+1, ammoy[i]+12);    //ammo text on box
      if(ammox[i] > mouseX - 50 && ammox[i] < mouseX + 50 && ammoy[i] > 530)      //if the player picks up ammo
      {
          reload.play();
          reload.rewind();
          ammo = ammo + 10;
          ammox[i] = random(10, 580);
          ammoy[i] = -1200;
      }//end if
      
      if(ammo >= 25)        //maximum ammo is 25
      {
          ammo = 25;      
      }
      
      if(ammoy[i]>600)    //if ammo is missed
      {
        timer = millis();
        ammoy[i]=0;
      } //end if  
    }//end for
  }//end display()
}//end Button