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
        
        
        //Set the title of the button to the player’s CellType.
        let cell = String(game.playMove(tag))
        sender.setTitle(cell, forState: UIControlState.Normal)
        
     let gameState = game.state()
        
    
        let plyer = game.whosTurn()
    
        if ( gameState == OXGameState.complete_someone_won){
            
            print("\(String(plyer)) is the Winner!")
            restartGame()
        }
        else if ( gameState == OXGameState.complete_no_one_won ) {
            print("There is a Tie!")
            restartGame()
        }
        

        
    }
    func restartGame() {
        game.reset()
        game.currTurn = CellType.X
        
        for cell in allButtons {
            cell.setTitle("", forState: UIControlState.Normal)
            
        }
    }
    @IBOutlet var allButtons: [UIButton]!
    
    @IBAction func resetGame(sender: UIButton) {
        restartGame()
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.navigateBackToLandingNavigationController()
    }

   
}
