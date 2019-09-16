// File   : CardPileTableau.java
// Purpose: Card pile with initial cards.
//          Only need to specify rules for adding cards.
//          Default rules apply to removing them.
// Author : Fred Swartz - February 27, 2007 - Placed in public domain.

package freecell.model;

import freecell.view.Card;

//////////////////////////////////////////////////////////////////// Class
public class CardPileTableau extends CardPile {
    
    //===================================================================== push
    //... Accept card if pile is empty, or
    //    if face value is one lower and it's the opposite color.
    @Override
    public boolean rulesAllowAddingThisCard(Card card) {
        if ((this.size() == 0) ||
                (this.peekTop().getFace().ordinal() - 1 == card.getFace().ordinal() &&
                this.peekTop().getSuit().getColor() != card.getSuit().getColor())) {
            return true;
        }
        return false;
    }
}
