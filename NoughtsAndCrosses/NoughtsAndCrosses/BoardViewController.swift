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
    
//    @IBOutlet var boardView: UIViewController!
    @IBOutlet weak var boardTapped: UIButton!
    @IBOutlet weak var board: UIView!
    
    var gameObject = OXGame()
    
    @IBAction func boardTapped(sender: UIButton) {
        
        gameObject.playMove(sender.tag)
        boardTapped.setTitle(String(gameObject.typeAtIndex(sender.tag)), forState: UIControlState.Normal)
        print("boardTapped")
        
        let gameState = gameObject.state()
        if (gameState == OXGameState.complete_someone_won) {
            print("The winner is \(gameObject.whosTurn())!")
        } else {
            print("There is a tie!")
        }
         restartGame()
    }
    
    func restartGame() {
        gameObject.reset()
        boardTapped.setTitle("", forState: UIControlState.Normal)
    }
    
    @IBAction func newGame(sender: AnyObject) {
        restartGame()
    }


}
