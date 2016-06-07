//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    // refresh/network play button
    @IBOutlet var networkPlayButton: UIButton!
    // log out/cancel network game button
    @IBOutlet weak var logOutButton: UIButton!
    // new game/status button
    @IBOutlet weak var newGameButton: UIButton!
    
    var currentGame = OXGame()
    
    var networkGame = false
    
    // saves the last snap of rotation
    var lastSnap:CGFloat = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create gesture recognizer
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        rotation.delegate = EasterEggController.sharedInstance
        self.boardView.addGestureRecognizer(rotation)
        
        
        // update the UI
        self.updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide the navigation bar whenever game board appears
        self.navigationController?.navigationBarHidden = true
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil)
    {
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation + lastSnap)
        
        if (sender!.state == UIGestureRecognizerState.Ended)
        {
            let myRotation = sender!.rotation % CGFloat(2*M_PI)
            let adjustedRotation = lastSnap + myRotation
            
            print("rotation: " + String((sender!.rotation % CGFloat(2*M_PI))))
            
            // positive rotation
            if adjustedRotation > 0
            {
                // up
                if (adjustedRotation < CGFloat(M_PI/4) ||
                    adjustedRotation > CGFloat((7*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    })
                    lastSnap = CGFloat(0)
                }
                    // right
                else if (adjustedRotation > CGFloat(M_PI/4) &&
                    adjustedRotation < CGFloat((3*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
                    })
                    lastSnap = CGFloat(M_PI/2)
                }
                    // down
                else if (adjustedRotation > CGFloat((3*M_PI)/4) &&
                    adjustedRotation < CGFloat((5*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    })
                    lastSnap = CGFloat(M_PI)
                }
                    // left
                else if (adjustedRotation > CGFloat((5*M_PI)/4) &&
                    adjustedRotation < CGFloat((7*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat((3*M_PI)/2))
                    })
                    lastSnap = CGFloat((3*M_PI)/2)
                }
            }
                // negative rotation
            else if adjustedRotation < 0
            {
                // up
                if (adjustedRotation > CGFloat(-M_PI/4) ||
                    adjustedRotation < CGFloat(-(7*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    })
                    lastSnap = CGFloat(0)
                }
                    // right
                else if (adjustedRotation > CGFloat(-(7*M_PI)/4) &&
                    adjustedRotation < CGFloat(-(5*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(-3*M_PI/2))
                    })
                    lastSnap = CGFloat(-3*M_PI/2)
                }
                    // down
                else if (adjustedRotation < CGFloat(-(3*M_PI)/4) &&
                    adjustedRotation > CGFloat(-(5*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
                    })
                    lastSnap = CGFloat(-M_PI)
                }
                    // left
                else if (adjustedRotation > CGFloat(-3*M_PI/4) &&
                    adjustedRotation < CGFloat(-M_PI/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat((3*M_PI)/2))
                    })
                    lastSnap = CGFloat((3*M_PI)/2)
                }
            }
        }
    }
    
    // action for pressing any of the game board buttons
    @IBAction func buttonTapped(sender: AnyObject) {
        
        // don't do anything if the cell already has a value in it
        if (self.currentGame.typeAtIndex(sender.tag) != CellType.EMPTY) {
            return
        }
        
        // save the last move
        var lastMove: CellType?
        
        // check if in network mode
        if (networkGame) {
            // play the move
            lastMove = self.currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMoveComplete(game, message:message)})
        }
        else // local game
        {
            // play a local move and update the game
            lastMove = self.currentGame.playMove(sender.tag)
            print("CellType at the button pressed: " + String(self.currentGame.board[sender.tag]))
            if let _ = lastMove
            {
                self.updateUI()
            }
            
            if self.gameEnded()
            {
                // alert the user that the game is over and leave
                var messageToUser: String

                
                if self.currentGame.state() == OXGameState.complete_someone_won {
                    messageToUser = (String(currentGame.whoJustPlayed()) + "s won! You beat the balls off of the " + String(currentGame.whosTurn()) + "s!")
                } else {
                    messageToUser = "The game finished tied!"
                }
                
                let alertController = UIAlertController(title: "Game Over",
                                                        message: messageToUser, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "Leave", style: .Default) {action in
                    self.navigationController?.popViewControllerAnimated(true)
                    // reset back end and view
                    self.resetBoard()
                    self.currentGame.reset()
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }

        }
        
    }
    
    // make it easier to check if someone ended the game
    func gameEnded() -> Bool {
        return self.currentGame.state() == OXGameState.complete_no_one_won || self.currentGame.state() == OXGameState.complete_someone_won
    }
    
    func playMoveComplete(game: OXGame?, message: String?) {
        if let newGame = game {
            if newGame.guestUser == nil || newGame.hostUser == nil {
                // someone cancelled
            }
            self.currentGame = newGame
            self.updateUI()
            
            if self.gameEnded() {
                // alert the user that the game is over and leave
                var messageToUser: String
                var opponentUsername: String
                
                if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
                    opponentUsername = self.currentGame.guestUser!.email
                } else {
                    opponentUsername = self.currentGame.hostUser!.email
                }
                
                if self.currentGame.state() == OXGameState.complete_someone_won {
                    messageToUser = "You won! You beat the balls off of \(opponentUsername)."
                } else {
                    messageToUser = "The game finished tied with \(opponentUsername)."
                }
                
                let alertController = UIAlertController(title: "Game Over",
                                                        message: messageToUser, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "Leave Game", style: .Default) {action in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
            }
        }
    }
    
    // action for new game button
    // finish the current game in the backend and reset the boardView
    @IBAction func newGameTapped(sender: AnyObject) {
        // reset back end and view
        self.resetBoard()
        self.currentGame.reset()
    }
    
    // action for log out button
    // finish the current game in the backend and navigate to authentication screen
    @IBAction func logOutButtonTapped(sender: UIButton) {
        //        OXGameController.sharedInstance.finishCurrentGame()
        self.resetBoard()
        if (self.networkGame) {
            OXGameController.sharedInstance.cancelGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(cancelled, message) in self.cancelGameComplete(cancelled, message: message)})
        } else {
            // persistence
            NSUserDefaults.standardUserDefaults().setValue(nil, forKeyPath: "loggedInUser")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // there is no logout user method yet in the UserController
            //            UserController.sharedInstance.logoutUser()
            appDelegate.navigateToLoggedOutViewController()
        }
    }
    
    func cancelGameComplete(cancelled: Bool, message: String?) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    // action for network play button
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        if self.networkGame {
            // refresh in network mode
            OXGameController.sharedInstance.getGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.gameUpdateReceived(game, message:message)})
        } else {
            // go into network play when in local mode
            let networkPlayViewController = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
            self.navigationController?.pushViewController(networkPlayViewController, animated: true)
        }
    }
    
    func gameUpdateReceived(game: OXGame?, message: String?) {
        if let gameReceived = game {
            self.currentGame = gameReceived
            if self.currentGame.backendState == OXGameState.abandoned {
                var opponentUsername: String
                
                if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
                    opponentUsername = self.currentGame.guestUser!.email
                } else {
                    opponentUsername = self.currentGame.hostUser!.email
                }
                
                
                let messageToUser = "Sorry! \(opponentUsername) cancelled the game."
                let alertController = UIAlertController(title: "Game Cancelled",
                                                        message: messageToUser, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "Leave Game", style: .Default) {action in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        } else {
            print("something went wrong")
        }
        self.updateUI()
        
        // similar block as in playMoveComplete
        if self.gameEnded()
        {
            // alert the user that the game is over and leave
            var messageToUser: String
            var opponentUsername: String
            
            if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
                opponentUsername = self.currentGame.guestUser!.email
            } else {
                opponentUsername = self.currentGame.hostUser!.email
            }
            
            if self.currentGame.state() == OXGameState.complete_someone_won {
                messageToUser = "You lost! You were defeated by \(opponentUsername)."
            } else {
                messageToUser = "You tied the game with \(opponentUsername)."
            }
            
            let alertController = UIAlertController(title: "Game Over",
                                                    message: messageToUser, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Leave Game", style: .Default) {action in
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    func updateUI() {
        
        // check if network game
        // if so, hide the new game button and network play buttons, and rename Logout to Cancel
        if (self.networkGame) {
            self.newGameButton.userInteractionEnabled = false
            if (self.currentGame.guestUser?.email != "") {
                if (self.gameEnded()) {
                    self.newGameButton.setTitle("Game over", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = false
                }
                else if (self.currentGame.localUsersTurn()) {
                    self.newGameButton.setTitle("Your turn to play...", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = true
                } else {
                    self.newGameButton.setTitle("Awaiting opponent move...", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = false
                }
            } else {
                self.newGameButton.setTitle("Awaiting opponent to join...", forState: UIControlState.Normal)
                self.boardView.userInteractionEnabled = false
            }
            self.logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            self.networkPlayButton.setTitle("Refresh", forState: UIControlState.Normal)
        }
        
        // update the game board
        for view in self.boardView.subviews
        {
            if let button = view as? UIButton
            {
                let str = self.currentGame.board[button.tag].rawValue
                button.setTitle(str, forState: UIControlState.Normal)
            }
        }
        
    }
    
    // helper function to reset all the buttons in the boardView to empty
    private func resetBoard() {
        for item in boardView.subviews {
            if let button = item as? UIButton {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    
}