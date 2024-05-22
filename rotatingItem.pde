
class RotatingItem extends Item {
    boolean isHorizontal;
    float rotationAngle = radians(90);
    // Constructor
    RotatingItem(float x, float y, int width, int height, PImage img, Lunchbox lunchbox, String name) {
        super(x, y, width, height, img, lunchbox, name); // Call the superclass (Item) constructor
        this.isHorizontal = false;
    }

    // rotates the item 90 degrees
    void rotate90() {
        isHorizontal = !isHorizontal; 
        rotationAngle += radians(90); // adds rotation by 90 degrees
        rotationAngle %= radians(360); // keeps the angle 0-360
    }
    
    //check if item is horizontal
    boolean isHorizontal(){
      return isHorizontal;
    }
    
    void display() {
        if (isVisible) {
            updateDrag();
            pushMatrix(); // begins item translation/change
            translate(x + width / 2, y + height / 2);
            rotate(rotationAngle); //this is what rotates the item
            image(img, -width/2, -height/2, width, height);
            popMatrix(); // finishes the change of the item
            
        }
      }

}
