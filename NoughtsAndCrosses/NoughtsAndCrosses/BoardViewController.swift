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
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var winningMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func boardTapped(sender: AnyObject) {
        game.playMove(sender.tag)
        var cellType = ""
        if (game.whosTurn() == CellType.X) {
            cellType = "X"
        } else if (game.whosTurn() == CellType.O) {
            cellType = "O"
        }
        let gameState = game.state()
        if (gameState == OXGameState.complete_no_one_won) {
            winningMessage.text = "Tie! No player wins."
        } else if (gameState == OXGameState.complete_someone_won) {
            if (game.whosTurn() == CellType.X) {
                winningMessage.text = "Player X wins"
            } else if (game.whosTurn() == CellType.O){
                winningMessage.text = "Player O wins"
            } else {
                winningMessage.text = ""
            }
        }
        sender.setTitle(cellType, forState: UIControlState.Normal)
    }
    
    func restartGame() {
        let buttons = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        for button in buttons {
            button.setTitle("", forState: UIControlState.Normal)
        }
        game.reset()
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        restartGame()
    }

}
