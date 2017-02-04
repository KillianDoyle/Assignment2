//Program States
int InitialState = 0;
int LoadingScreen = 1;
int test1 = 2;
int test2 = 3;
int gameFinish = 4;
int state = InitialState;

//images
PImage img;


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


//Fonts
PFont Digi_tech8; 
PFont Digi_tech16;
PFont Digi_tech20;

Button button1;
Button button2;
AmmoDrop ammoCrate;


//--------------------variables for shooter--------------------------------//
int score_shooter = 0;
int ammo = 25;
int ballSize = 20;
boolean fire = false;
int gameOver = 0;
int getRandomX()
{
  return int(random(600));
}
int[] ballx = { getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX() };
int[] bally = { 0, 0, 0, 0, 0 };

float ammox = random(10, 590);
int ammoy = 0;

int timer;
int delay = 1000;// ONE SEC
int now; 
//flag
boolean flash = false;


void setup()
{
  size(600, 600, P2D);
  frameRate(85);
  smooth();
  background(0);
  
  img = loadImage("back.png");
  
  button1 = new Button(width/3, height/4, "PLAY", 1);
  button2 = new Button(width/3, height/2, "Insructions", 2);
  ammoCrate = new AmmoDrop(random(20, 530));          //ammo crates spawn between 20 and 530

  
  //Fonts
  Digi_tech8 = loadFont("Digitaltech-8.vlw"); 
  Digi_tech16 = loadFont("Digitaltech-16.vlw"); 
  Digi_tech20 = loadFont("Digitaltech-20.vlw");
  textFont(Digi_tech8);
  textFont(Digi_tech16);
  textFont(Digi_tech20);
}//end setup()

void draw()
{

  if(state == InitialState)
  {
    background(0);
    buttons();
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


void Loading()
{
  textFont(Digi_tech16);    
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



void buttons()
{
  button1.run();
  button2.run();
}





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
    textFont(Digi_tech8); 
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
 

  
 
void mousePressed()
{
  fire = true;
}
  
  
  
  
void ballFalling()
{  
  stroke(yellow); 
  fill (yellow); 
  if(gameOver == 0)
  {
    for (int i=0; i<4; i++)
    {
      ellipse(ballx[i], bally[i]++, ballSize, ballSize);
    }//end for
  }//end if
}//end ballFalling()
  
  
  
void ammoFalling()
{  
  if(gameOver == 0)
  {
      ammoCrate.run();
  }//end if
}//end ammoFalling()  
  
  
  
void cannon(int shotX)
{
  if(ammo > 0)
  {
  ammo--;
  }//end if
  fill(red);
  stroke(red);
  boolean strike = false;
  for (int i = 0; i < 4; i++)
  {
    if((shotX >= (ballx[i]-ballSize/2)) && (shotX <= (ballx[i]+ballSize/2)) && ammo>0) 
    {
      strike = true;
      line(mouseX, 565, mouseX, bally[i]);
      ellipse(ballx[i], bally[i], ballSize+25, ballSize+25);
      ballx[i] = getRandomX();
      bally[i] = 0;
      // update score
      score_shooter++;
     }//end if
   }//end for
   if(strike == false &&ammo>0)
   {
     line(mouseX, 565, mouseX, 0);
   }//end if 
}//end cannon()
  
  
//GameOver
void gameFinish()
{
      background(0);
      fill(red);
      textAlign(CENTER);
      textSize(16);
      text("GAME OVER", width/2, height/2);
      text("Your score was : "+ score_shooter, width/2, height/2 + 50);
      if(score_shooter < 20)
      {
        text("You didn't do so well...Better luck next time ", width/2, height/2 + 70);
      }//end if
      else if(score_shooter > 21 && score_shooter < 99)
      {
        text("Wow! Good work!", width/2, height/2 + 70);
      }//end if else
      else 
      {
        text("Incredible!", width/2, height/2 + 70);
      }//end else

}//end gameFinnish()




void reset()
{
       gameOver = 0;
       score_shooter = 0;
       state = InitialState;
       ammo = 25;
       LoadPos = 0;
       LoadNeg = 0;
       for (int i=0; i<4; i++)
      {
        bally[i]=0;
      }//end for
}//end reset()





void test2()
{
  textFont(Digi_tech8); 
  background(0);

  fill(255);
  stroke(255);
  textSize(16);
  text("These are the instructions for the game..... blah blah blah", 40, height/2);
}//end test2()