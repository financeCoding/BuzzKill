part of gdp;

 
/**
 * A SpriteSheet (SS) is a set of sprites that make up an animation for an object.
 * They can either be line drawings, or images.
 */
class SpriteSheet {

  int spritex;
  num spritey;
  num _framew;
  num _frameh;  
  num scaledw;
  num scaledh;
  String _imgurl = "";
  ImageElement _img;
  
  double lastDraw = 0.0;
  double frameChangeRate;
  int numberOfFrames;
  int spriteFrame = 0;

  int spriteXInitial = 0;
  
  SpriteSheet(this._imgurl, spritex, this.spritey,this._framew,this._frameh)
  {
    _img = ImageLoader.getImage(_imgurl); 
    this.scaledh = this._frameh;
    this.scaledw = this._framew;
    this.spritex = spritex;
    this.spriteXInitial = spritex;
  }
  
  drawOnPosition(double x, double y, double frameX, double frameY)
  {
    ctx.drawImageScaledFromSource(_img,spritex,spritey,_framew,_frameh, x,y,scaledw,scaledh);
  }
  
  /* 
   * For drawing that is not adjusted by the Camera
   */
  drawOnPositionNormal(double x, double y, double frameX, double frameY)
  {
      normContext.drawImageScaledFromSource(_img,spritex,spritey,_framew,_frameh, x,y,_framew,_frameh);
  }
  
  update(double dt)
  {
    lastDraw += dt; 
    if (lastDraw > frameChangeRate) {
    lastDraw -= frameChangeRate;
      if (spriteFrame >= numberOfFrames) {  
        spriteFrame = 1;
      }
      else{
        spriteFrame++;
      }
      // The minus one is because the first frame starts at 0
      spritex = spriteXInitial + (spriteFrame - 1)  * _framew;
    }
  }
}


class ImageLoader {
  
static Map<String,ImageElement> bufferedImages;
  
//loads/buffers new images into map (using URL as key) for future use
  static ImageElement loadImage(String url)
  {
    if(bufferedImages == null)
      bufferedImages = new Map<String,ImageElement>();
    
    ImageElement img = new Element.tag("img");
    img.src = url;
    bufferedImages[url] = img;
    
    return img;
  }
  
 
  //returns image as per URL
  static ImageElement getImage(String url)
  {
    if(bufferedImages == null)
      bufferedImages = new Map<String,ImageElement>();
    
    if(bufferedImages.containsKey(url))
      return bufferedImages[url];
    return loadImage(url);
  }
  
}