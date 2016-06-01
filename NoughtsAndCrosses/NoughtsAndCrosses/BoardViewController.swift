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
    
    @IBOutlet weak var board: UIView!
    
    var gameObject = OXGame()
    
    @IBAction func boardTapped(sender: UIButton) {
        
        gameObject.playMove(sender.tag)
        sender.setTitle(String(gameObject.typeAtIndex(sender.tag)), forState: UIControlState.Normal)
        print("boardTapped")
        
        let gameState = gameObject.state()
        if (gameState == OXGameState.complete_someone_won) {
            print("The winner is \(String(gameObject.typeAtIndex(sender.tag)))!")
            restartGame()
        } else if (gameState == OXGameState.complete_no_one_won) {
            print("There is a tie!")
            restartGame()
        } else if (gameState == OXGameState.inProgress) {
            print("Game in progress")
        }
    }
    
    func restartGame() {
        gameObject.reset()
        for view in board.subviews {
//          print(view.classForCoder)
            if let button = view as? UIButton{
                button.setTitle("", forState: UIControlState.Normal)
            } else {
                print("This is not a UIButton")
            }
        }
    }
    
    @IBAction func newGame(sender: AnyObject) {
        restartGame()
    }
}
