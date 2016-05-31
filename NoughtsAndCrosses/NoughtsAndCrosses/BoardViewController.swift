//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var boardContainer: UIView!
    
    var gameObject = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        // play the move
        gameObject.playMove(sender.tag)
        sender.setTitle(String(gameObject.typeAtIndex(sender.tag)),
                        forState: UIControlState.Normal)
        print("button \(sender.tag) tapped")
        
        // check the game state
        let currentState = gameObject.state()
        switch currentState {
        case OXGameState.complete_someone_won:
            print("Winner is \(gameObject.typeAtIndex(sender.tag))")
            // create alert controller and OK action
            let alertController = UIAlertController(title: "Game over!",
                                                    message: "Winner is \(gameObject.typeAtIndex(sender.tag))",
                                                    preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in}
            // add OK action to alert controller
            alertController.addAction(OKAction)
            // display alert
            self.presentViewController(alertController, animated: true, completion: nil)
        case OXGameState.complete_no_one_won:
            print("Game tied.")
            // create alert controller and OK action
            let alertController = UIAlertController(title: "Game over!",
                                                    message: "Game is tied.",
                                                    preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in}
            // add OK action to alert controller
            alertController.addAction(OKAction)
            // display alert
            self.presentViewController(alertController, animated: true, completion: nil)
        default:
            break
        }
        
        
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        gameObject.reset()
        for item in boardContainer.subviews {
            if let button = item as? UIButton {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
}
