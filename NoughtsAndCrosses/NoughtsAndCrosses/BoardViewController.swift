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
            let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            restartGame()
        }
        else if gameState == OXGameState.complete_no_one_won {
            print("Game Tied")
            let alert = UIAlertController(title: "Game Over!", message: "Tie Game, no winner!", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
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
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        UserController.sharedInstance.logout()
        print("Logged Out")
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToLandingView()
    }
    
    
}
