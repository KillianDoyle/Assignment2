import ddf.minim.*;

Minim minim;
AudioPlayer toggle;

//Program States
int InitialState = 0;
int LoadingScreen = 1;
int test1 = 2;
int test2 = 3;
int options = 4;
int gameFinish = 5;
int state = InitialState;

//images
PImage img;
PImage alien;
PImage space;


//colors
int green = color(0, 255, 0);
int darkGreen = color(13, 72, 1);
int brightGreen = color(35, 250, 70);
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
PFont Digi_tech30;
PFont Arial24;
PFont ArialBold14;

Button button1;
Button button2;
Button button3;
AmmoDrop ammoCrate;
HomeButton home;
OptionSwitch cursor;
OptionSwitch lives;

//--------------------variables for shooter--------------------------------//
int score_shooter = 0;
int ammo = 25;
int player_lives = 5;
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

int livesFlag = 0;
int cursorFlag = 0;


void setup()
{
  size(600, 600, P2D);
  //frameRate(85);
  smooth();
  background(0);
  
  img = loadImage("back.png");
  alien = loadImage("alien.png");
  space = loadImage("space.png");
  
  button1 = new Button(width/3+45, 300, "Play", 1);
  button2 = new Button(width/3, 360, "Insructions", 2);
  button3 = new Button(width/3+25, 420, "Options", 3);
  ammoCrate = new AmmoDrop(random(20, 530)); 
  home = new HomeButton(530, 50);
  lives = new OptionSwitch("Lives", "On", "Off", width/2-35, height/3, 35, 20, red, red);
  cursor = new OptionSwitch("Cursor", "On", "Off", width/2-35, height/3+90, 35, 20, yellow, yellow);
  
    //Fonts
  Digi_tech8 = loadFont("Digitaltech-8.vlw"); 
  Digi_tech16 = loadFont("Digitaltech-16.vlw"); 
  Digi_tech30 = loadFont("Digitaltech-30.vlw");
  Arial24 = loadFont("ArialUnicodeMS-24.vlw");
  ArialBold14 = loadFont("ArialBold14.vlw");
  
  textFont(Digi_tech8);
  textFont(Digi_tech16);
  textFont(Digi_tech30);
  textFont(Arial24);
  textFont(ArialBold14);
  
    //sounds
  minim = new Minim(this);
  toggle = minim.loadFile("Toggle.mp3");
}//end setup()

void draw()
{

  if(state == InitialState)
  {
    background(0);
    image(space, -300, -10, 1200, 800);
    textFont(Digi_tech30);
    fill(red);
    text("Alien   Apocalypse", width/11, height/4);
    image(alien, 500, 400, 200, 200);
    buttons();
  }//end if
  
  else if(state == LoadingScreen)
  {
    background(0);
    cursor();
    Loading();
  }//end else if
  
  else if(state == test1)
  {
    test1();
  }//end else if
  
  
  else if(state == test2)
  {
    test2();
    cursor();
  }//end else if
  
   else if(state == options)
  {
    options();
    cursor();
  }//end else if
  
  else if(state == gameFinish)
  {
    gameFinish();
    cursor();
  }//end else if
}//end draw()


void Loading()
{
  textFont(Arial24);  
  fill(red);
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
  button3.run();
}





void test1()
{
    textFont(Digi_tech8);  
    background (0);
    fill(blue);
    stroke (blue);
    triangle(mouseX-8, 540, mouseX+8, 540, mouseX, 565);
    // display score, ammo and magazine
    fill(white);
    stroke (white);
    text("Score: " + score_shooter, 20, 585);
    text("Ammo: " + ammo, 530, 585);
    if(livesFlag == 0)
    {
      text("Lives: " + player_lives, 280, 585);
    }//end for
    
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
       if (flash)
       {
           text("AMMO LOW", 290, height/2);     
       }//end if
    }//end if
    
    if(ammo == 0)
    {
       fill(red);
       if (flash)
       {
           text("AMMO EMPTY", 290, height/2);     
       }//end if
    }//end if
    
    if(fire)
    {
      cannon(mouseX);
      fire = false;
    }//end if
    
    ballFalling();
    
    if(cursorFlag==0)
    {
      crosshair();
    }
    
    else
    {
      noCursor();
    }
    
    if (millis() - timer >= 10000) 
    {
      ammoFalling();
    }
    if(livesFlag==1)
    {
      for (int i=0; i< 5; i++)
      {
         if(bally[i] > 600)
         {
           player_lives--;
         }//end if
         
         if(player_lives == 0)
         {
           gameOver = 1;
         }//end if
      }//end for
    }//end if
    for (int i=0; i< 5; i++)
    {
       if(bally[i] > 600)
       {
         gameOver = 1;
         bally[i]=0;    //reset bally to allow game to place again
       }//end if
    }//end for
    
   if (gameOver == 1)
   {
     state = gameFinish;
   }//end if
}//end test1()
 

  
 
void mousePressed()
{
  fire = true;
}
  
  
void crosshair()
{
    noFill();
    stroke(red);    
    noCursor();
    ellipse(mouseX, mouseY, 20, 20);
    ellipse(mouseX, mouseY, 30, 30);
    line(mouseX-10, mouseY-10, mouseX+10, mouseY+10);
    line(mouseX+10, mouseY-10, mouseX-10, mouseY+10);
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
  boolean strike = false;
  fill(brightGreen);
  stroke(brightGreen);
  for (int i = 0; i < 4; i++)
  {
    if((shotX >= (ballx[i]-ballSize/2)) && (shotX <= (ballx[i]+ballSize/2)) && ammo>0) 
    {
      strike = true;
      line(mouseX, 565, mouseX, bally[i]);
      fill(red);
      stroke(red);
      ellipse(ballx[i], bally[i], ballSize+25, ballSize+25);
      ballx[i] = getRandomX();
      bally[i] = 0;
      // update score
      score_shooter++;
     }//end if
   }//end for
   if(strike == false && ammo  >0)
   {
     line(mouseX, 565, mouseX, 0);
   }//end if 
}//end cannon()
  
  
//GameOver
void gameFinish()
{
      background(0);
      fill(red);
      textFont(Digi_tech16);  
      text("GAME OVER", width/3, height/2);
      text("Your score was : "+ score_shooter, width/3-50, height/2 + 50);
      if(score_shooter < 20)
      {
        text("Better luck next time ", width/3-80, height/2 + 100);
      }//end if
      else if(score_shooter > 21 && score_shooter < 99)
      {
        text("Wow! Good work!", width/3-40, height/2 + 100);
      }//end if else
      else 
      {
        text("Incredible!", width/3-40, height/2 + 100);
      }//end else
     home.run();
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

void options()
{
  background(0);
  lives.run();
  cursor.run();
  home.run();
  text(livesFlag, 100, 100);
}



void test2()
{
  background(0);
  home.run();
  fill(yellow);
  textFont(Digi_tech16);
  text("Instructions", width/2-105, height/3-50);
  fill(white);
  textFont(Digi_tech8);
  text("Use the mouse to move the player", width/2-130, height/3);
  text("Press the mouse to fire lazer", width/2-120, height/3+35);
  text("Shooting an alien will kill it, but more will spawn", width/2-180, height/3+70);
  text("Don't let the aliens pass you by, only you stand in their way", width/2-210, height/3+105);
  text("Your ammunition is limited so catch the crates as they pass you for more", width/2-260, height/3+140);
}//end test2()