//sounds
import ddf.minim.*;
Minim minim;
AudioPlayer toggle;
AudioPlayer laser;
AudioPlayer reload;
AudioPlayer alien_recording;

//images
PImage img;
PImage alien;
PImage space;
PImage stars;
PImage brainAlien;
PImage spaceShip;
PImage explosion1;
PImage explosion2;
PImage explosion3;

//Fonts
PFont Digi_tech8; 
PFont Digi_tech16;
PFont Digi_tech30;
PFont Arial24;
PFont ArialBold14;

//class calls
Button button1;
Button button2;
Button button3;
AmmoDrop ammoCrate;
HomeButton home;
OptionSwitch cursor;
OptionSwitch lives;

//variables
int score = 0;
int high_score = 0;
int ammo = 25;
int player_lives = 3;
int enemyNumber = 4;
int enemySize = 28;
boolean fire = false;
int gameOver = 0;
int getRandomX()
{
  return int(random(580));
}
int[] enemyX = { getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX(), getRandomX()};
int[] enemyY = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

float ammoX = random(10, 590);
int ammoY = 0;

int timer;
int delay = 1000;// ONE SEC
int now; 

//flags
boolean flash = false;
int livesFlag = 0;
int cursorFlag = 0;

//Variables for Loading Screen
float LoadNeg = 0;
float LoadPos = 0;
int PercentageLoading = 0;

//Program States
int mainMenu = 0;
int LoadingScreen = 1;
int gamePlay = 2;
int instructions = 3;
int options = 4;
int endGame = 5;
int state = mainMenu;

//colors
int darkGreen = color(13, 72, 1);
int brightGreen = color(35, 250, 70);
int red = color(255, 0 ,0);
int blue = color (0, 0, 255);
int white = color(255); 
int yellow = color(250, 255, 0);

void setup()
{
  size(600, 600, P2D);
  //frameRate(85);
  smooth();
  background(0);
  
  //images
  img = loadImage("back.png");
  alien = loadImage("alien.png");
  space = loadImage("space.png");
  stars = loadImage("stars.jpg");
  brainAlien = loadImage("brain_alien.png");
  spaceShip = loadImage("SpaceShip.png");
  explosion1 = loadImage("explosion1.png");
  explosion2 = loadImage("explosion2.png");
  explosion3 = loadImage("explosion3.png");
 
  //classes
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
  laser = minim.loadFile("Laser.mp3");
  reload = minim.loadFile("Reload.mp3");
  alien_recording = minim.loadFile("Alien_recording.mp3");
  
}//end setup()

void draw()
{

  if(state == mainMenu)
  {
    background(0);
    image(space, -300, -10, 1200, 800);
    textFont(Digi_tech30);
    fill(red);
    text("Alien   Apocalypse", width/11, height/4);
    image(alien, 500, 400, 200, 200);
    buttons();
    fill(white);
    text("High Score  " + high_score, width/3, 570);
    alien_recording.play();
  }//end if
  
  else if(state == LoadingScreen)
  {
    background(0);
    cursor();
    Loading();
  }//end else if
  
  else if(state == gamePlay)
  {
    alien_recording.pause();
    image(stars, -50, -50);
    gamePlay();
  }//end else if
  
  
  else if(state == instructions)
  {
    instructions();
    cursor();
  }//end else if
  
   else if(state == options)
  {
    options();
    cursor();
  }//end else if
  
  else if(state == endGame)
  {
    endGame();
    cursor();
  }//end else if
}//end draw()


void Loading()
{
  textFont(Arial24);  
  fill(red);
  if (LoadPos <= 25)
  {
    text("Loading", width/2 - 50, height/2 + 75);
  }
  else if (LoadPos < 50 && LoadPos >= 25)
  {
    text("Loading.", width/2 - 50, height/2 + 75);
  }
  else if (LoadPos < 75 && LoadPos >= 50)
  {
    text("Loading..", width/2 - 50, height/2 + 75);
  }
  else if (LoadPos <= 100 && LoadPos >= 75)
  {
    text("Loading..." ,width/2 - 50, height/2 + 75);
  }
  else if (LoadPos <= 125 && LoadPos >= 100)
  {
    text("Loading", width/2 - 50, height/2 + 75);
  }//end else if
  else if (LoadPos <= 150 && LoadPos >= 125)
  {
    text("Loading.", width/2 - 50, height/2 + 75);
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
    state = gamePlay;
  }//end if
}//end Loading()



void buttons()
{
  button1.run();
  button2.run();
  button3.run();
}//end buttons





void gamePlay()
{
    textFont(Digi_tech8);  
    fill(blue);
    stroke (blue);
    //triangle(mouseX-8, 540, mouseX+8, 540, mouseX, 565);
    image(spaceShip, mouseX - 50, 520, 100, 75);
    // display score, ammo and magazine
    fill(white);
    stroke (white);
    text("Score: " + score, 20, 585);
    text("Ammo: " + ammo, 530, 585);
    if(score > 20)
    {
      enemyNumber = 5;
    }//end if
    
    if(score > 30)
    {
      enemyNumber = 6;
    }//end if
    
    if(score > 40)
    {
      enemyNumber = 7;
    }//end if
    
    if(score > 60)
    {
      enemyNumber = 8;
    }//end if
    
    if(score > 90)
    {
      enemyNumber = 10;
    }//end if
    
    if(livesFlag == 0)
    {
      if(player_lives < 2)
      {
        fill(red);
      }//end if
      text("Lives: " + player_lives, 280, 585);
    }//end for
    
    stroke(white);
    fill(brightGreen);
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
    }//end if
    
    else
    {
      noCursor();
    }//end else
    
    if (millis() - timer >= 10000) 
    {
      ammoFalling();
    }//end if
    
    if(livesFlag == 0)
    {
      for (int i=0; i< enemyNumber; i++)
      {
         if(enemyY[i] > 600)
         {
           player_lives = player_lives - 1;
           enemyY[i]=0;    //reset enemyY to allow game to place again
         }//end if
         
         if(player_lives == 0)
         {
           gameOver = 1;  //game is over
           enemyY[i]=0;    //reset enemyY to allow game to play again
         }//end if
      }//end for
    }//end if
    else
    {
      for (int i=0; i< enemyNumber; i++)
      {
         if(enemyY[i] > 600)
         {
           gameOver = 1;
           enemyY[i]=0;    //reset enemyY to allow game to play again
         }//end if
      }//end for
    }//end else
      
     if (gameOver == 1)    //if game is over
     {
       state = endGame;  //switch state 
     }//end if
}//end gamePlay()
 

  
 
void mousePressed()
{
  fire = true;
}//end mousePressed()
  
  
void crosshair()
{
    noFill();
    stroke(red);    
    noCursor();
    ellipse(mouseX, mouseY, 20, 20);
    ellipse(mouseX, mouseY, 30, 30);
    line(mouseX-10, mouseY-10, mouseX+10, mouseY+10);
    line(mouseX+10, mouseY-10, mouseX-10, mouseY+10);
}//end crosshair
  
  
void ballFalling()
{ 
  stroke(yellow); 
  fill (yellow); 
  if(gameOver == 0)    //if game isn't over
  {
    for (int i=0; i<enemyNumber; i++)
    {
      //ellipse(enemyX[i], enemyY[i]++, enemySize, enemySize);
      image(brainAlien, enemyX[i], enemyY[i]++, enemySize, enemySize);
    }//end for
  }//end if
}//end ballFalling()
  
  
  
void ammoFalling()
{  
  if(gameOver == 0)    //if the game isn't over
  {
      ammoCrate.run();  //drops ammo crates
  }//end if
}//end ammoFalling()  
  
  
  
void cannon(int shotX)
{  
  if(ammo > 0)    //if there is ammo left the laser can fire
  {
    laser.play();
    laser.rewind();
    ammo--;
  }//end if
  
  boolean strike = false;
  for (int i = 0; i < enemyNumber; i++)
  {
    if((shotX >= (enemyX[i]-enemySize)) && (shotX <= (enemyX[i]+enemySize)) && ammo > 0)  //if theres a hit 
    {
      strike = true;
      stroke(brightGreen);
      line(mouseX, 520, mouseX, enemyY[i]);
      fill(red);
      stroke(red);
      //ellipse(enemyX[i], enemyY[i], enemySize+25, enemySize+25);  //explosion
      //determine which explosion to use
      if(score % 2 == 0)
      {
        image(explosion1, enemyX[i]-10, enemyY[i], 80, 80);
      }//end if
      if(score % 3 == 0)
      {
        image(explosion2, enemyX[i]-10, enemyY[i], 80, 80);
      }//end if
      else
      {
        image(explosion3, enemyX[i]-10, enemyY[i], 80, 80);
      }//end else
      enemyX[i] = getRandomX();
      enemyY[i] = 0;        //reset ball to top of screen
      score++;    // update score
     }//end if
   }//end for
   
   if(strike == false && ammo  > 0)    //if miss, don't draw explosion
   {
     stroke(brightGreen);
     line(mouseX, 520, mouseX, 0);
   }//end if 
}//end cannon()
  
  
//GameOver
void endGame()
{
      background(0);
      fill(red);
      textFont(Digi_tech16); 
      fill(red);
      //flashing warning message
      if (millis() - now > delay)    
      { 
        flash = !flash; //change flag
        now = millis(); //reset counter
      }//end if
      
      if (flash)
      {
          text("GAME OVER", width/2.5, height/3);   
      }//end if
      
      fill(white);
      text("Your score was "+ score, width/2.5-60, height/3 + 50);
      if(score < 20)
      {
        text("Better luck next time ", width/2.5-80, height/3 + 100);
      }//end if
      else if(score > 21 && score < 99)
      {
        text("Good work!", width/2.5-7, height/3 + 100);
      }//end if else
      else 
      {
        text("Incredible!", width/2.5-5, height/3 + 100);
      }//end else
      //determine if theres a new high score
      if(score > high_score)
      {
        high_score = score;
      }//end if
     home.run();
}//end gameFinnish()




void reset()
{      
       //return all variables back to initial state for replay
       alien_recording.rewind();
       enemyNumber = 4;
       gameOver = 0;
       score = 0;
       state = mainMenu;
       player_lives = 3;
       ammo = 25;
       LoadPos = 0;
       LoadNeg = 0;
       for (int i=0; i<enemyNumber; i++)
       {
        enemyY[i]=0;    //set ball for top of screen
       }//end for
}//end reset()



void options()
{
  background(0);
  //calls switches for options
  lives.run();
  cursor.run();
  home.run();
}//end options()



void instructions()
{
  background(0);
  home.run();      //home button
  fill(yellow);
  textFont(Digi_tech16);    //header
  text("Instructions", width/2-105, height/3-50);
  fill(white);
  textFont(Digi_tech8);    //body text
  //display insructions
  text("Use the mouse to move the player", width/2-130, height/3);
  text("Press the mouse to fire lazer", width/2-120, height/3+35);
  text("Shooting an alien will kill it, but more will spawn", width/2-180, height/3+70);
  text("Don't let the aliens pass you by, only you stand in their way", width/2-210, height/3+105);
  text("Your ammunition is limited so catch the crates as they pass you for more", width/2-260, height/3+140);
}//end instructions()