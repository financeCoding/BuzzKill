part of gdp;

/**
 * The oxygen class represents the object in the game that Buzz needs to collect
 * To keep his oxygen "Life" from reaching 0.  
 * Oxygen can float in midair and is not affected by gravity
 */
class Oxygen extends GameObject {
  
  
  update(double dt){
    // inanimate object, does nothing
  }
  
  draw() {
    context.save();
    context.fillStyle = 'black';
    context.fillText("OXYGEN", x - camera.x - width/2, y - camera.y, width);
    context.restore();
  }
  
  /*
   * This method to be called when Buzz touches the object.  
   */
  collect() {
    Game.oxygen += 20.0;  //TODO this should be changed to a method call
    SoundManager.instance.playSound(SoundManager.enumSoundOxygen);
    // Destroy this object
  }
  
}