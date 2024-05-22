// I am going to create a ' lunchboxes ' assembly line 
import java.util.Iterator;

PImage sandwich, apple, drink, banana;
ArrayList<Item> items; // creates an arraylist for items
TrashBin trashBin;
VisualDesign visualDesign;
Lunchbox lunchbox;
GameMonitor gameMonitor;


float stationX = 250; // X-coordinate of the station
float stationY = 440;  // Y-coordinate of the station
float stationWidth = 300; // Width of the station
float stationHeight = 100; // Height of the station
boolean spawn = false;
boolean check = true;


void setup() { 
    frameRate(60); // FPS of 60
    size(800, 600);
        
    color stationColor = color(192, 192, 192); // A wood-like brown color for the station
      lunchbox = new Lunchbox(width,  50, 125, 75 , width ); // Adjust position and size as needed // SECOND VALUE REFERS TO THE Y VALUE.
      sandwich = loadImage("sandwich.png");
      apple = loadImage("apple.png");
      drink = loadImage("drink.png");
      banana = loadImage("banana.png");
      


              // Check if the file exists
        String filePath = sketchPath("HighScore.txt"); // sketchpath is the same folder as the code.
        File file = new File(filePath); 
        if (!file.exists()) {
            // If the file does not exist, create it
            PrintWriter output = createWriter(filePath);
            output.println(0); //stores 0 in the file
            output.flush(); // to flush to write any buffered data
            output.close(); //closes connection
        }
    
      gameMonitor = new GameMonitor(590,210); // initialised for x,y for the REUQIRED ITEMS list
 
      items = new ArrayList<Item>();
      items.add(new Item(stationX+30, stationY+40, 80, 50 , sandwich,lunchbox, "sandwich"));
      items.add(new Item(stationX+130, stationY + 40, 30, 30 , apple, lunchbox, "apple"));
      items.add(new Item(stationX+230, stationY + 40, 20, 50 , drink,lunchbox, "drink")); //x,y,width,height, image,lunchbox,name
      
      //items.add(new RotatingItem(stationX-70, stationY + 40, 80, 50, banana, lunchbox, "banana"));

      
    visualDesign = new VisualDesign(stationX, stationY, stationWidth, stationHeight, stationColor);
    trashBin = new TrashBin(stationX + 305, stationY+50, stationWidth/6, stationHeight/2, color(128)); 
    //ellipse(280,480,50,50);

           
}



void draw() {  
    // makes the background grey on every refresh
    
    if (!gameMonitor.isGameOver) {
        // Update game elements
    
        background(64);
        
        visualDesign.drawStation();
        
        // does the bin function
        trashBin.display();
        lunchbox.display();
            // Process each item
        for (Item item : items) {
            item.is_item_on_belt(); // moves item if on belt
            item.display(); // displays the item
            trashBin.checkInteraction(item); // checks if item is going in the bin
 
      }
        
        // Update the lunchbox (includes movement, item removal, message and inventory display)
        lunchbox.update(); 
        gameMonitor.update();
        if (check && gameMonitor.level.equals("Two")){ // check is a boolean flag so we make sure we only spawn this once AND if the gamemonitor level is  2
          spawn = true;}
        if (spawn){
          items.add(new RotatingItem(stationX-80, stationY + 40, 70, 40, banana, lunchbox, "banana"));
            check = false; // starts out as true once its false here it stays false until the program is ran.
            spawn = false; // this can never be true again because check can never be true again
        }
    }
    
    else {
        // Draw the game over screen
        gameMonitor.displayGameOverScreen();
    }
}


void keyPressed() {
    if (key == ' ' && gameMonitor.isGameOver) { // checks if spacebar is pressed to restart the game
        gameMonitor.resetGame();
        
        
         boolean sandwichFound  = false;
         boolean appleFound = false;
          boolean drinkFound = false;
        // Check if a sandwich,apple,drink is at the spawn
        
        for (Item item : items) {
           if ("sandwich".equals(item.name) && item.x == stationX + 30 && item.y == stationY + 40) {
            sandwichFound = true;
            }
            
         if ("apple".equals(item.name) && item.x == stationX + 130 && item.y == stationY + 40) {
            appleFound = true;
        }
        
        if ("drink".equals(item.name) && item.x == stationX + 230 && item.y == stationY + 40) {
            drinkFound = true;
        }
            
        }
        
        // if the item isnt found then spawn in the new item
      if (!sandwichFound){
      items.add(new Item(stationX+30, stationY+40, 80, 50 , sandwich,lunchbox, "sandwich"));
      }
      if (!appleFound) {
      items.add(new Item(stationX+130, stationY + 40, 30, 30 , apple, lunchbox, "apple"));
      }
      if (!drinkFound) {
      items.add(new Item(stationX+230, stationY + 40, 20, 50 , drink,lunchbox, "drink"));
    }
    }
}

void mousePressed(){
      if (mouseButton == RIGHT) {
        for (Item item : items) {
            if (item instanceof RotatingItem && item.isMouseOver()) {
                ((RotatingItem) item).rotate90();
            }
        }
    }
   
   // this is for the banana order button
     if(mouseX >= stationX-80 && mouseX <= stationX-10 && mouseY >= stationY+100 && mouseY <= stationY+130 && !gameMonitor.level.equals("One")){
    items.add(new RotatingItem(stationX-80, stationY + 40, 70, 40, banana, lunchbox, "banana"));
  }
  // this is for the sandwich maker button
  if(mouseX >= stationX+20 && mouseX <= stationX+90 && mouseY >= stationY+100 && mouseY <= stationY+130){
    items.add(new Item(stationX+30, stationY+40, 80, 50 , sandwich,lunchbox, "sandwich"));
  }
  
   //apple order button
  if(mouseX >= stationX+120 && mouseX <= stationX+190 && mouseY >= stationY+100 && mouseY <= stationY+130){
    items.add(new Item(stationX+130, stationY + 40, 30, 30 , apple, lunchbox, "apple"));
  }
   //drink order button
   if(mouseX >= stationX+220 && mouseX <= stationX+290 && mouseY >= stationY+100 && mouseY <= stationY+130){
        items.add(new Item(stationX+230, stationY + 40, 20, 50 , drink,lunchbox, "drink"));
        }
}
