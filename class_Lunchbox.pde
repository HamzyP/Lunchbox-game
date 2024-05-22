import java.util.Iterator;

class Lunchbox {
  //properties
    float x, y, new_x; // Position
    float width, height; // Size
    PImage image; // Image of the lunchbox (optional rn)
    // a list to keep track of items added to the lunchbox
    ArrayList<Item> addedItems;
    boolean itemAdded = false; // flag used to time the message display
    String message = "";
    int messageStartTime;  // when the message starts
    int messageDuration = 1500;  // how long to display message (2000 milliseconds = 2 seconds)
    float lunchSpeed = 2;
    PFont font = createFont("Arial Bold", 16); // changes font to arial-bold, size 16
    
    //constructor
    Lunchbox(float x, float y, float width, float height, float new_x) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.addedItems = new ArrayList<Item>(); // creates array for inventory
        this.new_x = new_x;
        this.image = loadImage("lunchbox.png");
        
    }
    
    // METHODS
    
        // Update method for the lunchbox
    void update() {
        move();          // Move the lunchbox
        removeItems();        // Remove items if needed
        handleOffScreen();    // Handle off-screen behavior
        displayMessage(message);     // Display any messages
        displayInventory();   // Display the inventory
        
    }
    
    
    void display() {
        // Displays the lunchbox
        fill(150); // Sets lunchbox color // grey 150
        rect(x, y, width, height); //  lunchbox as a rectangle
        image(image,x,y);

        image.resize(int(width),int(height));

    }
    // Moves the lunchbox
    void move() {
        x -= lunchSpeed;
    }

    //checks if an item is colliding with the lunchbox
    boolean isItemColliding(Item item) {
        return item.isVisible && item.x + item.width > this.x && item.x < this.x + this.width &&
               item.y + item.height > this.y && item.y < this.y + this.height;
    }




    //Handles an item being added to the lunchbox
    void addItem(Item item) {
      // Checks if the item is not already in the lunchbox
      if (!addedItems.contains(item)){
          // Adjust item position relative to the lunchbox
          item.x = this.x + (this.width - item.width) / 2; 
          item.y = this.y + (this.height - item.height) / 2;
          item.isDragging = false; // Disables dragging of the item
          addedItems.add(item); // Add the item to the lunchbox
          itemAdded = true; // sets the 'flag' to true when an item is added
          message = "Item added to the lunchbox" ; // the message to show when an item is added to the lunchbox
          messageStartTime = millis();  // records the time when the item is added so we can display the message on time and for a set duration
      }
      }
    
    boolean shouldDisplayMessage() {
      //println(addedItems);
      //print("x");
        return itemAdded && millis() - messageStartTime < messageDuration; // True when message should be displayed and after messageDuration has elapsed returns False.
    }
    
    //Removes an item
      void removeItem(Item item) {
          if (addedItems.contains(item)) {
              addedItems.remove(item);  // removes item from addedItems
          }
    }

    String getItemsList() {
        StringBuilder itemList = new StringBuilder(); // creates item list for display
        for (Item item : addedItems) {
            itemList.append(item.name).append("\n"); // changes each item's name or description with a newline
        }
        return itemList.toString();
    }
    
    
    //void itemCollision(Item item){
    //  if (lunchbox.isItemColliding(item) && !item.isDragging) { 
    //        lunchbox.addItem(item);
    //    }
    //}
    
    void removeItems(){
              // Checks for items to be removed from the lunchbox
    Iterator<Item> it = addedItems.iterator(); // iterator is here to avoid the 'ConcurrentModificationException' error 
    while (it.hasNext()) {
        Item item = it.next();
        if (item.shouldBeRemoved) {
            it.remove(); // Safely removes the item from the lunchbox
            item.shouldBeRemoved = false; // resets the 'flag'
        }
      }
    }
    
    // Method to display a message if needed with a timer
     void displayMessage(String message) {
        if (shouldDisplayMessage()) {
            fill(0); // Set text color to white
            textSize(20); // Set text size
            textFont(font);
            text(message, 250, 166); // Display the message text,x,y
            if (millis() - messageStartTime > messageDuration) {
                itemAdded = false; // Reset the flag once the message has been displayed
            }
        }
    }
    
        // displays inventory list
    void displayInventory() {
        fill(0); // Sets text color to black
        textSize(16); // Sets text size
        text("Lunchbox Inventory:", 180, 215); // Display the heading
        text(getItemsList(), 150, 310); // Display the items list
    }
    

    
        // handles off-screen behavior of lunchbox
    void handleOffScreen() {
        if (this.x +this.width < 0) {
            this.x = this.new_x; // resets the lunchbox position
            // function to check if items are correct and updates the score sytem here
           gameMonitor.checkLunchboxContents(addedItems); 
        }
    }
}
