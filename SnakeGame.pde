// adapted from Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// https://youtu.be/AaGK-fj-BAM

Snake s;
int scl = 20;
String status = "";
PVector food;
boolean gotFood;
boolean alive;

void setup() {
  size(600, 600);
  s = new Snake();
  alive = true;
  frameRate(10);
  setFoodLocation();
}

void keyPressed(){
  if(key=='w'){
    s.dir(0,-1);
  }if(key=='d'){
    s.dir(1,0);
  }if(key=='s'){
    s.dir(0, 1);
  }if(key=='a'){
    s.dir(-1, 0);
  }
}
  void draw() {
  background(51);
  // TODO: check whether the keyPressed variable is true.
  //       If it is, check which is key is pressed, using
  //       something like one of these: 
  //         if (key == 'a') ...
  //         if (keyCode == UP) ...
  //       Then move the snake appropriately, using these:
  //         s.dir(0, -1) moves the snake up
  //         s.dir(0, 1) moves the snake down
  //         s.dir(-1, 0) moves the snake left
  //         s.dir(1, 0) moves the snake right
  //       Then replace this comment with one of your own.
  text("Score="+s.total, 540, 10);
s.update();
s.checkForPulse();
  s.show();

  gotFood = s.eat(food);
  if(gotFood==true){
    setFoodLocation();
  }
  // TODO: Write code that checks if
  //       gotFood is true. If it is,
  //       then call the function
  //       setFoodLocation(). If it
  //       is not true, then do nothing.
  //       Then replace this comment with one of your own.
  
  fill(255, 0, 100);
  rect(food.x, food.y, scl, scl);
  
  status = "length: " + s.total;
  
  // TODO: Write code that displays 
  //       the current length of the snake.
  //       Then replace this comment with one of your own.
  //       If you need a hint, use the
  //       examples in the Processing docs:
  //       https://processing.org/reference/text_.html

  // TODO: Extensions...
  //       1. add a cheat. if mousePressed is true,
  //          increase "s.total" (without the quotes) by one.
  //       2. check if the snake is dead. If it is,
  //          tell the user that the game is over!
  //       3. after you do #2, give the user an option to
  //          restart the game (keyPress?)
  //       4. change any other parameters in the game (speed, size, colors, etc)
  //            - first tinker on your own
  //            - then ask a colleague if you need help or ideas
  //       Then replace this comment with one of your own. 
}


void setFoodLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}


class Snake{
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  int total = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();

  Snake() {
  }

  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  void dir(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  void checkForPulse() {
    for (int i = 0; i < tail.size(); i++) {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1) {
        total = 0;
        alive = false;
        tail.clear();
      }
    }
  }

  void update() {
    if (total > 0) {
      if (total == tail.size() && !tail.isEmpty()) {
        tail.remove(0);
      }
      tail.add(new PVector(x, y));
    }
    x = x + xspeed*scl;
    y = y + yspeed*scl;
  if(x>=590){
     x=0; 
    }if(x<=-10){
      x=600;
    }if(y>590){
     y=0; 
    }if(y<=-10){
     y=600; 
    }
    x = constrain(x, 0, width-scl);
    y = constrain(y, 0, height-scl);
  }
  void show() {
    fill(255);
    for (PVector v : tail) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
  }
  
  int getTotal() {
    return total;
  }
}
