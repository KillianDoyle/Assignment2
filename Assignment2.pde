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