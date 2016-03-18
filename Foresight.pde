import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int clockPosx = 670, clockPosy = 430, appState = 0, sec2, sec3, sec = second(), hour, minute, second, temperature, stateCode, nextDayMaxTemperature, nextDayMinTemperature, afterNextDayMaxTemperature, afterNextDayMinTemperature, nextDayCode, afterNextDayCode;
String city, cityCountry, todayCond, str, nextDayForecast, afterNextDayForecast, todayStateText, nextDay, afterNextDay, nextDayName, afterNextDayName;
LeftAnimatedText welcome, foresight, date, nextDaysText1, nextDaysText2, animatedCustomMessage, cityInfo, todayTemp, todayState, animatedNextDayTemperatures, animatedAfterNextDayTemperatures, nextDayInfo, afterNextDayInfo;
RightAnimatedText actualWeatherMessageTop, actualWeatherMessageBottom, actualTemperature;
PImage img1, img2, img3, img4, img5, imgWood, storm, rain, snow, fog, wind, cloud, sun, resizedStorm, resizedRain, resizedSnow, resizedFog, resizedWind, resizedCloud, resizedSun;
RightAnimatedImage animatedStorm, animatedRain, animatedSnow, animatedFog, animatedWind, animatedCloud, animatedSun;
LeftAnimatedImage resizedAnimatedStorm, resizedAnimatedRain, resizedAnimatedSnow, resizedAnimatedFog, resizedAnimatedWind, resizedAnimatedCloud, resizedAnimatedSun, resizedAnimatedStorm2, resizedAnimatedRain2, resizedAnimatedSnow2, resizedAnimatedFog2, resizedAnimatedWind2, resizedAnimatedCloud2, resizedAnimatedSun2;
PFont font;
Minim minim;  
AudioPlayer intro;

void setup() { 
 
  size(810,540);
  img1 = loadImage("1.jpg");
  img2 = loadImage("2.jpg");
  img3 = loadImage("3.jpg");
  img4 = loadImage("4.jpg");
  img5 = loadImage("5.jpg");
  imgWood = loadImage("wood.jpg");
  storm = loadImage("storm.png");
  rain = loadImage("rain.png");
  snow = loadImage("snow.png");
  fog = loadImage("fog.png");
  wind = loadImage("wind.png");
  cloud = loadImage("cloud.png");
  sun = loadImage("sun.png");
  resizedStorm = loadImage("resizedStorm.png");
  resizedRain = loadImage("resizedRain.png");
  resizedSnow = loadImage("resizedSnow.png");
  resizedFog = loadImage("resizedFog.png");
  resizedWind = loadImage("resizedWind.png");
  resizedCloud = loadImage("resizedCloud.png");
  resizedSun = loadImage("resizedSun.png");
  
  minim = new Minim(this);  
  intro = minim.loadFile("intro.mp3");
  
  font = loadFont("nature.vlw");
  
 // si carica il documento XML e si naviga nella struttura 
 XML root = loadXML("http://weather.yahooapis.com/forecastrss?w=725383&u=c");
 XML channel = root.getChild("channel"); 
 XML item = channel.getChild("item");
 XML yweather = item.getChild("yweather:condition"); 
 XML [] forecast = item.getChildren("yweather:forecast");
 
 // si ottengono i parametri desiderati
 todayStateText = yweather.getString("text");
 stateCode = yweather.getInt("code");
 todayCond = forecast[0].getString("text");
 nextDay = forecast[1].getString("text");
 nextDayName = forecast[1].getString("day");
 nextDayCode = forecast[1].getInt("code");
 nextDayMaxTemperature = forecast[1].getInt("high");
 nextDayMinTemperature = forecast[1].getInt("low");
 afterNextDay = forecast[2].getString("text");
 afterNextDayName = forecast[2].getString("day");
 afterNextDayCode = forecast[2].getInt("code");
 afterNextDayMaxTemperature = forecast[2].getInt("high");
 afterNextDayMinTemperature = forecast[2].getInt("low");
 temperature = yweather.getInt("temp"); 
 cityCountry = channel.getChild("yweather:location").getString("city") + ", " + channel.getChild("yweather:location").getString("country"); 
 city = channel.getChild("yweather:location").getString("city");

//inizializzazione di oggetti e entità
  String customMessage = welcomeText(stateCode);
  welcome = new LeftAnimatedText("Welcome to", (width/2)-180, 40, 13, 0, 20);
  foresight = new LeftAnimatedText("Foresight", (width/2)-180, 100, 13, 0, 20);
  date = new LeftAnimatedText("Today it's the "+ day() + "/" + month() + "/" + year(), (width/2)-175, 145, 12.5, 0, 20);
  animatedCustomMessage = new LeftAnimatedText("" + customMessage + " in " + cityCountry + ".", (width/2)-175, 185, 12.5, 0, 20);
  actualWeatherMessageTop = new RightAnimatedText("          It's "+ todayStateText, (width/2)+100, 30, 9, 0);
  actualWeatherMessageBottom = new RightAnimatedText("           in "+ city +" now.", (width/2)+100, 170, 9, 0);
  actualTemperature = new RightAnimatedText("The temperature is " + temperature + "°c", (width/2)+100, 210, 9, 0);
  nextDaysText1 = new LeftAnimatedText("Planning something?",(width/2)-180, (height/2)+70, 13, 0, 15);
  nextDaysText2 = new LeftAnimatedText("Be prepared, Foresight is here to help.",(width/2)-180, (height/2)+100, 13, 0, 15);
  animatedNextDayTemperatures = new LeftAnimatedText("MAX: "+nextDayMaxTemperature+"   min: "+nextDayMinTemperature, (width/2)-180, height-25, 13, 0, 15);
  animatedAfterNextDayTemperatures = new LeftAnimatedText("MAX: "+afterNextDayMaxTemperature+"   min: "+afterNextDayMinTemperature, (width/2), height-25, 13, 0, 195);
  nextDayInfo = new LeftAnimatedText(""+nextDayName+",  "+nextDay, (width/2)-180, height-120, 13, 0, 15);
  afterNextDayInfo = new LeftAnimatedText(""+afterNextDayName+",  "+afterNextDay, width/2, height-120, 13, 0, 195);
  
  animatedSun = new RightAnimatedImage(sun, (width/2)+130, 30, 9, 0);
  animatedStorm = new RightAnimatedImage(storm, (width/2)+130, 30, 9, 0);
  animatedRain = new RightAnimatedImage(rain, (width/2)+130, 30, 9, 0);
  animatedSnow = new RightAnimatedImage(snow, (width/2)+130, 30, 9, 0);
  animatedFog = new RightAnimatedImage(fog, (width/2)+130, 30, 9, 0);
  animatedWind = new RightAnimatedImage(wind, (width/2)+130, 30, 9, 0);
  animatedCloud = new RightAnimatedImage(cloud, (width/2)+130, 30, 9, 0);
  
  resizedAnimatedStorm = new LeftAnimatedImage(resizedStorm, (width/2)-180, height-120, 12, 0, 15);
  resizedAnimatedSun = new LeftAnimatedImage(resizedSun, (width/2)-180, height-120, 12, 0, 15);
  resizedAnimatedRain = new LeftAnimatedImage(resizedRain, (width/2)-180, height-120, 12, 0, 15);
  resizedAnimatedSnow = new LeftAnimatedImage(resizedSnow, (width/2)-180, height-120, 12, 0, 15);
  resizedAnimatedFog = new LeftAnimatedImage(resizedFog, (width/2)-180, height-120, 12, 0, 15);
  resizedAnimatedWind = new LeftAnimatedImage(resizedWind, (width/2)-180, height-120, 12, 0, 15);
  resizedAnimatedCloud = new LeftAnimatedImage(resizedCloud, (width/2)-180, height-120, 12, 0, 15);
  
  resizedAnimatedStorm2 = new LeftAnimatedImage(resizedStorm, width/2, height-120, 12, 0, 195);
  resizedAnimatedSun2 = new LeftAnimatedImage(resizedSun, width/2, height-120, 12, 0, 195);
  resizedAnimatedRain2 = new LeftAnimatedImage(resizedRain, width/2, height-120, 12, 0, 195);
  resizedAnimatedSnow2 = new LeftAnimatedImage(resizedSnow, width/2, height-120, 12, 0, 195);
  resizedAnimatedFog2 = new LeftAnimatedImage(resizedFog, width/2, height-120, 12, 0, 195);
  resizedAnimatedWind2 = new LeftAnimatedImage(resizedWind, width/2, height-120, 12, 0, 195);
  resizedAnimatedCloud2 = new LeftAnimatedImage(resizedCloud, width/2, height-120, 12, 0, 195);
  
}

//procedura che visualizza il testo di benvenuto personalizzato
String welcomeText(int state){
  switch(state) {
    case 0:
    case 1:
    case 2:
    case 3:
    case 4:
    case 37:
    case 38:
    case 39:
    case 45:
    case 47:
      str = "Make sure to be careful, it's\nquite stormy outside";
      break;
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 35:
    case 40:
      str = "Don't forget your umbrella,\nit's raining";
      break;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 41:
    case 42:
    case 43:
    case 46:
      str = "Be cautious and choose proper clothes,\nit's snowing";
      break;
    case 19:
    case 20:
    case 21:
    case 22:
      str = "You won't see much outside, according to\nmy data it's quite foggy";
      break;
    case 23:
    case 24:
    case 25:
      str = "Take your coat with you, it's\n windy outside";
      break;
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 44:
      str = "Not good, not bad, just greyish.\nYes, it's cloudy outside,";
      break;
    case 32:
    case 36:
    case 31:
    case 33:
    case 34:
      str = "Cheers! Nice day, it's sunny\noutside, enjoy";
      break;
    case 3200: 
      str = "Oooops! 404 weather not found :P\nIt's probably Yahoo's fault, check back later";
      break;
  }
  return str;
}

//procedura che visualizza l'introduzione
void intro(){
    sec2 = second();
    sec3 = 0;
    
    if (((sec2-sec)>0)) {
      fill(0);
      text("loading...", 20, 20);
      sec3 = second();
    }
    
    if (((sec3-sec)>7)) {
      image(img1, 0, 0);
      intro.play();
    }
    
    if (((sec3-sec)>8)) {
      image(img2, 0, 0); 
    }
      
    if (((sec3-sec)>10)) {
      image(img3, 0, 0);
    }
    
    if (((sec3-sec)>11)) {
      image(img4, 0, 0);    
    }
    
    if (((sec3-sec)>12)) {
       image(img5, 0, 0);
    }
    
    if ((sec3-sec)>15) {
      appState=1;
    }
}

//procedura complementare che visualizza testo di benvenuto
void welcomeText(){
  fill(255);
  //textFont(font, 24);
  image(imgWood, 0, 0);
  textFont(font, 38);
  welcome.draw();
  textFont(font, 58);
  fill(#52C23E);
  foresight.draw();
  fill(255);
  textFont(font, 24);
  date.draw();
  animatedCustomMessage.draw();
}

//proceduta che visualizza il meteo odierno
void todaysWeather(int state){
  textFont(font, 22);
    switch(state) {
    case 0:
    case 1:
    case 2:
    case 3:
    case 4:
    case 37:
    case 38:
    case 39:
    case 45:
    case 47:
      animatedStorm.draw();
      break;
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 35:
    case 40:
      animatedRain.draw();
      break;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 41:
    case 42:
    case 43:
    case 46:
      animatedSnow.draw();
      break;
    case 19:
    case 20:
    case 21:
    case 22:
      animatedFog.draw();
      break;
    case 23:
    case 24:
    case 25:
      animatedWind.draw();
      break;
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 44:
      animatedCloud.draw();
      break;
    case 32:
    case 36:
    case 31:
    case 33:
    case 34:
      animatedSun.draw();
      break;
    case 3200: 
      //str = "Oooops! 404 weather not found :P It's probably Yahoo's fault, check back later";
      break;
  }
  actualWeatherMessageTop.draw();
  actualWeatherMessageBottom.draw();
  actualTemperature.draw();
}

//procedura che visualizza il meteo per i due giorni successivi
void nextDaysForecast(int nextDayCode, int afterNextDayCode){
  textFont(font, 26);
  fill(#52C23E);
  nextDaysText1.draw();
  fill(255);
  textFont(font, 22);
  nextDaysText2.draw();
  textFont(font, 15);
  
  nextDayInfo.draw();
  switch(nextDayCode) {
    case 0:
    case 1:
    case 2:
    case 3:
    case 4:
    case 37:
    case 38:
    case 39:
    case 45:
    case 47:
      resizedAnimatedStorm.draw();
      break;
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 35:
    case 40:
      resizedAnimatedRain.draw();
      break;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 41:
    case 42:
    case 43:
    case 46:
      resizedAnimatedSnow.draw();
      break;
    case 19:
    case 20:
    case 21:
    case 22:
      resizedAnimatedFog.draw();
      break;
    case 23:
    case 24:
    case 25:
      resizedAnimatedWind.draw();
      break;
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 44:
      resizedAnimatedCloud.draw();
      break;
    case 32:
    case 36:
    case 31:
    case 33:
    case 34:
      resizedAnimatedSun.draw();
      break;
    case 3200: 
      //str = "Oooops! 404 weather not found :P It's probably Yahoo's fault, check back later";
      break;
  }
  animatedNextDayTemperatures.draw();
  
  afterNextDayInfo.draw();
  switch(afterNextDayCode) {
    case 0:
    case 1:
    case 2:
    case 3:
    case 4:
    case 37:
    case 38:
    case 39:
    case 45:
    case 47:
      resizedAnimatedStorm2.draw();
      break;
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 35:
    case 40:
      resizedAnimatedRain2.draw();
      break;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 41:
    case 42:
    case 43:
    case 46:
      resizedAnimatedSnow2.draw();
      break;
    case 19:
    case 20:
    case 21:
    case 22:
      resizedAnimatedFog2.draw();
      break;
    case 23:
    case 24:
    case 25:
      resizedAnimatedWind2.draw();
      break;
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 44:
      resizedAnimatedCloud2.draw();
      break;
    case 32:
    case 36:
    case 31:
    case 33:
    case 34:
      resizedAnimatedSun2.draw();
      break;
    case 3200: 
      //str = "Oooops! 404 weather not found :P It's probably Yahoo's fault, check back later";
      break;
  }
  animatedAfterNextDayTemperatures.draw();
}

//procedure che visualizzano ora e orologio analogico
void timeDate(){
  hour = hour();
  minute = minute();
  second = second();
  textFont(font, 18);
  text(""+hour+":"+minute+":"+second,740,530);
  fill(255,0,0,0);
  stroke(255,255,255);
  ellipse(clockPosx, clockPosy, 200, 200);
  
  stroke(#FFFFFF);
  strokeWeight(6);
  drawHand(45, hour(), 12);
   
  stroke(#FFFFFF); 
  strokeWeight(4);
  drawHand(95, minute(), 60);
   
  stroke(#52C23E); 
  strokeWeight(2);
  drawHand(95, second(), 60);
}

void drawHand(float radius, float value, float divider) {
  float x = clockPosx + radius * cos(value * TWO_PI / divider - PI / 2.0f);
  float y = clockPosy + radius * sin(value * TWO_PI / divider - PI / 2.0f); 
  fill(255,0,0,0);
  line(clockPosx, clockPosy, x, y);
}

//procedura draw che mette insieme tutto :)
void draw() {
  switch (appState) {
  case 0:
    intro();
    break;
  case 1:
    welcomeText();
    todaysWeather(stateCode);
    nextDaysForecast(nextDayCode, afterNextDayCode);
    timeDate();
  }
}
