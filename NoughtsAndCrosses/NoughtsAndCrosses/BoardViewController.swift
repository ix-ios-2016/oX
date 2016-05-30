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

    @IBAction func boardTapped(sender: UIButton) {
     let tag = sender.tag
     var gameState = game.state()

        if ( gameState == OXGameState.complete_someone_won){
            let temp = String(game.whosTurn())
            print("\(temp) is the Winner!")
            restartGame()
            gameState = OXGameState.inProgress
        }
        else if ( gameState == OXGameState.complete_no_one_won ) {
            print("There is a Tie!")
            restartGame()
            gameState = OXGameState.inProgress
        }
        
        
        //Set the title of the button to the player’s CellType.
        sender.setTitle(String(game.playMove(tag)), forState: UIControlState.Normal)

        
    }

    @IBOutlet var allButtons: [UIButton]!
    
    @IBAction func resetGame(sender: UIButton) {
        restartGame()
    }
    
    func restartGame() {
        game.reset()
        game.currTurn = CellType.X
        
        for cell in allButtons {
            cell.setTitle("", forState: UIControlState.Normal)
            
        }
    }
   
}
