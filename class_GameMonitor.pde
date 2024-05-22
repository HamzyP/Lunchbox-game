import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Arrays;

class GameMonitor 

{
  //GameMonitor properties
    //String[] requiredItems = {"Sandwich", "Apple", "Drink"};
    //String[] requiredItems = {"sandwich"};
    List<String> requiredItems = new ArrayList<>(Arrays.asList("apple"));
    String[] items = {"apple", "sandwich", "drink"};
    String level = "One"; // sets level to one
    int score = 0;
    PFont font;
    float x, y;
    boolean isGameOver = false;
     String[] lines = loadStrings(sketchPath("HighScore.txt")); // gets the high score and stores in array
    int high = int(lines[0]); // extracts score from array
    
    
    // Constructor
    GameMonitor(float x, float y) {
        this.x = x;
        this.y = y;
        font = createFont("Arial", 16, true); // selects font
    }
    // METHODS:
    
    // displays the required items
    void displayRequiredItems() {
        fill(0); // black color for text
        textFont(font, 16); //sets font and text size
        textAlign(CENTER, TOP); // Align text to the left and top
        text("Required Items:", x, y); // Display the heading
        
        float itemY = y + 30; // Start a little below the heading
        for (String item : requiredItems) {
            text(item, x, itemY); // Display each required item
            itemY += 20; // Move down for the next item
        }
    }

    // Method to display the score 
    void displayScore() {
        fill(255); // White color for text
        textFont(font, 16); // Set the font and size for the text
        textAlign(LEFT, TOP); // Align text to the left and top
        text("Score: " + score, 10,15); // Position the score 
        
        text("Level:" + level, 300, 15);
       String[] lines = loadStrings(sketchPath("HighScore.txt"));
        text("High score: " + lines[0],550, 15);
    }
    
    
    // Method to draw the GameMonitor contents
    void update() {
        displayRequiredItems();
        displayScore();
    }
    
        //checks if the items in the lunchbox matches the required items
    void checkLunchboxContents(ArrayList<Item> lunchboxItems) {
        boolean allItemsMatch = true; // a flag to keep track of whether all the items match
         if (lunchboxItems.size() != requiredItems.size()) {
               allItemsMatch = false; // end the game because if there's too many items then the lunchbox cannot be right
            }
        
        // checks if all required items are in the lunchbox
        for (String requiredItem : requiredItems) {
            boolean itemFound = false; // a flag to check if the individual required item is found in the lunchbox
            for (Item item : lunchboxItems) {
              //println(requiredItem);
              //println(item.name);
                if (item.name.equals(requiredItem)) {
                  //if (item.name == requiredItem) {
//.equals is better practice vs == as it compares the content of the string instead of memory addresses
                    itemFound = true;
                    break;
                }
            }
            // if any required item is not found, set the flag to false
            if (!itemFound) {
                allItemsMatch = false;
                break;
            }
        }
        
        // if all items match, update the score
        if (allItemsMatch) {
            score = score + 10; //adds 10 points to the score for each correct lunchbox.
            if(score >100){ // if score > 100 change level to four
              level = "Four";
            }
            else if (score > 60 ){ // if score> 60 then go to level three
                                                                                                                                                                                                                                                                                                                                                                                                                                      
            level = "Three";
            lunchbox.lunchSpeed = 2.5;
            }
            else if(score>30){// if score > 30 change level to 2
            level = "Two";
            }
            
            Random random = new Random();
            requiredItems.clear(); // empties the list 
            
              if ("One".equals(level)) {
                int a = random.nextInt(items.length);
                requiredItems.add(items[a]);
            } 
            
            else if ("Two".equals(level)) {
              String[] items = {"apple", "sandwich", "drink","banana"};
                
              for (int i = 0; i < 2; i++) { // iterate twice so it adds 2 random items
                    int a = random.nextInt(items.length);
                    requiredItems.add(items[a]);
                }
            }
            
            else if ("Three".equals(level)) {
              String[] items = {"apple", "sandwich", "drink","banana"};
                
              for (int i = 0; i < 3; i++) { // iterate thrice to add 3 random items
                    int a = random.nextInt(items.length);
                    requiredItems.add(items[a]);
                }
            }
            
            else {
              String[] items = {"apple", "sandwich", "drink","banana"};
                
              for (int i = 0; i < 5; i++) { // iterate five times to add 5 random items
                    int a = random.nextInt(items.length);
                    requiredItems.add(items[a]);
                }
            }
            }
        
        
        else {
            //println("game over");
            gameMonitor.setGameOver(); // sets the game over state
        }
    }
   

      void displayGameOverScreen() {
             // draws a big rectangle over the entire screen
          fill(0, 0, 0, 150); // Black color with transparency
          rect(0, 0, width, height);
          // displays the score and tells user to press spacebar to restart
          fill(255); // 255 is white
          textSize(32);
          textAlign(CENTER, CENTER);
          text("Game Over! Your Score: " + score, width / 2, (height / 2)-150);
          if(high< score){
           
           high = score;
                 // File path 
                String filename = "HighScore.txt";
                // Use 'PrintWriter' to write to a file
                PrintWriter output = createWriter(filename);
                // Append the score to the file
                output.println(score);
                output.flush();
                // Close the file to finish writing
                output.close();

          }
        
          text("Press your spacebar to restart the game. ", width / 2, (height / 2)+140);
      }
      
      // sets game state to game over 
      void setGameOver(){
       isGameOver = true;
     }

        //resets the game
    void resetGame() {
        score = 0;        // resets the score to 0
        //String[] lines = loadStrings(sketchPath("HighScore.txt"));
        //int high = int(lines[0]);
        isGameOver = false; // resets the gameover flag
        level = "One";  // resets level
        lunchbox.lunchSpeed = 2; // resets speed
        requiredItems.clear(); // clears required items
        // creates one item to restart the game essentially
        Random random = new Random();
        int random_number = random.nextInt(items.length);
        requiredItems.add(items[random_number]);


    }

}
