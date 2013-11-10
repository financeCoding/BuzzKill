part of gdp;

/**
 *  The Game class holds the root of the game.  It is started by Main
 *  and controls all other parts of the application. 
 */
class Game{
  
Player player = new Player();
Alien obstacle = new Alien();
static double oxygen = 100.0;  


Game() {
    ObjectManager om = new ObjectManager();
    SoundManager sm = new SoundManager();
    om.addObject(player);
    om.addObject(obstacle);
    
    Block floor = new Block();
    floor.initialize(0.0, viewportHeight - 70.0);
    floor.width = viewportWidth - 0.0;  //TODO: convert this to double properly
    floor.height = 30.0;
    ObjectManager.instance.addObject(floor);
    ObjectManager.instance.blockList.add(floor);
    
    
    //Objects here for testing 
    
    Spike spike = new Spike()
    ..initialize(20.0,viewportHeight - 40.0)
    ..width = 100.0
    ..height = 10.0;
    ObjectManager.instance.addObject(spike);
    
    Oxygen oxygen = new Oxygen()
    ..initialize(500.0,viewportHeight - 100.0)
    ..width = 30.0
    ..height = 10.0;
    ObjectManager.instance.addObject(oxygen);
    
    ShipItem shipItem = new ShipItem()
    ..initialize(250.0,viewportHeight - 200.0)
    ..width = 50.0
    ..height = 30.0;
    ObjectManager.instance.addObject(shipItem);
}

/**
 *  Update is called once per game Loop
 */
void update(double dt) {
  
  // Adjust the camera position
  if (player.x - camera.x > viewportWidth - 150) {
    camera.x = player.x - (viewportWidth - 150);
  }
  if (player.x - camera.x < 150) {
    camera.x = player.x - 150;
  }
  
  for (GameObject go in ObjectManager.instance.goList) {
    go.update(dt);
  }
}

/**
 *  Draw is called once per Render? I believe.  Its called
 *  By the Game Loop
 */
void draw() {
  // Does a gray background so we can see the canvas size
  context.fillStyle = 'gray';
  context.fillRect(0, 0, 640, 480);
  
  for (GameObject go in ObjectManager.instance.goList) {
    
    // TODO: Change so its not just objects that have their middle in the screen that get drawn
    if (go.x + go.width/2 > camera.x && 
        go.x - go.width/2 < camera.x + viewportWidth) {
      go.draw();
      DrawColliderBox(go);
    }   
  }
  
  drawHUD();
}

/**
 * Draws textual information around the edges of the screen that does not move with
 * the camera.
 */
drawHUD() {  //TODO: Change this information into Game Variables
  context.save();
  context.fillStyle = 'black';
  context.font = "normal 14pt calibri";
  context.fillText("BUZZKILL", 10, 20, 100);
  //context.fillText("Score:  ?????", viewportWidth/2 -35, 20, 100);  Do we have score in this game?
  context.fillText("Lives: 3", 10, viewportHeight-15, 100);
  context.fillText("Remaining Oxygen: 100%", viewportWidth - 200, viewportHeight-15, 500);
  context.restore();
}
}