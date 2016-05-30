//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    var game = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet var boardView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func boardTapped(sender: UIButton) {
        
        let tag = sender.tag
        print("board tapped \(tag)")
        
        let turn = game.whosTurn()
        
        game.playMove(tag)
        sender.setTitle(String(turn), forState: UIControlState.Normal)
        
        let gameState = game.state()
        if gameState == OXGameState.complete_someone_won {
            print("Winner: Player " + String(turn))
            restartGame()
        }
        else if gameState == OXGameState.complete_no_one_won {
            print("Game Tied")
            restartGame()
        }
        
    }
    
    func restartGame() {
        game.reset()
        for button in buttons {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func newGame(sender: UIButton) {
        restartGame()
    }
    
    
    
}
