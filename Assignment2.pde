//Program States
int InitialState = 0;
int LoadingScreen = 1;
int test1 = 2;
int test2 = 3;
int gameFinish = 4;
int state = test1;

//colors
int green = color(0, 255, 0);
int darkGreen = color(13, 72, 1);
int red = color(255, 0 ,0);
int darkRed = color(180, 0, 0);
int blue = color (0, 0, 255);
int darkBlue = color(5, 0, 180);
int white = color(255); 
int yellow = color(250, 255, 0);

//Variables for Loading Screen
float LoadNeg = 0;
float LoadPos = 0;
int PercentageLoading = 0;

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


void Loading()
{
  fill(red);
  textSize(22);

  if (LoadPos <= 25)
  {
    text("Loading.",width/2 - 52, height/2 + 75);
  }
  else if (LoadPos < 50 && LoadPos >= 25)
  {
    text("Loading..",width/2 - 52, height/2 + 75);
  }
  else if (LoadPos < 75 && LoadPos >= 50)
  {
    text("Loading...",width/2 - 52, height/2 + 75);
  }
  else if (LoadPos <= 100 && LoadPos >= 75)
  {
    text("Loading.",width/2 - 52, height/2 + 75);
  }
  else if (LoadPos <= 125 && LoadPos >= 100)
  {
    text("Loading..",width/2 - 52, height/2 + 75);
  }//end else if
  else if (LoadPos <= 150 && LoadPos >= 125)
  {
    text("Loading...",width/2 - 52, height/2 + 75);
  }//end else if
  
  //Loading Bar
  stroke(0);
  fill(red);
  noStroke();
  rect(width/2, height/2 - 70, LoadNeg, 8);
  rect(width/2, height/2 - 70, LoadPos, 8);
  
  LoadPos +=0.5;
  if (LoadPos >= 150)
  {
     LoadPos = 150;
  }//end if
  
  LoadNeg -= 0.5;
  if (LoadNeg <= -150)
  {
     LoadNeg = -150;
  }//end if
  
  //Percentage
  PercentageLoading = int ((LoadPos/150)*(100));
  text(PercentageLoading + "%", width/2-30, height/2);
  
  if(PercentageLoading == 100)
  {
    delay(300);
    state = test1;
  }//end if
}//end Loading()

void test2()
{
  background(0);
  fill(255);
  stroke(255);
  textSize(16);
  text("These are the instructions for the game..... blah blah blah", 40, height/2);
}//end test2()