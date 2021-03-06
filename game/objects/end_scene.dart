part of gdp;

class EndScene extends GameObject{
 
  ImageElement img = new ImageElement();

  SpriteSheet sprite;
  SpriteSheet outroTextSprite;
  SpriteSheet shipItemSprite1;
  SpriteSheet shipItemSprite2;
  SpriteSheet shipItemSprite3;
  SpriteSheet shipItemSprite4;
  
  SpriteSheet spaceShipSprite;
  SpriteSheet buzzSprite;
  
  SpriteSheet missionTextSprite;
  SpriteSheet continueTextSprite;
  int spriteXInitial = 0;
  int spriteYInitial = 0;
  int spriteWidth = 97;
  int spriteHeight = 50;
  
  double imgOffsetX = 8.0;
  double imgOffsetY = -7.0;

  double initialPos;
  double endPos;
  bool goingBack = false;
  double velocity_y = 20.0;
  double jumpVelocity = 20.0;
  double accel = 0.8;
  double initialY;
  Stopwatch liftOffTimer = new Stopwatch();
  Stopwatch outroTimer = new Stopwatch();
  
  double ss1x = 0.0;
  double ss1y = 0.0;
  double ss2x = 0.0;
  double ss2y = 0.0;
  double ss3x = 0.0;
  double ss3y = 0.0;
  double ss4x = 0.0;
  double ss4y = 0.0;
  double buzzx = 0.0;
  double buzzy = 0.0;
  double shipx = 0.0;
  double shipy = 0.0;
  double missionTextx = 0.0;  
  double continueTextx = 0.0; 
  
  bool outroText = false;
  bool shipItem1 = false;
  bool shipItem2 = false;
  bool shipItem3 = false;
  bool shipItem4 = false;
  
  bool shipFixed = false;
  bool reachShip = false;
  bool liftOff = false;
  bool setBG = false;
  bool drawText = false;
  
  EndScene() {
    //super.initialize(x, y);
    normContext.clearRect(0, 0,640, 480);
    ctx.clearRect(0, 0,640, 480);
    width = 83.0;
    height = 40.0;

    sprite = new SpriteSheet("./content/enemies_spritesheet.png",
        0,100,90,90);
    
    outroTextSprite = new SpriteSheet("./content/outro_text.png",0,0,640,480);
    outroTextSprite.spritey = -400;
    
    shipItemSprite1 = new SpriteSheet("./content/gameitems.png",
        0,100,90,90);
    shipItemSprite2 = new SpriteSheet("./content/gameitems.png",
        0,100,90,90);
    shipItemSprite3 = new SpriteSheet("./content/gameitems.png",
        0,100,90,90);
    shipItemSprite4 = new SpriteSheet("./content/gameitems.png",
        0,100,90,90);
    
    spaceShipSprite = new SpriteSheet("./content/spaceship.png",
        0,0,230,310);
    
    buzzSprite = new SpriteSheet("./content/buzzspritesheet.png",0,0,75,100);


    missionTextSprite = new SpriteSheet("./content/mission_success.png",0,0,432,98);
    missionTextSprite.scaledw = 1296;
    missionTextSprite.scaledh = 294;
    missionTextx = camera.x;
    
    continueTextSprite = new SpriteSheet("./content/mission_success.png",0,0,200,30);
        continueTextSprite.scaledw = 300;
        continueTextSprite.scaledh = 45;
        continueTextx = camera.x+700;
        continueTextSprite.spritey = 100;
    
    buzzSprite.numberOfFrames = 12;
    buzzSprite.frameChangeRate = 5.0;
    buzzx = camera.x-100;
    buzzy = 300.0;
    
    //initialPos = x;
    //endPos = x-150.0;
    
    sprite.frameChangeRate = 10.0;
    sprite.numberOfFrames = 4;
    
    //initialY= y;
    //Globals.setBackground();
     ss1x = camera.x+700;
     ss1y = -475.0;
     ss2x = camera.x+800;
     ss2y = -475.0;
     ss3x = camera.x+900;
     ss3y = -475.0;
     ss4x = camera.x+1000;
     ss4y = -475.0;
     
     shipx = camera.x + 300;
     shipy = 200.0;
     
     
     
     query("#canvas").style.backgroundImage = "url(content/intro_bg.png)";
  }
  
  update (double dt) {
  
   // double speed = 0.4 * dt;
    //print('end scene');
   // sprite.update(dt);
    
    if(!outroText){
      if(outroTextSprite.spritey <= 0){
        outroTextSprite.spritey += 0.5;
        
      }
      
      else{
        outroTimer.start();
        
        if(outroTimer.elapsedMilliseconds > 4000){
          outroText = true;
          outroTimer.stop();
          outroTimer.reset();
        }
      }
      
      if(Game.instance.input.wasPressed(KeyCode.ENTER)){
        outroText = true;
        query("#canvas").style.backgroundImage = "url(content/backgrounds/level2.jpg)";
      }
      
    }
    
    if(!shipItem1 && outroText){
      if(ss1x > shipx+25 || ss1y < 200.0){
        if(ss1x>shipx+25)
          ss1x -= 5.5;
        if(ss1y<shipy)
          ss1y += 10.0;
      }
      else{
       shipItem1 = true;
       spaceShipSprite.spritex += 230;
      }
    }
    
    if(shipItem1 && !shipItem2){
      if(ss2x > shipx+25 || ss2y < 200.0){
        if(ss2x>shipx+25)
          ss2x -= 7.0;
        if(ss2y<shipy)
          ss2y += 10.0;
      }
      else{
       shipItem2 = true;
       spaceShipSprite.spritex += 230;
      }
    }
    
    if(shipItem1 && shipItem2 && !shipItem3){
      if(ss3x > shipx+25 || ss3y < 200.0){
        if(ss3x>shipx+25)
          ss3x -= 8.5;
        if(ss3y<shipy)
          ss3y += 10.0;
      }
      else{
       shipItem3 = true;
       spaceShipSprite.spritex += 230;
      }
    }
    
    if(shipItem1 && shipItem2 && shipItem3 && !shipFixed){
      if(ss4x > shipx+25 || ss4y < 200.0){
        if(ss4x>shipx+25)
          ss4x -= 9.5;
        if(ss4y<shipy)
          ss4y += 10.0;
      }
      else{
       shipItem4 = true;
       spaceShipSprite.spritex = 920;
       shipFixed = true;
      }
    }
    
    
    
    if(shipFixed && !reachShip){
      if(buzzx <= shipx - 30){
      buzzSprite.update(dt);
      buzzx += 3;
      }
      else{
        buzzSprite.spritex = 0;
        buzzSprite.spritey = 200;
        buzzx += 4;
        
        
        if(buzzy <= 155){
          buzzy += 15;
          buzzSprite.update(dt);
        }
        else{
          buzzy -= 15;
          buzzSprite.update(dt);
        }
        
        if(buzzSprite.spritex >= 375){
          reachShip = true;
          liftOff = true;
          liftOffTimer.start();
          buzzSprite.spritex = -75;
        }
      }
    }
    
    
    
    if(liftOff){
      if(liftOffTimer.elapsedMilliseconds > 1000 && !setBG){
      spaceShipSprite.spritex = 1140;  
      //liftOffTimer.reset();
      //liftOffTimer.start();
      }
      
      if(liftOffTimer.elapsedMilliseconds > 3000 && shipy>-800 && !setBG){
      shipy -= 10;
      liftOffTimer.stop();
      }
      
      if(shipy <= -800){
        if(!setBG){
          query("#canvas").style.backgroundImage = "url(content/backgrounds/end-scene.jpg)";
          setBG = true;
          shipy = 400.0;
          shipx = camera.x-100;
          //normContext.clearRect(x, y, 640, 480);
        }
      }
      
      if(setBG){
       
        if(shipx<camera.x+700){
          
        spaceShipSprite.spritex = 1600;
        
        spaceShipSprite.scaledw -= 1.5;
        spaceShipSprite.scaledh -= 2.0;
        shipx += 5;
        shipy -= 3;
        /*
        spaceShipSprite.scaledw = 100.0;
        spaceShipSprite.scaledh = 135.0;
        */
        }
        else{
          spaceShipSprite.scaledw = 0.0;
          spaceShipSprite.scaledh = 0.0;
         outroTimer.start();
         if(outroTimer.elapsedMilliseconds > 1000){
          drawText = true;
          outroTimer.stop();
          outroTimer.reset();
         }
        }
      }
      
      if(drawText){
        if(missionTextSprite.scaledw >= 490){
        missionTextSprite.scaledw -= 13.2;
        missionTextSprite.scaledh -= 3;
        missionTextx += 4;
        }
        else{
          continueTextSprite.drawOnPosition(continueTextx, 400.0, 200.0, 30.0);
          Game.instance.state = Game.instance.stateEnumEnd;
        }
      }
     
      
    }
    
    
    
   
  }
  
  draw(){
    //sprite.drawOnPosition(camera.x+300.0, 0.0, width , height);
    
    if(outroText){
    spaceShipSprite.drawOnPosition(shipx, shipy, 230.0, 310.0);
    buzzSprite.drawOnPosition(buzzx, buzzy, 75.0, 100.0);
    
    if(!shipItem1){
      shipItemSprite1.drawOnPosition(ss1x, ss1y, 90.0, 90.0);
    }
    if(!shipItem2){
    shipItemSprite2.drawOnPosition(ss2x, ss2y, 90.0, 90.0);
    }
    if(!shipItem3){
    shipItemSprite3.drawOnPosition(ss3x, ss3y, 90.0, 90.0);
    }
    if(!shipItem4){
    shipItemSprite4.drawOnPosition(ss4x, ss4y, 90.0, 90.0);
    }
    
    
      if(drawText){
      missionTextSprite.drawOnPosition(missionTextx, 0.0, 432.0, 98.0);
      //continueTextSprite.drawOnPosition(continueTextx, 300.0, 200.0, 30.0);
      }
    }
    
    else if(!outroText){
      outroTextSprite.drawOnPositionNormal(0.0, 0.0, 640.0 , 480.0);
      continueTextSprite.drawOnPosition(camera.x-150, -475.0, 230.0, 30.0);
    }
    
    
  }
  

   
}
