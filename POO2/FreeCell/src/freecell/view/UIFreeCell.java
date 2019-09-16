// File  : freesell/UIFreeSell.java
// Description: Freecell solitaire program.
//         Main program / JFrame.  Adds a few components and the 
//         main graphics area, UICardPanel, that handles the mouse and painting.
// Author: Fred Swartz - Feb 20 2007 - Placed in public domain.

package freecell.view;

import java.awt.*;
import java.awt.event.*;
//import java.util.ArrayList;
import javax.swing.*;
//import javax.swing.event.*;

import freecell.model.GameModel;

/////////////////////////////////////////////////////////////// class UIFreeSell
public class UIFreeCell extends JFrame {
    //=================================================================== fields
    private GameModel _model = new GameModel();
    
    private UICardPanel _boardDisplay;
    
//    private JCheckBox _autoCompleteCB = new JCheckBox("Auto Complete");
    
    //===================================================================== main
    public static void main(String[] args) {
        //... Do all GUI initialization on Event Dispatching Thread.  This is the
        //    correct way, but is often omitted because the other
        //    almost always(!) works.
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                new UIFreeCell();
            }
        });
    }
    
    //============================================================== constructor
    public UIFreeCell() {
        _boardDisplay = new UICardPanel(_model);
        
        //... Create button and check box.
        JButton newGameBtn = new JButton("New Game");
        newGameBtn.addActionListener(new ActionNewGame());

        JLabel label1 = new JLabel("jogador 1");
        JLabel label2 = new JLabel("jogador 2");
        JLabel pts1 = new JLabel(_model.getPts1()+"  --  ");
        JLabel pts2 = new JLabel("     "+_model.getPts2());

//        _autoCompleteCB.setSelected(true);
//        _autoCompleteCB.addActionListener(new ActionAutoComplete());
//        _boardDisplay.setAutoCompletion(_autoCompleteCB.isSelected());
        
        //... Do layout
        JPanel controlPanel = new JPanel(new FlowLayout());
        controlPanel.add(pts1);
        controlPanel.add(label1);
        controlPanel.add(newGameBtn);
        controlPanel.add(label2);
        controlPanel.add(pts2);
//        controlPanel.add(_autoCompleteCB);
        
        //... Create content pane with graphics area in center (so it expands)
        JPanel content = new JPanel();
        content.setLayout(new BorderLayout());
        content.add(controlPanel, BorderLayout.NORTH);
        content.add(_boardDisplay, BorderLayout.CENTER);
        
        //... Set this window's characteristics.
        setContentPane(content);
        setTitle("Free Cell");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        pack();
        setLocationRelativeTo(null);
        setResizable(false);
        setVisible(true);

    }
    
    ////////////////////////////////////////////////////////////// ActionNewGame
    class ActionNewGame implements ActionListener {
        public void actionPerformed(ActionEvent evt) {
            _model.reset();
        }
    }
    
    ///////////////////////////////////////////////////////// ActionAutoComplete
    class ActionAutoComplete implements ActionListener {
        public void actionPerformed(ActionEvent evt) {
//            _boardDisplay.setAutoCompletion(_autoCompleteCB.isSelected());
        }
    }
    
}
