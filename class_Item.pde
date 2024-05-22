class Item 
{
  // Item properties
    float x, y; // Position of the item
    PImage img;
    int width, height; // Size of the item
    color fillColour; // Colour of the item
    boolean isDragging = false; // checks to drag the item
    boolean isVisible = true; // tracks visibility of the item
    Lunchbox lunchboxRef;
    boolean shouldBeRemoved = false; // checks if item should be removed
    String name;

    
    
    // Constructor
    Item(float x, float y, int width, int height, PImage img, Lunchbox lunchbox,String name)
    {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        //this.fillColour = fillColour;
        this.img = img;
        this.lunchboxRef = lunchbox;
        this.name= name;

    }
    // METHODS:
    
    // displays the item
    void display()
    {
      //println("sad");
 
        if (isVisible) 
        {
            updateDrag();
            fill(fillColour);
            image(img,x,y);
            img.resize(50,50);
        }
    }
    

    

     // update drag status and position
    void updateDrag() {
        if (isMouseOver()) {
            if (mousePressed) {
                isDragging = true;
            }
        }
        if (isDragging) {
            if (mousePressed) {
                x = mouseX - width / 2; // follows centre of image since imageMode (CORNER);
                y = mouseY - height / 2;

            } else {
                isDragging = false;
                if (lunchboxRef.isItemColliding(this)) {
                                  // Check if the item is a RotatingItem and if it's not horizontal
                if (((this.name.equals("banana")) && !((RotatingItem) this).isHorizontal())){
                  //need to output text to tell user to rotate banana using mouse right click.


                  println("Banana does not fit in the lunchbox. Right click on banana to rotate it");


                }
                
                if (!(this.name.equals("banana")) || ((this.name.equals("banana")) && ((RotatingItem) this).isHorizontal())) {
                    lunchboxRef.addItem(this);
                }

                }
            }
        }
       if (!isDragging && !lunchboxRef.isItemColliding(this)&& lunchboxRef.addedItems.contains(this)) {
        //lunchboxRef.removeItem(this);
        shouldBeRemoved = true;
    }
    
    }
    
    // checks if the mouse is over the item
    boolean isMouseOver() {
        return mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height;
    }
    
    
     void hide() 
     {
        isVisible = false;
    }
    
    
    void is_item_on_belt(){ // Moves item if on the conveyor belt.
      if (this.y > 0  && this.y < 75)
         this.x = this.x - lunchbox.lunchSpeed;
    }
    

    

}
