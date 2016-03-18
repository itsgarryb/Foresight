class RightAnimatedText {
 float posx, posy;
 float velx, vely;
 String text;
  RightAnimatedText(String _text, float _posx, float _posy, float _velx, float _vely) {
    posy=_posy;
    text=_text;
    posx=_posx;
    velx=_velx;
    vely=_vely;
  }
  void draw() {
    posx=posx+velx;
    if (velx>0.65){
      velx=velx-0.65;
    }
    posy+=vely;
    if (posx>width-235) {
      text(text, width-235, posy);
    }else{
    text(text, posx, posy);
    }
  }
}
