class LeftAnimatedImage {
 float posx, posy, finalPosx;
 float velx, vely;
 PImage img;
  LeftAnimatedImage(PImage _img, float _posx, float _posy, float _velx, float _vely, float _finalPosx) {
    posy=_posy;
    img=_img;
    posx=_posx;
    velx=_velx;
    vely=_vely;
    finalPosx=_finalPosx;
  }
  void draw() {
    posx=posx-velx;
    if (velx>0.35){
      velx=velx-0.35;
    }
    posy+=vely;
    if (posx<finalPosx) {
      image(img, finalPosx, posy);
    }else{
      image(img, posx, posy);
    }
  }
}
