class TrashBin {
  // properties 
    float x, y; // Position of the trash bin
    float width, height; // Size of the trash bin
    color binColour; // Colour of the trash bin
    
    
    //constructor
    TrashBin(float x, float y, float width, float height, color c) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.binColour = c;
        
    }

    // methods:

    void display() {
        fill(binColour);
        rect(x, y, width, height); // Draw the trash bin as a rectangle
        
        // draws the 'x' on the trash can.
        line(x,y, x+width, y+height); 
        line(x+width,y, x, y+height);
        
        
        rect(stationX + 305,stationY +25,50,20); // rectangle around trash label
        fill(0);
        text("Trash", stationX + 330, stationY +35); // trash label
    }

    // Check if an item is over the bin
    boolean isItemOver(Item item) {
        return item.x + item.width > x && item.x < x + width &&
               item.y + item.height > y && item.y < y + height;
    }
    
        // Method to check and handle item interaction with the trash bin
    void checkInteraction(Item item) {
        if (isItemOver(item) && !mousePressed) {
            item.hide(); // Hide the item if it's over the trash bin and the mouse is released
        }
    }
}
