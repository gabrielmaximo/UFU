// File: freecell/Suit.java
// Description: A card suit type.
// Author: Fred Swartz - December 2004 - Placed in the public domain.

package freecell.model;

import java.awt.Color;

public enum Suit {
    //================================================================ constants
    SPADES(Color.BLACK), HEARTS(Color.RED), CLUBS(Color.BLACK), DIAMONDS(Color.RED);
    
    //==================================================================== field
    private final Color _color;
    
    //============================================================== constructor
    Suit(Color color) {
        _color = color;
    }
    
    //================================================================= getColor
    public Color getColor() {
        return _color;
    }
}