import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer music;
AudioSample sound;

PImage background, brick;
PImage ball, ballr, paddle;
PImage loseimage, startbutton, winimage;

float bx, by, bxspeed, byspeed; //ball  
float bxr, byr, bxrspeed, byrspeed; //ballred
int bsize;
int px, py;//pad  
int gameover, begin, score;
int bstext;
//brick(stone)  
int [] sx={0, 100, 200, 300, 400, 500, 600, 700};  
int [] sy={0, 20, 40};  
int [] bs= new int[8]; 
int [] bs1= new int[8];
int [] bs2= new int[8];
void variables() { 
  //BallVariables
  bx=width/2;  
  by=height/2;  
  bxspeed=3;  
  byspeed=3; 
  //BallRedVariables
  bxr=width/2;  
  byr=height/2;
  bxrspeed=-2;  
  byrspeed=2; 

  bsize=20;  
  //Paddle
  px=mouseX;  
  py=height-40;  

  //conditionLine1 
  for (int a=0; a<=7; a++) {  
    bs[a]=1;
    bs1[a]=1;
    bs2[a]=1;
  }
  //gameover/start setup
  gameover=3;
  bstext=0;
  begin=0;
  score=0;

  //BackGround Music
  minim= new Minim(this);
  music= minim.loadFile("BGMusic.mp3", 2048);
  music.play();
  //Sound Effect 
  minim = new Minim(this);
  sound=minim.loadSample("SoundEF.wav", 2048);

  //image
  background=loadImage("background.jpg");
  ball=loadImage("ball.png");
  ballr=loadImage("ballr.png");
  loseimage=loadImage("Loseimage.png");
  brick=loadImage("brick.png");
  startbutton=loadImage("startbutton.png");
  winimage=loadImage("win.png");
  paddle=loadImage("paddle.png");
}  
//Ball
void ball() {  
  bx+=bxspeed;  
  by+=byspeed;    
  ball.resize(bsize, bsize);
  image(ball, bx, by);
}  
//Ball Red
void ballred() {  
  bxr+=bxrspeed;  
  byr+=byrspeed;  
  ballr.resize(bsize, bsize);
  image(ballr, bxr, byr);
}  
//Ball_screen
void screen_ball() {  
  if (bx>width-bsize) {  
    bxspeed=-bxspeed;
  }  
  if (bx<0+bsize) {  
    bxspeed=-bxspeed;
  }  
  if (by>height) {  
    by=random(250, 300);
    gameover--; // live -1 if fall out
  }  
  if (by<0) {  
    byspeed=-byspeed;
  }
}  
void screen_ballr() {  
  if (bxr>width-bsize) {  
    bxrspeed=-bxrspeed;
  }  
  if (bxr<0+bsize) {  
    bxrspeed=-bxrspeed;
  }  
  //if (byr>height) {  
  //  byr=int(random(250));
  //}  
  if (byr<0) {  
    byrspeed=-byrspeed;
  }
}  

void paddle() {  
  px=mouseX-40;  
  //fill(0, 255, 0);  
  //rect(px, py, 80, 20);
  brick.resize(80, 20);
  image(brick, px, py);
}  
//Ball_paddle
void paddle_ball() {  
  if (by>=py-20 && bx>=px-40 && bx<=px+80) {  
    byspeed=-byspeed;
  }
}
//Ballr_paddle
void paddle_ballr() {  
  if (byr>=py-20 && bxr>=px-40 && bxr<=px+80) {  
    byrspeed=-byrspeed;
  }
}

// Brick Line 
void Brick() {  
  //line0
  for (int i=0; i<=7; i++) { 
    if (bs[i]==1) { 
      paddle.resize(100, 20);
      image(paddle, sx[i], sy[0]);
    }
  }
  //line1
  for (int i=0; i<=7; i++) { 
    if (bs1[i]==1) { 
      paddle.resize(100, 20);
      image(paddle, sx[i], sy[1]);
    }
    if (bs1[3]==1) { 
      brick.resize(100, 20);
      image(brick, sx[3], sy[1]);
    }
  }
  //line2
  for (int i=0; i<=7; i++) { 
    if (bs2[i]==1) { 
      paddle.resize(100, 20);
      image(paddle, sx[i], sy[2]);
    }
  }
} 
//BrickClean 
void Brick_ball() {  
  //cleanline0
  for (int i=0; i<=7; i++) { 
    if (bs[i]==1&& 
      bx>=sx[i] && bx<=sx[i]+100&&  
      by>=sy[0] && by<=sy[0]+20) { 
      bs[i]=900; 
      byspeed=-byspeed;
      score++;
      sound.trigger();
    }
    if (bs[i]==1&& 
      bxr>=sx[i] && bxr<=sx[i]+100&&  
      byr>=sy[0] && byr<=sy[0]+20) { 
      bs[i]=900; 
      byrspeed=-byrspeed;
      score++;
      sound.trigger();
    }
  }
  //cleanline1
  for (int i=0; i<=7; i++) { 
    if (bs1[i]==1&& 
      bx>=sx[i] && bx<=sx[i]+100&&  
      by>=sy[1] && by<=sy[1]+20) { 
      bs1[i]=900; 
      byspeed=-byspeed;
      score++;
      sound.trigger();
    }
    if (bs1[i]==1&& 
      bxr>=sx[i] && bxr<=sx[i]+100&&  
      byr>=sy[1] && byr<=sy[1]+20) { 
      bs1[i]=900; 
      byrspeed=-byrspeed;
      score++;
      sound.trigger();
    }
    if (bs1[3]==1&& 
      bxr>=sx[3] && bxr<=sx[3]+100&&  
      byr>=sy[1] && byr<=sy[1]+20) { 
      bs1[3]=900; 
      byrspeed=-byrspeed;
      score++;
      sound.trigger();
    }
  }
  //cleanline2
  for (int i=0; i<=7; i++) { 
    if (bs2[i]==1&& 
      bx>=sx[i] && bx<=sx[i]+100&&  
      by>=sy[2] && by<=sy[2]+20) { 
      bs2[i]=900; 
      byspeed=-byspeed;
      score++;
      sound.trigger();
    }
    if (bs2[i]==1&& 
      bxr>=sx[i] && bxr<=sx[i]+100&&  
      byr>=sy[2] && byr<=sy[2]+20) { 
      bs2[i]=900; 
      byrspeed=-byrspeed;
      score++;
      sound.trigger();
    }
  }
}  

void setup() {  
  size(800, 600);  
  variables();  
  frameRate(120);
}  


void draw() {  
  //set background
  background.resize(width, height);
  image(background, 0, 0);
  //press enter to play
  if (mousePressed) {
    begin=1;
  }
  if (begin==1) {
    ball();
  } else {
    startbutton.resize(200, 100);
    image(startbutton, (width/2)-100, (height/2)-100);
  }

  //Lives count
  textSize(40);
  text("Live : " + gameover, 0, height-40);
  //score
  text("Score : " + score, 0, height-80);
  //gameover
  if (gameover==0) {
    textSize(48);
    fill(0);
    text("Score :" +score, 250+50, 300-40);
    text("GAME OVER", 250, 300);
    loseimage.resize(100, 100);
    image(loseimage, 300, 400);
    return;
  }
  //winscreen
  if (score==24) {
    fill(255, 0, 0);
    text("YOU WIN", 300+20, 300+20);
    winimage.resize(300, 300);
    image(winimage, width/2-150, height/2-150);
    return;
  }
  //Ball Plus
  if (bs1[3]!=1) {
    if (bstext==0) {
      textSize(30);
      fill(0);
      text("Press UP for one more ball", 100, 400);
    }

    if (keyCode==UP) {
      ballred();
      bstext++;
    }
  }
  screen_ball();
  screen_ballr();

  paddle();  
  paddle_ball(); 
  paddle_ballr();

  Brick(); 
  Brick_ball();
} 
