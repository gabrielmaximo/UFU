// File   : CardPileFoundation.java
// Purpose: Represents a Foundation card pile.
// Author : Fred Swartz - February 27, 2007 - Placed in public domain.

package freecell.model;

import freecell.view.Card;

/////////////////////////////////////////////////////// Class CardPileFoundation
public class CardPileFoundation extends CardPile {
    
    //================================================= rulesAllowAddingThisCard
    //... Accept card if pile is empty, or
    //    if face value is one lower and it's the opposite color.
    @Override
    public boolean rulesAllowAddingThisCard(Card card) {
        //... Accept any ace on an empty pile.
        if ((this.size() == 0) && (card.getFace() == Face.ACE)) {
            return true;
        }
        
        if (size() > 0) {
            Card top = peekTop();
            if ((top.getSuit() == card.getSuit() &&
                    (top.getFace().ordinal() + 1 == card.getFace().ordinal()))) {
                return true;
            }
        }
        return false;
        
    }
    
    //============================================================== isRemovable
    @Override
    public boolean isRemovable() {
        return false;
    }
}
