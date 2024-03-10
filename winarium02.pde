import java.util.stream.Collectors;
import ddf.minim.*;
import TUIO.*;
import http.SimpleHTTPServer;
import websockets.WebsocketServer;

WebsocketServer ws;
SimpleHTTPServer server;
TuioProcessing tuioClient;
Minim minim;
AudioPlayer player;
int PARTICLE_SYSTEM_NUM = 4;
ParticleSystem[] particleSystems;
boolean debug = false;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
float circleLife = 0.0;
int lastTobjID, pLastTobjID = -1;

void setup() {
  //size(1000, 800, P3D);
  fullScreen(P3D);
  frameRate(60);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);
  //noCursor();
  ws = new WebsocketServer(this, 8080, "/switch-page");
  server = new SimpleHTTPServer(this);
  server.serveAll("");
  server.printAllContexts();
  minim = new Minim(this);
  
  //player = minim.loadFile("audio/bikimiSound.mp3");
  //player = minim.loadFile("audio/holy1.mp3");
  //player = minim.loadFile("audio/ice01.mp3");
  //player = minim.loadFile("audio/ice02.mp3");
  //player = minim.loadFile("audio/mizu01.mp3");
  //player = minim.loadFile("audio/pon.mp3");
  //player = minim.loadFile("audio/receipt05.mp3");
  player = minim.loadFile("audio/Sparkle03.mp3");
  //player = minim.loadFile("audio/Sparkle04.mp3");
  //player = minim.loadFile("audio/water11.mp3");
  //player = minim.loadFile("audio/water13.mp3");
  //player = minim.loadFile("audio/water14.mp3");
  
  tuioClient  = new TuioProcessing(this);
  particleSystems = new ParticleSystem[PARTICLE_SYSTEM_NUM];
  for (int i = 0; i < PARTICLE_SYSTEM_NUM; i++) {
    particleSystems[i] = new ParticleSystem(i);
  }
}

void draw() {
  //background(0);
  fill(0, 10);
  rect(0, 0, width, height);
  fill(255);
  noStroke();
  for (int i = 0; i < PARTICLE_SYSTEM_NUM; i++) {
    particleSystems[i].draw();
  }


  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();

  if (tuioObjectList.size() > 0) {
    int lastTobjID = tuioObjectList.get(0).getSymbolID() + 1;
    if (pLastTobjID != lastTobjID) webplay(lastTobjID);
    //println("lastTobjID : ", lastTobjID);
    pLastTobjID = lastTobjID;
  }

  for (int i=0; i < tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);
    //println(i, " : ", (int)tobj.getSymbolID());
    PVector markerLoc = new PVector(tobj.getScreenX(width), tobj.getScreenY(height));

    for (int j = 0; j < PARTICLE_SYSTEM_NUM; j++) {
      if ((int)tobj.getSymbolID() == particleSystems[j].symbolId) {
        particleSystems[j].updateSpot(markerLoc);
        if (particleSystems[j].symbolId == 0) {
          particleSystems[j].gushing0(markerLoc);
          particleSystems[j].audioplay();
        }
        if (particleSystems[j].symbolId == 1) {
          particleSystems[j].gushing1(markerLoc);
          particleSystems[j].audioplay();
        }
        if (particleSystems[j].symbolId == 2) {
          particleSystems[j].gushing2(markerLoc);
          particleSystems[j].audioplay();
        }
        if (particleSystems[j].symbolId == 3) {
          particleSystems[j].gushing3(markerLoc);
          particleSystems[j].audioplay();
        }
      }
    }
  }

  for (int i = 0; i < PARTICLE_SYSTEM_NUM; i++) {
    particleSystems[i].update(tuioObjectList.size() >= 1);
    if (particleSystems[i].particles.size() <= 0) {
      particleSystems[i].isHit = true;
    }
    //println(particleSystems[i].isHit);
  }

  //何もしてない時の円
  //if (tuioObjectList.size() <= 0) {
  //  fill(255, circleLife);
  //  ellipse(width/2, height/2, width/2, width/2);
  //  circleLife += 0.1;
  //  if (circleLife >= 10) circleLife = 10;
  //} else {
  //  circleLife = 0.0;
  //}
}


void webplay(int id) {
  ws.sendMessage(str(id));
}


//void keyPressed() {
//  if (key == '1' || key == '2' || key == '3' || key == '4') {
//    ws.sendMessage(str(key));
//  }
//}
