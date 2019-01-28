void setup(){
  size(2000,2000);
  
  //print(perpBis(p2,p3).getSlope());
}

Point intersection(Line L1, Line L2){ 
  if(L1.getX() == L2.getX() && L1.getY() == L2.getY()){
    return new Point(L1.getX(),L2.getY());
  }
  if(L1.getSlope() == L2.getSlope()){return null;}
  float S1 = L1.getSlope();
  float S2 = L2.getSlope();
  
  float a = L1.getY() - S1 * L1.getX();
  float b = L2.getY() - S2 * L2.getX();
  
  //(S2/S1)*(a - (S1 * b / S2))
  float Iy = (a - (S1 * b / S2)) / (1 - (S1/S2));
  float Ix = ((Iy-a)/S1);
  
  //println("b: "+b);
  //println("slope of line 1: "+S1);
  //println("slope of line 2: "+S2);
  //println("vertex of line 1: ("+L1.getX()+", "+L1.getY()+")");
  //println("vertex of line 2: ("+L2.getX()+", "+L2.getY()+")");
  //print("("+Ix+", "+Iy+")");
  
  return new Point(Ix,Iy);
}

Line perpBis(Point p1, Point p2){
  float midX = (p1.getX()+p2.getX())/2;
  float midY = (p1.getY()+p2.getY())/2;
  return new Line(midX,midY,-1/p1.getSlopeTo(p2));
}

class Line extends Point{
  float slope;
  
  Line(float x, float y, float Slope){
    super(x,y);
    slope = Slope;
  }
  float getSlope(){return slope;}
  
  //returns null if they never intersect
  //returns the vertex if they intersect infinitely many times
  //otherwise, returns a new Point with the x and y of where they intersect

}

class Point{
  float x;
  float y;
  
  Point(float X, float Y){
    x = X;
    y = Y;
  }
  
  float getX(){return x;}
  float getY(){return y;}
  
  void setX(float X){x = X;}
  void setY(float Y){y = Y;}
  
  float getSlopeTo(Point p2){
    float rise = p2.getY() - y; //Yf - Yo
    float run = p2.getX() - x; //Xf - Xo
    float slope = rise/run;
    return slope;// returns rise over run
  }
}

Point p1 = new Point(2,3);
Point p2 = new Point(4,7);
Point p3 = new Point(5,8);

int size = 2000;
float scale = 40;

void displayPoint(Point p){
  float px = cX(p.getX());
  float py = cY(p.getY());
  strokeWeight(10);
  line(px,py,px,py);
  textSize(20);
  //String s = ;
  fill(0, 0, 0);
  text("   ("+Math.round(p.getX()*100.0)/100.0+","+Math.round(p.getY()*100.0)/100.0+")", px, py); 
}

void draw(){
  if(keyPressed){
    if (key == '1') {
      pointFollow(p1);
    } else if (key == '2') {
      pointFollow(p2);
    } else if (key == '3') {
      pointFollow(p3);
    } 
  }
  
  
  background(color(255));
    Point center = intersection(perpBis(p1,p2),perpBis(p2,p3));
  displayPoint(p1); displayPoint(p2); displayPoint(p3); displayPoint(center);
  strokeWeight(1);
  
  //draw the x and y axes
  line(0,size/2,size,size/2);
  line(size/2,0,size/2,size);
  
  //draw the slopes between p1,p2 and p2,p3 and p1,p3
  line(cX(p1.getX()),cY(p1.getY()),cX(p2.getX()),cY(p2.getY()));
  line(cX(p3.getX()),cY(p3.getY()),cX(p2.getX()),cY(p2.getY()));
  line(cX(p3.getX()),cY(p3.getY()),cX(p1.getX()),cY(p1.getY()));
  

  
  
  noFill();
  ellipseMode(RADIUS);
  if(center != null){
    //draw perpendicular bisectors
    line(
      cX((p2.getX()+p1.getX())/2),
      cY((p2.getY()+p1.getY())/2),
      cX(center.getX()),
      cY(center.getY())
    );
    line(
      cX((p2.getX()+p3.getX())/2),
      cY((p2.getY()+p3.getY())/2),
      cX(center.getX()),
      cY(center.getY())
    );
    line(
      cX((p3.getX()+p1.getX())/2),
      cY((p3.getY()+p1.getY())/2),
      cX(center.getX()),
      cY(center.getY())
    );
    strokeWeight(3);
    double radius = sqrt(pow(center.getX()-p1.getX(),2) + pow(center.getY()-p1.getY(),2));
    ellipse(cX(center.getX()),cY(center.getY()),(float)radius*scale,(float)radius*scale);
  }
}

float cX(float old){//converts ugly x values into pretty ones
  return (size/2)+old*scale;
}

float cY(float old){//ditto but for y
  return (size/2)-old*scale;
}

float dX(float ans){//converts pretty x values into ugly ones
  return (ans - (size/2))/scale;
}

float dY(float ans){//ditto but for y
  return -(ans - (size/2))/scale;
}

void pointFollow(Point p){
  p.setX(dX(mouseX));
  p.setY(dY(mouseY));
}