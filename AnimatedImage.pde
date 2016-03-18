class RightAnimatedImage {
 float posx, posy;
 float velx, vely;
 PImage img;
  RightAnimatedImage(PImage _img, float _posx, float _posy, float _velx, float _vely) {
    posy=_posy;
    img=_img;
    posx=_posx;
    velx=_velx;
    vely=_vely;
  }
  void draw() {
    posx=posx+velx;
    if (velx>0.7){
      velx=velx-0.7;
    }
    posy+=vely;
    if (posx>width-192) {
      image(img, width-192, posy);
    }else{
      image(img, posx, posy);
    }
  }
}
