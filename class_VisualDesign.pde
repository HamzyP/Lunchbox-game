class VisualDesign 
{
  // properties 
    float stationX, stationY;
    float stationWidth, stationHeight;
    color stationColour;
  PFont font = createFont("Arial Bold", 16); // cahnges default font to arial-bold, size 16

  // constructor
    VisualDesign(float x, float y, float width, float height, color colour) 
    {
        stationX = x;
        stationY = y;
        stationWidth = width;
        stationHeight = height;
        stationColour = colour;
    }


    //METHODS:
    
    // creates the station visual
    void drawStation() 
    {
         strokeWeight(3); // makes the default line drawn thicker at 3 instead of thin at 1
        fill(stationColour); // grey ish colour
        rect(stationX, stationY, stationWidth, stationHeight); // bench where items are is drawn

        drawBelt(); // conveyor belt
        drawBoard();
        if (!gameMonitor.level.equals("One")){ // if level is not one then you get the banana upgrade station.
          upgradeStation();
        }
        drawLabels(); // labels say name of item
        drawButtons();
    }
    
    void upgradeStation(){
      rect(stationX-100, stationY, stationWidth+100, stationHeight);
      fill(100,0,150); // makes it  r,g,b
      rect(stationX-80,stationY+100,70, 30); // banana 
      textFont(font);
      fill(0);
      text("ORDER", stationX-70, stationY+110); // banana order button
      text("Banana", stationX -70, stationY + 5); // banana text
    }
    void drawBoard(){
          //  for tv screen required items
   
    strokeWeight(7); // makes the outer line thicker of the screen
    
    
    fill(175); // makes the background grey
    rect(450,200, 300,200); // x,y start , width, vertical length
    strokeWeight(2);
    line(450,230, 750, 230);
    strokeWeight(3); // changes strokeweight back to default value 
    
    // 'screen' for the Inventory items 
    strokeWeight(7); // makes the outer line thicker of the screen
    fill(175); // makes the background grey
    rect(50,200, 300,200); // x,y start , width, vertical length
    strokeWeight(2);
    line(50,230, 350, 230);
    
    
    // message bar
    stroke(255); // white
    rect(50,150, 450,30); // xStart, yStart, width , height
    stroke(0); // black
    textFont(font); // selects font
    fill(0); // changes fill colour to black
    text("Message: ", 60, 160); // 
    strokeWeight(3); // changes strokeweight back to default value 
    fill(175); // resets the fill colour
    }
    void drawButtons(){
      textFont(font);

      fill(100,0,150); // makes it  r,g,b
      rect(stationX+20,stationY+100,70, 30); // sandwich
      rect(stationX+120,stationY+100,70, 30); // apple
      rect(stationX+220, stationY+100, 70,30); // drink
      
      fill(0);
      text("MAKE", stationX+55, stationY+115); // sandwich
      text("ORDER", stationX+155, stationY+115);// apple
      text("ORDER", stationX+255, stationY+115);// drink

    }
     void drawLabels() 
        {
        textAlign(CENTER, CENTER);
        textSize(16);
        fill(0); // black text

        // Drawing labels for each item
        text("Sandwich", stationX + 50, stationY + 25);
        text("Apple", stationX + 150, stationY + 25);
        text("Drink", stationX + 250, stationY +25);
        
    }
    
    void drawBelt()
    {
     fill(0,255,0);
     rect( 0,50 ,800,  75); // x,y, x length, y length
      
    }
}
