//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var gameObject = OXGame()
    
    @IBOutlet var viewOutlet: UIView!
    
    
    @IBAction func buttonTapped(sender: UIButton)
    {
        //print(gameObject.whoseTurn())
        
        let currentPlayer = gameObject.whoseTurn()
        
        if (currentPlayer == CellType.X)
        {
            sender.setTitle("X", forState: UIControlState.Normal)
        }
        else
        {
            sender.setTitle("O", forState: UIControlState.Normal)
        }
        print("Button \(sender.tag) tapped")
        gameObject.playMove(sender.tag)
        
        //print(gameObject.whoseTurn())
        
        let winner = gameObject.state()
        
        if (winner == OXGameState.complete_someone_won)
        {
            print("Congratulations \(currentPlayer) player, you've won!")
            resetGame()
        }
        else if (winner == OXGameState.complete_no_one_won)
        {
            print("Tie Game")
            resetGame()
        }
        
    }
    
    

    @IBOutlet var buttonArray: [UIButton]!
    
    func resetGame()
    {
        
        gameObject.reset()
        for button in buttonArray
        {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    
    
    @IBAction func newGameTapped(sender: UIButton)
    {
        print("New Game button tapped")
        resetGame()
    }
    
    
    
    
    
    
}























