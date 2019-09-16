// File: freecell/UICardPanel.java
// Description: JPanel which displays cards, and manages the mouse.
//         Cards are in three groups:
//         * Tableau. The initial cards are in a "tableau" consisting of
//           8 piles, with 7 cards in the first four, and 6 in the second four.
//           Cards can be removed from here.  Cards from other tableau piles
//           or from free cells can be played on either an empty tableau pile,
//           or on a card with a one higher face value and of the opposite color.
//         * Free cells.  There are four "free cells" where single cards can
//           be temporarily stored.
//         * Foundation.  Card suits are built up here.  Only aces can be
//           placed on empty cells and successive cards must be one higher
//           of the same suit.  No cards can be removed from the foundation.
//
//         Communication with the model:
//         * The mouse can drag cards around.  When a dragged card is
//           dropped on a pile, the mouseReleased listener calls on the
//           model to move the card from one pile to another.
//           The "rules" implemented by the piles may prevent this, but the
//           that's not a problem, because it simply won't be moved, and
//           when redrawn, will show up where it originally was.
//         * The other interaction between the model and this "view" of the
//           model is that this class implements the ChangeListener interface,
//           and registers itself with the model so that it's called whenever
//           the model changes.  The stateChanged method that is called when
//           this happens only does a repaint and clear of the dragged card info.
// Author: Fred Swartz - 2007-02 - Placed in public domain.

package freecell.view;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import javax.swing.event.*;

import freecell.model.CardPile;
import freecell.model.GameModel;

//////////////////////////////////////////////////////////////// class UICardPanel

class UICardPanel extends JComponent implements
        MouseListener,
        MouseMotionListener,
        ChangeListener {
    //================================================================ constants
    private static final int NUMBER_OF_PILES = 10;
    
    //... Constants specifying position of display elements
    private static final int GAP = 10;
    private static final int FOUNDATION_TOP = GAP;
    private static final int FOUNDATION_BOTTOM = FOUNDATION_TOP + Card.CARD_HEIGHT;
    
    private static final int FREE_CELL_TOP = GAP + FOUNDATION_TOP;
    private static final int FREE_CELL_BOTTOM = FREE_CELL_TOP + Card.CARD_HEIGHT;
    
    private static final int TABLEAU_TOP = 2 * GAP +
            Math.max(FOUNDATION_BOTTOM, FREE_CELL_BOTTOM);
    private static final int TABLEAU_INCR_Y  = 15;
    private static final int TABLEAU_START_X = GAP;
    private static final int TABLEAU_INCR_X  = Card.CARD_WIDTH + GAP;
    
    private static final int DISPLAY_WIDTH = GAP + NUMBER_OF_PILES * TABLEAU_INCR_X;
    private static final int DISPLAY_HEIGHT = TABLEAU_TOP + 3 * Card.CARD_HEIGHT + GAP;
    
    private static final Color BACKGROUND_COLOR = new Color(153, 51, 153);
    
    //=================================================================== fields
    /** Initial image coords. */
    private int _initX     = 0;   // x coord - set from drag
    private int _initY     = 0;   // y coord - set from drag
    
    /** Position in image of mouse press to make dragging look better. */
    private int _dragFromX = 0;  // Displacement inside image of mouse press.
    private int _dragFromY = 0;
    
    //... Selected card and its pile for dragging purposes.
    private Card     _draggedCard = null;  // Current draggable card.
    private CardPile _draggedFromPile = null;  // Which pile it came from.
    
    //... Remember where each pile is located.
    private IdentityHashMap<CardPile, Rectangle> _whereIs =
            new IdentityHashMap<CardPile, Rectangle>();
    
    private boolean _autoComplete = false;
    
    private GameModel _model;
    
    //============================================================== constructor
    /** Constructor sets size, colors, and adds mouse listeners.*/
    UICardPanel(GameModel model) {
        //... Save the model.
        _model = model;
        
        //... Initialize graphics
        setPreferredSize(new Dimension(DISPLAY_WIDTH, DISPLAY_HEIGHT));
        setBackground(Color.blue);
        
        //... Add mouse listeners.
        this.addMouseListener(this);
        this.addMouseMotionListener(this);
        
        //... Set location of all piles in model.
        int x = TABLEAU_START_X;   // Initial x position.
        for (int pileNum = 0; pileNum < NUMBER_OF_PILES; pileNum++) {
            CardPile p;
            if (pileNum < 5) {
                p = _model.getFreeCellPile(pileNum);
                _whereIs.put(p, new Rectangle(x, FREE_CELL_TOP, Card.CARD_WIDTH,
                        Card.CARD_HEIGHT));
            } else {
                p = _model.getFoundationPile(pileNum - 5);
                _whereIs.put(p, new Rectangle(x, FOUNDATION_TOP, Card.CARD_WIDTH,
                        Card.CARD_HEIGHT));
            }

            p = _model.getTableauPile(pileNum);
            _whereIs.put(p, new Rectangle(x, TABLEAU_TOP, Card.CARD_WIDTH,
                    3 * Card.CARD_HEIGHT));
            
            x += TABLEAU_INCR_X;
        }
        
        //... Make sure model calls us whenever something changes.
        _model.addChangeListener(this);
    }
    
    //=========================================================== paintComponent
    /** Draw the cards. */
    @Override
    public void paintComponent(Graphics g) {
        //... Paint background.
        int width  = getWidth();
        int height = getHeight();
        g.setColor(BACKGROUND_COLOR);
        g.fillRect(0, 0, width, height);
        g.setColor(Color.BLACK);   // Restore pen color.
        
        //... Display each pile.
        for (CardPile pile : _model.getFreeCellPiles()) {
            _drawPile(g, pile, true);
        }
        for (CardPile pile : _model.getFoundationPiles()) {
            _drawPile(g, pile, true);
        }
        for (CardPile pile : _model.getTableauPiles()) {
            _drawPile(g, pile, false);
        }
        
        //... Draw the dragged card, if any.
        if (_draggedCard != null) {
            _draggedCard.draw(g);
        }
    }
    
    //================================================================ _drawPile
    private void _drawPile(Graphics g, CardPile pile, boolean topOnly) {
        Rectangle loc = _whereIs.get(pile);
//        g.drawRect(loc.x, loc.y, loc.width, loc.height);
        int y = loc.y;
        if (pile.size() > 0) {
            if (topOnly) {
                Card card = pile.peekTop();
                if (card != _draggedCard) {
                    //... Draw only non-dragged card.
                    card.setPosition(loc.x, y);
                    card.draw(g);
                }
            } else {
                //... Draw all cards.
                //    Another possibility is that instead of only associating
                //    a Rectangle with a pile, other rendering hints should
                //    be recorded, such as whether to show only the top card.
                for (Card card : pile) {
                    if (card != _draggedCard) {
                        //... Draw only non-dragged card.
                        card.setPosition(loc.x, y);
                        card.draw(g);
                        y += TABLEAU_INCR_Y;
                    }
                }
            }
        }
    }
    
    //============================================================= mousePressed
    public void mousePressed(MouseEvent e) {
        int x = e.getX();   // Save the x coord of the click
        int y = e.getY();   // Save the y coord of the click

        //... Find card image this is in.  Check top of every pile.
        _draggedCard = null;  // Assume not in any image.
        for (CardPile pile : _model) {
            if (pile.isRemovable() && pile.size() > 0) {
                Card testCard = pile.peekTop();
                if (testCard.isInside(x, y)) {
                    _dragFromX = x - testCard.getX();  // how far from left
                    _dragFromY = y - testCard.getY();  // how far from top
                    _draggedCard = testCard;  // Remember what we're dragging.
                    _draggedFromPile = pile;
                    break;   // Stop when we find the first match.
                }
            }
        }
    }
    
    //============================================================= stateChanged
    // Implementing ChangeListener means we had to define this.
    // Because we added ourselves as a change listener in the model,
    // This method will be called whenever anything changes in the model.
    // All we have to do is repaint.
    public void stateChanged(ChangeEvent e) {
        _clearDrag();     // Perhaps not needed, but this makes sure.
        this.repaint();
    }
    
    //======================================================== setAutoCompletion
    // Called from other parts of user interface.
    void setAutoCompletion(boolean autoComplete) {
        _autoComplete = autoComplete;
    }
    
    //============================================================= mouseDragged
    /** Set x,y to mouse position and repaint. */
    public void mouseDragged(MouseEvent e) {
//        if (_draggedCard == null) {
//            return;  // Non-null if pressed inside card image.
//        }
//        int newX;
//        int newY;
//
//        newX = e.getX() - _dragFromX;
//        newY = e.getY() - _dragFromY;
//
//        //... Don't move the image off the screen sides
//        newX = Math.max(newX, 0);
//        newX = Math.min(newX, getWidth() - Card.CARD_WIDTH);
//
//        //... Don't move the image off top or bottom
//        newY = Math.max(newY, 0);
//        newY = Math.min(newY, getHeight() - Card.CARD_HEIGHT);
//
//        _draggedCard.setPosition(newX, newY);
//
//        this.repaint();  // Repaint because position changed.
    }
    
    //============================================================ mouseReleased
    public void mouseReleased(MouseEvent e) {
        //... Check to see if something was being dragged.
        if (_draggedFromPile != null) {
            int x = e.getX();
            int y = e.getY();
            CardPile targetPile = _findPileAt(x, y);
            if (targetPile != null) {
                //... Move card.  This may not actually move if illegal.
                _model.playerController(_draggedFromPile, targetPile);

                if (_autoComplete) {
                    //... Check to see if any cards can go to foundation piles.
                    _model.makeAllPlays();
                }
            }
            _clearDrag();
            this.repaint();
        }
    }
    
    //=============================================================== _clearDrag
    // After mouse button is released, clear the drag info, otherwise
    //    paintComponent will still try to display a dragged card.
    //    Perhaps this is overly cautious.
    private void _clearDrag() {
        _draggedCard = null;
        _draggedFromPile = null;
    }
    
    //============================================================== _findPileAt
    private CardPile _findPileAt(int x, int y) {
        for (CardPile pile : _model) {
            Rectangle loc = _whereIs.get(pile);
            if (loc.contains(x, y)) {
                return pile;
            }
        }
        
        return null;   // Not found.
    }
    
    //=============================================== Ignore other mouse events.
    public void mouseMoved  (MouseEvent e) {}   // ignore these events
    public void mouseEntered(MouseEvent e) {}   // ignore these events
    public void mouseClicked(MouseEvent e) {}   // ignore these events
    public void mouseExited(MouseEvent e) { ; }
}
