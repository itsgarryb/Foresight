class LeftAnimatedText {
 float posx, posy, finalPosx;
 float velx, vely;
 String text;
  LeftAnimatedText(String _text, float _posx, float _posy, float _velx, float _vely, float _finalPosx) {
    posy=_posy;
    text=_text;
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
      text(text, finalPosx, posy);
    }else{
    text(text, posx, posy);
    }
  }
}
