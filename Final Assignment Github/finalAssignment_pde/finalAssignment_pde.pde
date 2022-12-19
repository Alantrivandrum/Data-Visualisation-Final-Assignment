import java.util.ArrayList;
import java.util.Random;
import processing.svg.*;

ArrayList<Float> carat = new ArrayList<Float>();
ArrayList<String> cut = new ArrayList<String>();
ArrayList<String> colour = new ArrayList<String>();
ArrayList<String> clarity = new ArrayList<String>();
ArrayList<Float> depth = new ArrayList<Float>();
ArrayList<Float> tableList = new ArrayList<Float>();
ArrayList<Float> price = new ArrayList<Float>();
ArrayList<Float> x = new ArrayList<Float>();
ArrayList<Float> y = new ArrayList<Float>();
ArrayList<Float> z = new ArrayList<Float>();
ArrayList<Float> cutValues = new ArrayList<Float>();
ArrayList<Float> normalizedPrice = new ArrayList<Float>();
ArrayList<Float> angles = new ArrayList<Float>();
int length =0;
Random rand = new Random();
color colours = color(0,0,0);
int paddingX = 100;
int paddingY = 100;
int count = 0;
boolean mark = false;
boolean clarityBool = false;


void setup(){
 background(120);
 fullScreen();
 Table table = loadTable("/../diamonds.csv","header");
 loadData(table);
}



void draw(){
  //background(120);
 //int i = rand.nextInt(1,4);
 //changeBorderColour(i);
 //drawBorder(colours);
 drawDashboard(paddingX,paddingY);
 drawGraph1(mark);  
 drawGraph2(count);
 drawGraph3(clarityBool);
 makeButtons();
 drawLegend();
 //delay(500);

}

void loadData(Table table){
      for(TableRow row: table.rows()){
        length++;
        carat.add(row.getFloat("carat"));
        cut.add(row.getString("cut"));
        colour.add(row.getString("color"));
        clarity.add(row.getString("clarity"));
        depth.add(row.getFloat("depth"));
        tableList.add(row.getFloat("table"));
        price.add(row.getFloat("price"));
        x.add(row.getFloat("x"));
        y.add(row.getFloat("y"));
        //angles = setAnglesCut(cut);
      }

}

void drawGraph1(boolean mark){
   for(int i=0; i<10; i++){
    line(paddingX,paddingY+50*i,paddingX+500, paddingY+50*i);
    line(paddingX+50*i,paddingY,paddingX+50*i, paddingY+500);
    fill(0);
    textSize(10);  
    text(1-i*0.1,paddingX-35,paddingY+5+(50*i));
    text(0.1+i*0.1,paddingX+37+(50*i),paddingY+520);
  }
  textSize(20);
  text("x",paddingX+250,paddingY+550);  
  text("y",paddingX-55,paddingY+250); 
    
  if(!mark){
    stroke(0);
    strokeWeight(2);
    fill(255,0,0);
    for(int i=0; i<length; i++){
      if(x.get(i)*45 < paddingX+500 && x.get(i)*45 >paddingX){
      circle((x.get(i)*45), y.get(i)*45,carat.get(i)*20 );
      }
    }
  }
  else{
    stroke(0);
    strokeWeight(1);
    for(int i=0; i<length; i++){
      if(x.get(i)*45 < paddingX+500 && x.get(i)*45 >paddingX){
       if(carat.get(i)>1){
        fill(255,0,0);
        circle((x.get(i)*45), y.get(i)*45,30);
      }
      else if(carat.get(i)<=1 && carat.get(i)>0.8){
        fill(255,255,102);
        rect(x.get(i)*45,y.get(i)*45,20,20);
      }
      else if(carat.get(i)<= 0.8 &&carat.get(i) >0.5 ){
        fill(0,255,0);
        triangle((x.get(i)*45)+20,y.get(i)*45,x.get(i)*45,y.get(i)*45,x.get(i)*45,(y.get(i)*45)+20);
      }
      else{
        fill(0,0,255);
        rect(x.get(i)*45,y.get(i)*45,30,10);
      }
    }
  }
}
}

void drawGraph2(int count){
  stroke(0);
  strokeWeight(2);
  float posX = paddingX+620;
  float posY = paddingY+500;
  for(int i=0; i<25; i++){
    fill(0,0,255);
    rect(posX,posY,-tableList.get(i+count*25)*0.356,-depth.get(i+count*25)*5);
    //line(posX,posY,posX,posY+10);
    fill(0);
    textSize(10);
    text(i+ (count*25) +1, posX-15, posY+20);
    if(i>0){
    posX += tableList.get(i+(count*25)-1)*0.3457;
    }
    else{
      posX += tableList.get(i+(count*25))*0.3457;
    }
  }
  textSize(15);
  text("Table", paddingX+825, paddingY+550 );
  for(int i=0; i<10; i++){
    line(paddingX+590,paddingY+50*i,paddingX+600, paddingY+50*i);
    text(100-i*10,paddingX+565,paddingY+5+(50*i));  
  }
  //textSize(20);
  //fill(120);
  //stroke(120);
  //rect(paddingX+800,paddingY-40,100,30);    
  //fill(0);
}


void drawGraph3(boolean clarityBool){
  stroke(0);
  strokeWeight(2);
  if(!clarityBool){
    angles = setAnglesCut(cut);
    pieChart1(490.0,angles); //<>//
  }
  else{
     angles = setAnglesClarity(clarity);
     pieChart2(490.0,angles);
  }

}

  void drawBorder(color colour){
    stroke(colour);
    strokeWeight(20);
    fill(255);
    rect(0,0,1920,1080);
  }
  color changePieChartColour(int i){
    if(i==0){
        return color(255,0,0);
    }
    if(i==1){
        return color(0,255,0);
    }
    if(i==2){
        return color(0,0,255);
    }
    if(i==3){
        return color(255,255,102);
    }
    if(i==4){
      return color(255,102,255);
    }
    if(i==5){
      return color(127,0,255);
    }
     if(i==6){
      return color(255,128,0);
    }
    return color(0);
  }
  
  void drawDashboard(int paddingX, int paddingY){
    fill(255);
    rect(paddingX, paddingY, 500, 500);
    rect(paddingX+600, paddingY, 500, 500);
    rect(paddingX+1200   , paddingY, 500, 500);
  }
  
 void increasePage(){
   count++;
 }
  void decreasePage(){
    if(count>0){
     count--;
    }
 }
 
//void changeGraph2(){
//  if(mousePressed == true && mouseX>paddingX+600 && mouseX<paddingX+800 && mouseY > paddingY+600 && mouseY < paddingY+650 )
//  {
//    increasePage();
//  }
//  if(mousePressed == true && mouseX>paddingX+900 && mouseX<paddingX+1100 && mouseY > paddingY+600 && mouseY < paddingY+650 )
//  {
//    decreasePage();
//  }
//}

void mousePressed(){
  if(mouseX>paddingX+600 && mouseX<paddingX+800 && mouseY > paddingY+600 && mouseY < paddingY+650){
    increasePage();
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
    text("Page: "+ count, paddingX+820, paddingY + 630  );
  }
  else if(mouseX>paddingX+900 && mouseX<paddingX+1100 && mouseY > paddingY+600 && mouseY < paddingY+650){
    decreasePage();
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
    text("Page: "+ count, paddingX+820, paddingY + 630  );
  }
   else if(mouseX>paddingX+300 && mouseX<paddingX+500 && mouseY > paddingY+600 && mouseY < paddingY+650){
    mark = true;
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
  }
   else if(mouseX>paddingX && mouseX<paddingX+200 && mouseY > paddingY+600 && mouseY < paddingY+650){
    mark = false;
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
  }
   else if(mouseX>paddingX+1200 && mouseX<paddingX+1400 && mouseY > paddingY+600 && mouseY < paddingY+650){
    clarityBool = false;
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
  }
   else if(mouseX>paddingX+1500 && mouseX<paddingX+1700 && mouseY > paddingY+600 && mouseY < paddingY+650){
    clarityBool = true;
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
  }
    else if(mouseX>paddingX+650 && mouseX<paddingX+1050 && mouseY > paddingY+700 && mouseY < paddingY+750){
    clarityBool = false;
    mark = false;
    count = 0;
    background(120);
    drawDashboard(paddingX,paddingY);
    drawGraph1(mark);  
    drawGraph2(count);
    drawGraph3(clarityBool);
    makeButtons();
    drawLegend();
  }
}

void makeButtons(){
  fill(255);
  stroke(0);
  strokeWeight(2);
  rect(paddingX+600, paddingY+600,200,50);
  fill(0,0,255);
  textSize(20);
  text("Next 25 ", paddingX+666, paddingY+633);
  fill(255);
  rect(paddingX+900, paddingY+600,200,50);
  fill(0,0,255);
  textSize(20);
  text("Last 25 ", paddingX+966, paddingY+633);
  fill(255);
  rect(paddingX, paddingY+600,200,50);
  fill(255,0,0);
  textSize(20);
  text("Size Encoding ", paddingX+26, paddingY+633);
  fill(255);
  rect(paddingX+300, paddingY+600,200,50);
  fill(255,0,0);
  textSize(20);
  text("Mark/Colour Encoding ", paddingX+305, paddingY+633);
  fill(0,255,0);
  rect(paddingX+1200, paddingY+600,200,50);
  fill(0);
  textSize(20);
  text("Diamond Cut", paddingX+1240, paddingY+633);
  fill(0,255,0);
  rect(paddingX+1500, paddingY+600,200,50);
  fill(0);
  textSize(20);
  text("Diamond Clarity", paddingX+1526, paddingY+633);
  fill(255,255,127);
  rect(paddingX+650, paddingY+700,400,50);
  fill(0);
  textSize(30);
  text("Reset to Default", paddingX+750, paddingY+735);
}

public static float cutToValue(String cut){
  if(cut.equals("Ideal")){
    return 100;
  }
  else if(cut.equals("Premium")){
    return 80;
  }
  else if(cut.equals("Very Good")){
    return 60;
  }
  else if(cut.equals("Good")){
    return 40;
  }
  else{
    return 20;
  }
}

ArrayList<Float> normalizeValues(ArrayList<Float> prices, float min, float max){
  ArrayList<Float> normalizedPrices = new ArrayList<Float>();
  for(int i=0; i<length; i++){
        normalizedPrices.add((prices.get(i)-min)/(max-min));
      }
  
  return normalizedPrices;
}


float findMax(ArrayList<Float> prices){
  float max = Float.MIN_VALUE;;
  for(float price: prices){
    if(price>max){
      max = price;
  }
}
return max;
}

float findMin(ArrayList<Float> prices){
  float min = Float.MAX_VALUE;
  for(float price: prices){
    if(price<min){
      min = price;
  }
}
return min;
}



void pieChart1(float diameter, ArrayList<Float> data) {
  float lastAngle = 0;
  for (int i = 0; i < data.size(); i++) {
    fill(changePieChartColour(i  ));
    arc(paddingX+1450, paddingY+250, diameter, diameter, lastAngle, lastAngle+radians(data.get(i)));
    lastAngle += radians(data.get(i));
  }
}

void pieChart2(float diameter, ArrayList<Float> data) {
  float lastAngle = 0;
  for (int i = 0; i < data.size(); i++) {
    fill(changePieChartColour(i));
    arc(paddingX+1450, paddingY+250, diameter, diameter, lastAngle, lastAngle+radians(data.get(i)));
    lastAngle += radians(data.get(i));
  }
}

ArrayList<Float> setAnglesCut(ArrayList<String> list){
  ArrayList<Float> angles = new ArrayList<Float>();
  float idealCount =0;
  float premiumCount =0;
  float vGCount = 0;
  float gCount = 0;
  float fCount = 0;
 
  for(int i =0; i<length; i++){
    if(list.get(i).equals("Ideal")){
       idealCount++;
   }
    else if(list.get(i).equals("Premium")){
      premiumCount++;
    }
    else if(list.get(i).equals("Very Good")){
      vGCount++;
    }
    else if(list.get(i).equals("Good")){
     gCount++;
    }
    else if(list.get(i).equals("Fair")){
      fCount++;
    }
  }
  
  angles.add((idealCount/length)*360);
  angles.add((premiumCount/length)*360);
  angles.add((vGCount/length)*360);
  angles.add((gCount/length)*360);
  angles.add((fCount/length)*360);
  
  
  
  return angles;
}



ArrayList<Float> setAnglesClarity(ArrayList<String> list){
  ArrayList<Float> angles = new ArrayList<Float>();
  float I1 =0;
  float SI2 =0;
  float SI1 = 0;
  float VS2 = 0;
  float VS1= 0;
  float VVS2= 0;
  float VVS1 = 0;
  float IF =0;
 
  for(int i =0; i<length; i++){
    if(list.get(i).equals("I1")){
       I1++;
   }
    else if(list.get(i).equals("SI2")){
      SI2++;
    }
    else if(list.get(i).equals("SI1")){
      SI1++;
    }
    else if(list.get(i).equals("VS2")){
     VS2++;
    }
    else if(list.get(i).equals("VS1")){
      VS1++;
    }
    else if(list.get(i).equals("VVS2")){
      VVS2++;
    }
    else if(list.get(i).equals("VVS1")){
      VVS1++;
    }
     else if(list.get(i).equals("IF")){
      IF++;
    }
  }
  
  angles.add((I1/length)*360);
  angles.add((SI2/length)*360);
  angles.add((SI1/length)*360);
  angles.add((VS2/length)*360);
  angles.add((VS1/length)*360);
  angles.add((VVS2/length)*360);
  angles.add((VVS1/length)*360);
  angles.add((IF/length)*360);
  
  
  
  return angles;
}

void drawLegend(){
  fill(255);
  rect(paddingX, paddingY+800,1750,150);
  textSize(30);
  fill(0);
  text("Legend",paddingX+780,paddingY+890);
  drawTitle();
  text("Scatter plot (size encoding)", paddingX+35, paddingY+820);
  line(paddingX+300,paddingY+800,paddingX+300,paddingY+950);
  text("Scatter plot (mark/colour encoding)", paddingX+325, paddingY+820);
  line(paddingX+650,paddingY+800,paddingX+650,paddingY+950);
  line(paddingX+1025,paddingY+800,paddingX+1025,paddingY+950);
  text("Pie Chart (Cut)", paddingX+1150, paddingY+820);
  line(paddingX+1400,paddingY+800,paddingX+1400,paddingY+950);
  text("Pie Chart (Clarity)", paddingX+1500, paddingY+820);
  fill(255,0,0);
  circle(paddingX+40,paddingY+895, 5);
  circle(paddingX+75,paddingY+890, 20);
  circle(paddingX+125,paddingY+875, 50);
  circle(paddingX+200,paddingY+875, 75);
  textSize(15);
  fill(0);
  text("0.1",paddingX+30,paddingY+920);
  text("0.4",paddingX+65,paddingY+920);
  text("1",paddingX+120,paddingY+920);
  text("1.5",paddingX+190,paddingY+925);
  fill(255,0,0);
  circle(paddingX +350,paddingY+875,30);
  fill(255,255,102);
  rect(paddingX+425,paddingY+865,20,20);
  fill(0,255,0);
  triangle(paddingX+500+20,paddingY+865,paddingX+500,paddingY+865,paddingX+500,paddingY+865+20);
  fill(0,0,255);
  rect(paddingX+575,paddingY+870,30,10);
  fill(0);
  text(">1.00",paddingX+340,paddingY+920);
  text(">0.8",paddingX+420,paddingY+920);
  text(">0.5",paddingX+495,paddingY+920);
  text("<=0.5",paddingX+575,paddingY+920);
  fill(255,0,0);
  rect(paddingX+1100,paddingY+865,20,20);
  fill(255,255,127);
  rect(paddingX+1150,paddingY+865,20,20);
  fill(0,255,0);
  rect(paddingX+1200,paddingY+865,20,20);
  fill(0,0,255);
  rect(paddingX+1250,paddingY+865,20,20);
  fill(255,102,255);
  rect(paddingX+1300,paddingY+865,20,20);
  
  fill(255,0,0);
  rect(paddingX+1420,paddingY+865,20,20);
  fill(255,255,127);
  rect(paddingX+1460,paddingY+865,20,20);
  fill(0,255,0);
  rect(paddingX+1500,paddingY+865,20,20);
  fill(0,0,255);
  rect(paddingX+1540,paddingY+865,20,20);
  fill(255,102,255);
  rect(paddingX+1580,paddingY+865,20,20);
  fill(127,0,255);
  rect(paddingX+1620,paddingY+865,20,20);
  fill(255,128,0);
  rect(paddingX+1660,paddingY+865,20,20);
  fill(0);
  rect(paddingX+1700,paddingY+865,20,20);
  
  fill(0);
  text("Ideal",paddingX+1095,paddingY+920);
  text("Prem",paddingX+1145,paddingY+920);
  text("V.Good",paddingX+1195,paddingY+920);
  text("Good",paddingX+1245,paddingY+920);
  text("Fair",paddingX+1295,paddingY+920);
  
  
  text("I1",paddingX+1425,paddingY+920);
  text("SI2",paddingX+1460,paddingY+920);
  text("SI1",paddingX+1500,paddingY+920);
  text("VS2",paddingX+1540,paddingY+920);
  text("VS1",paddingX+1580,paddingY+920);
  text("VVS2",paddingX+1620,paddingY+920);
  text("VVS1",paddingX+1660,paddingY+920);
  text("IF",paddingX+1705,paddingY+920);
  
}
  

void drawTitle(){
  fill(0);
  textSize(20);
  if(mark==false){
  text("Scatter plot of X vs Y with Carat encoded as size",paddingX, paddingY-10);
  }
  else{
  text("Scatter plot of X vs Y with Carat encoded as colour and mark",paddingX, paddingY-10);
  }
  text("Vertical Histogram of Table values vs Depth values",paddingX+600,paddingY-10);
  if(clarityBool==false){
    text("PieChart showing proportions of each type of Cut",paddingX+1200,paddingY-10);
  }
  else{
    text("PieChart showing proportions of each type of Clarity",paddingX+1200,paddingY-10);
  }
}
