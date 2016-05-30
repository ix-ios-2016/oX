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
    
    @IBOutlet var boardView: UIView!
    @IBOutlet weak var boardTapped: UIButton!
    
    var gameObject = OXGame()
    
    @IBAction func boardTapped(sender: AnyObject) {
        
        gameObject.playMove()
        boardTapped.setTitle(gameObject.typeAtIndex(), forState: UIControlState.Normal)
//        print("boardTapped")
        
        var gameState = gameObject.state()
        if (gameState == "complete_someone_won") {
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
