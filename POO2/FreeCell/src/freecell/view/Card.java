// File  : cards-freesell/Card.java
// Description: Represents one card.
//         Issues:
//         * Fragile: This loads each card image from a file, and has
//           the file-naming conventions for the card built into it.
//           To change to another set of card images, it's necessary
//           to change this code.
//         * Issue: Altho it's common to put minor rendering capabilites
//           in a class (eg, toString), it does violate the separation
//           of UI from model.  Does this class go too far in this direction?
//             * It gets the images.
//             * It keeps track of it's x,y coordinates.
//             * It can draw itself.
// Author: Fred Swartz - February 2007 - Placed in public domain.

package freecell.view;

import java.awt.*;
import javax.swing.*;

import freecell.model.Face;
import freecell.model.Suit;

import java.io.*;

///////////////////////////////////////////////////////////////////// Class Card
public class Card {
    
    //================================================================ constants
    public  static final int CARD_WIDTH;  // Initialized in static initilizer.
    public  static final int CARD_HEIGHT; // Initialized in static intializer..
    
    private static final String    IMAGE_PATH = "/cardimages/";
    private static final ImageIcon BACK_IMAGE;  // Image of back of card.
    
    private static final Class CLASS = Card.class;
    private static final String PACKAGE_NAME;
    private static final ClassLoader CLSLDR;
    
    //======================================================= static initializer
    static {
        //... Get current classloader, and get the image resources.
        //    This was broken down into small steps for debugging,
        //    They could easily be combined.
        PACKAGE_NAME = "freecell";
        CLSLDR = CLASS.getClassLoader();
        String urlPath = PACKAGE_NAME + IMAGE_PATH + "b.gif";
        java.net.URL imageURL = CLSLDR.getResource(urlPath);
        BACK_IMAGE = new ImageIcon(imageURL);
        
        //... These constants are assumed to work for all cards.
        CARD_WIDTH  = BACK_IMAGE.getIconWidth();
        CARD_HEIGHT = BACK_IMAGE.getIconHeight();
    }
    
    //======================================================= instance variables
    private Face    _face;
    private Suit    _suit;
    private ImageIcon _faceImage;
    private int     _x;
    private int     _y;
    private boolean _faceUp  = false;
    
    //============================================================== constructor
    public Card(Face face, Suit suit) {
        //... Set the face and suit values.
        _face = face;
        _suit = suit;
        
        //... Assume card is at 0,0
        _x = 0;
        _y = 0;
        
        //... By default the cards are face up.
        _faceUp = false;
        
        //... Read in the image associated with the card.
        //    Each card is stored in a GIF file where the name has two chars,
        //    eg, 3h.gif for the three of hearts.  A directory of these files
        //    is stored in the .jar file.
        
        //... Create the file name from the face and suit.
        char faceChar = "a23456789tjqk".charAt(_face.ordinal());
        char suitChar = "shcd".charAt(_suit.ordinal());
        String cardFilename = "" + faceChar + suitChar + ".gif";
        
        //... To get files from the current jar file, the class loader
        //    can be used.  I can return a URL of the card file.
        //... Get current classloader, and get the image resources.
        String path = PACKAGE_NAME + IMAGE_PATH + cardFilename;
        java.net.URL imageURL = CLSLDR.getResource(path);
        
        //... Load the image from the URL.
        _faceImage = new ImageIcon(imageURL);
    }
    
    
    //================================================================== getFace
    //  Returns face value of card.
    public Face getFace() {
        return _face;
    }
    
    
    //================================================================== getSuit
    public Suit getSuit() {
        return _suit;
    }
    
    //============================================================== setPosition
    public void setPosition(int x, int y) {
        _x = x;
        _y = y;
    }
    
    //===================================================================== draw
    // Draws either face or back.
    public void draw(Graphics g) {
        if (_faceUp) {
            _faceImage.paintIcon(null, g, _x, _y);
        } else {
            BACK_IMAGE.paintIcon(null, g, _x, _y);
        }
    }
    
    //================================================================= isInside
    // Given a point, it tells whether this is inside card image.
    // Used to determine if mouse was pressed in card.
    public boolean isInside(int x, int y) {
        return (x >= _x && x < _x+CARD_WIDTH) && (y >= _y && y < _y+CARD_HEIGHT);
    }
    
    //=============================================================== getX, getY
    public int getX() {return _x;}
    public int getY() {return _y;}
    
    //=============================================================== getX, getY
    public void setX(int x) {_x = x;}
    public void setY(int y) {_y = y;}
    
    //================================================================= toString
    public String toString() {
        return "" + _face + " of " + _suit;
    }
    
    //=============================================================== turnFaceUp
    public void turnFaceUp() {_faceUp = true;}
    
    //============================================================= turnFaceDown
    public void turnFaceDown() {_faceUp = false;}
}