//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
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
        case OXGameState.complete_no_one_won:
            print("Game is tied.")
        default:
            break
        }
        
        
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        
    }
}
