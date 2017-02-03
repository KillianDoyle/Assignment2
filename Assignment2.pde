//Program States
int InitialState = 0;
int LoadingScreen = 1;
int test1 = 2;
int test2 = 3;
int gameFinish = 4;
int state = test1;

void setup()
{
  size(600, 600, P2D);
  frameRate(85);
  smooth();
  background(0);
}//end setup()

void draw()
{

  if(state == InitialState)
  {
    background(0);
    buttons();
    text(gameOver, 100,100);
  }//end if
  
  else if(state == LoadingScreen)
  {
    background(0);
    Loading();
  }//end else if
  
  else if(state == test1)
  {
    test1();
  }//end else if
  
  
  else if(state == test2)
  {
    test2();
  }//end else if
  
  else if(state == gameFinish)
  {
    gameFinish();
  }//end else if
}//end draw()


void test1()
{
     //Game Style
    background (0);
    fill(blue);
    stroke (blue);
    triangle(mouseX-8, 540, mouseX+8, 540, mouseX, 565);
    // display score, ammo and magazine
    fill(white);
    stroke (white);
    textAlign(CENTER);
    textSize(16);
    text("Score: " + score_shooter, 40, 585);
    text("Ammo: " + ammo, 550, 585);
    for (int i=0; i<ammo; i++)
    {
      rect( 580, (550)-i*10, 6, 8);    //draws blocks to reprisent magazine/ ammo
    }//end for
      
    //flashing warning message
    if (millis() - now > delay)    
    { 
      flash = !flash; //change flag
      now = millis(); //reset counter
    }//end if
    
    if(ammo < 10 && ammo > 0)
    {
       fill(red);
       textSize(20);
       if (flash)
       {
           text("AMMO LOW", 290, height/2);     
       }
    }
    
    if(ammo == 0)
    {
       fill(red);
       textSize(20);
       if (flash)
       {
           text("AMMO EMPTY", 290, height/2);     
       }
    }
    
    if(fire)
    {
      cannon(mouseX);
      fire = false;
    }//end if
    
    ballFalling();
    
    if (millis() - timer >= 10000) 
    {
      ammoFalling();
    }
   
    
    for (int i=0; i< 5; i++)
    {
       if(bally[i] > 600)
       {
         gameOver = 1;
         bally[i]=0;    //reset bally to allow game to place again
       }//end if
       
       if (gameOver == 1)
       {
         state = gameFinish;
       }//end if
       
    }//end for
}//end test1()


void test2()
{
  background(0);
  fill(255);
  stroke(255);
  textSize(16);
  text("These are the instructions for the game..... blah blah blah", 40, height/2);
}//end test2()