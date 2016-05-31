//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    // All outlets
    @IBOutlet weak var boardView: UIView!
    
    var gameObject:OXGame = OXGame()
    
    // Outlet for all grid buttons
    @IBAction func gridButtonTapped(sender: AnyObject) {
        
        // Set the title of the button to whose turn it is
        sender.setTitle(String(gameObject.whoseTurn()), forState: .Normal)
        // Call the playMove function on the specific button
        gameObject.playMove(sender.tag)
        
        
        // Get current the state of the game
        let gameState = gameObject.state()
        
        if gameState == OXGame.OXGameState.complete_someone_won
        {
            let winner:String = String(gameObject.typeAtIndex(sender.tag))
            
            let winAlert = UIAlertController(title: winner + "s Won!", message:
                winner + " has won the game! Weeeeeeee!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            winAlert.addAction(okButton)

            // Present the message
            self.presentViewController(winAlert, animated: true, completion: nil)
            
//            if okButton.enabled
            
            restartGame()
        }
        else if gameState == OXGame.OXGameState.complete_no_one_won
        {
            let tieAlert = UIAlertController(title: "It's a Tie!", message:
                "It's a tie. Play again to break it!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            tieAlert.addAction(okButton)
            
            // Present the message
            self.presentViewController(tieAlert, animated: true, completion: nil)
            
            restartGame()
        }
    }
    
    func restartGame() {
        gameObject.reset()
        gameObject = OXGame()
        
        for view in self.boardView.subviews as [UIView]
        {
            if let button = view as? UIButton
            {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
    // Outlet for newGame Button
    @IBAction func newGameButtonTapped(sender: AnyObject) {
        // Call the restartGame function
        restartGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    

}
