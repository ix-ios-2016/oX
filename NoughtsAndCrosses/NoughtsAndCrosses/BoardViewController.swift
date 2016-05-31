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
    
    var gameObject = OXGame()
    
    // Action for all buttons clicked
    @IBAction func buttonClicked(sender: AnyObject) {
        sender.setTitle(String(gameObject.whosTurn()), forState: .Normal)

        gameObject.playMove(sender.tag)
        
        let state = gameObject.state()
        if state == OXGame.OXGameState.complete_someone_won {
            print("Congratulations, player " + String(gameObject.typeAtIndex(sender.tag)) + ". You won!")
            restartGame()
        }
        else if state == OXGame.OXGameState.complete_no_one_won {
            print("Tie game")
            restartGame()
        }
        else if state == OXGame.OXGameState.inProgress {
        }
        
        
    }
    
    // Action for new game click
    @IBAction func newGameClicked(sender: AnyObject) {
        restartGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func restartGame () {
        gameObject.reset()
        gameObject = OXGame()
        
        for button in self.boardView.subviews as [UIView] {
            if let button = button as? UIButton {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
}
