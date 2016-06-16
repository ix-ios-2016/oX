//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var boardView: UIView!
    //@IBOutlet var boardView: UIView!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var networkPlayButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var gameObject = OXGame()
    var networkGame:Bool = false
    
    var currentGame = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        EasterEggController.sharedInstance.initiate(view)
//        EasterEggController.sharedInstance.checkEasterEgg()
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        if networkGame {
            networkPlayButton.hidden = true
            refreshButton.hidden = false
            logoutButton.setTitle("Cancel game", forState: UIControlState.Normal)
            self.updateUI()
            
        } else {
            refreshButton.hidden = true
        }
    }
    //enum/ array of gestures? variable arraycombo
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    func updateUI() {
        for view in boardView.subviews {
            if let button = view as? UIButton {
                button.setTitle(self.currentGame.board[button.tag].rawValue, forState: UIControlState.Normal)
            }
        }
        if networkGame {
            if currentGame.guestUser?.email != "" {
                var gameState = String(currentGame.state())
                if gameState == "inProgress" {
                    if (self.currentGame.localUsersTurn()) {
                        self.newGameButton.setTitle("Your turn to play...", forState: UIControlState.Normal)
                        self.boardView.userInteractionEnabled = true
                    } else {
                        self.newGameButton.setTitle("Awaiting Opponent Move...", forState: UIControlState.Normal)
                        self.boardView.userInteractionEnabled = false
                    }
                } else if gameState == "complete_someone_won" {
                    if currentGame.localUsersTurn() {
                        self.newGameButton.setTitle("You Lost!", forState: UIControlState.Normal)
                    } else {
                        self.newGameButton.setTitle("You Win!", forState: UIControlState.Normal)
                    }
                } else if gameState == "complete_no_one_won" {
                    self.newGameButton.setTitle("You Tied!", forState: UIControlState.Normal)
                }
            } else {
                self.newGameButton.setTitle("Awaiting opponent to join...", forState: UIControlState.Normal)
                self.boardView.userInteractionEnabled = false
            }
        }
        
        //check currentGame.state
        
    }
    @IBAction func buttonTapped(sender: AnyObject) {
        
        if networkGame {
            var gameState = String(currentGame.state())
            if gameState == "inProgress" {
                sender.setTitle(String(currentGame.playMove(sender.tag)), forState: UIControlState.Normal)
                OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game,message) in self.playMoveComplete(game,message:message)})
                gameState = String(currentGame.state())
            }
            if gameState == "complete_someone_won" {
                if currentGame.localUsersTurn() {
                    self.newGameButton.setTitle("You Lost!", forState: UIControlState.Normal)
                } else {
                    self.newGameButton.setTitle("You Win!", forState: UIControlState.Normal)
                }
            }
            if gameState == "complete_no_one_won" {
                print ("you tied")
            }
      
    
        } else {
            let gameState = String(gameObject.state())
            if gameState == "inProgress" {
                gameObject.playMove(sender.tag)
                sender.setTitle(String(gameObject.typeAtIndex(sender.tag)), forState: UIControlState.Normal)
                let newState = String(gameObject.state())
                if newState == "complete_someone_won" {
                    if String(gameObject.whosTurn()) == "X" {
                        let alertController = UIAlertController(title: "O Won!", message: "Want to play again?", preferredStyle: .Alert)
                        let cancelAction = UIAlertAction(title: "Nah", style: .Cancel) { (action) in
                            // ...
                        }
                        alertController.addAction(cancelAction)
                        let OKAction = UIAlertAction(title: "Yes!", style: .Default) { (action) in
                            self.restartGame()
                        }
                        alertController.addAction(OKAction)
                        self.presentViewController(alertController, animated: true) {
                            // ...
                        }
                    } else if String(gameObject.whosTurn()) == "O" {
                        let alertController = UIAlertController(title: "X Won!", message: "Want to play again?", preferredStyle: .Alert)
                        let cancelAction = UIAlertAction(title: "Nah", style: .Cancel) { (action) in
                            // ...
                        }
                        alertController.addAction(cancelAction)
                        let OKAction = UIAlertAction(title: "Yes!", style: .Default) { (action) in
                            self.restartGame()
                        }
                        alertController.addAction(OKAction)
                        self.presentViewController(alertController, animated: true) {
                            // ...
                        }
                    }
                } else if newState == "complete_no_one_won" {
                    let alertController = UIAlertController(title: "You Tied!", message: "Want to play again?", preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "Nah", style: .Cancel) { (action) in
                        // ...
                    }
                    alertController.addAction(cancelAction)
                    let OKAction = UIAlertAction(title: "Yes!", style: .Default) { (action) in
                        self.restartGame()
                    }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) {
                        // ...
                    }
                }
            }
        }
        
        
    }
    
    
//        if String(currentGame.typeAtIndex(sender.tag)) != "EMPTY") {
//            return
//        }
//        var lastMove = CellType?
//        
//        if networkGame {
//            lastMove = currentGame.playMove(sender.tag)
//            
//            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game,message) in self.playMoveComplete(game,message:message)})
//            
//            if !gameEnded(lastMove)) {
//                
//                
//            } else {
//                lastMove = currentGame.playMove(sender.tag)
//                if let moveToPrint = lastMove {
//                    print ("Setting button to: \(moveToPrint)")
//                    sender.setTitle(moveToPrint, forState: UIControlState.Normal)
//                }
//            }
//

    @IBAction func newGame(sender: AnyObject) {
        self.restartGame()
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
        if networkGame {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
        //UserController.sharedInstance.logged_in_user!.email = ""
        //UserController.sharedInstance.logged_in_user!.password = ""
        appDelegate.navigateToLandingViewController()
        EasterEggController.sharedInstance.refresh()
        }
    }
    
    
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
    
    func restartGame() {
        gameObject.reset()
        button0.setTitle("", forState: UIControlState.Normal)
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        button4.setTitle("", forState: UIControlState.Normal)
        button5.setTitle("", forState: UIControlState.Normal)
        button6.setTitle("", forState: UIControlState.Normal)
        button7.setTitle("", forState: UIControlState.Normal)
        button8.setTitle("", forState: UIControlState.Normal)
        
//        for view in boardView.subviews {
//            if let button = view as? UIButton {
//                button.setTitle("", forState: UIControlState.Normal)
//            }
//        } or make an array of outlet objects
        
    }
    
    func playMoveComplete(game:OXGame?, message: String?) {
        if let gameBack = game {
            self.currentGame = gameBack
        } else {
            //fail
        }
    }
    
    func gameCancelCompletion(success:Bool, message:String?) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func refreshButtonTapped(sender: UIButton) {
        OXGameController.sharedInstance.getGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game,message) in self.gameUpdateRecieved(game,message: message)})
        self.updateUI()
    }
    
    func gameUpdateRecieved(game:OXGame?, message: String?) {
        if let gameRecieved = game {
            self.currentGame = gameRecieved
        }
        self.updateUI()
    }
    
}
