//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var boardContainer: UIView!
    
    // refresh/network play button
    @IBOutlet var networkPlayButton: UIButton!
    
    // log out/cancel network game button
    @IBOutlet weak var logOutButton: UIButton!
    
    // new game/status button
    @IBOutlet weak var newGameButton: UIButton!
    
    var currentGame = OXGame()
    
    var networkGame = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a rotation gesture recognizer and add it to the board
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(
            target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardContainer.addGestureRecognizer(rotation)
        
        
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
    
    // rotation handler - rotates game board and then returns it back to normal
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        // transform the board
        self.boardContainer.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        // once the gesture has ended, bring it back to normal (and animate)
        if (sender!.state == UIGestureRecognizerState.Ended) {
            UIView.animateWithDuration(NSTimeInterval(0.5), animations: {
                self.boardContainer.transform = CGAffineTransformMakeRotation(0)
            })
            
        }
    }
    
    // action for pressing any of the game board buttons
    @IBAction func buttonTapped(sender: AnyObject) {
        // if the button is already filled, don't do anything
        if (self.currentGame.typeAtIndex(sender.tag) != CellType.EMPTY) {
            return
        }
        
        var lastMove: CellType?
        
        // check if in network mode
        if (self.networkGame) {
            // play the prescribed move
            lastMove = self.currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMoveComplete(game, message:message)})
        } else {
            // simply update our board
            lastMove = self.currentGame.playMove(sender.tag)
            if let _ = lastMove {
                self.updateUI()
            }
        }
        
    }
    
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
                    messageToUser = "You won! You defeated \(opponentUsername)."
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
            appDelegate.navigateToLoggedOutNavigationController()
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
                    self.boardContainer.userInteractionEnabled = false
                }
                else if (self.currentGame.localUsersTurn()) {
                    self.newGameButton.setTitle("Your turn to play...", forState: UIControlState.Normal)
                    self.boardContainer.userInteractionEnabled = true
                } else {
                    self.newGameButton.setTitle("Awaiting opponent move...", forState: UIControlState.Normal)
                    self.boardContainer.userInteractionEnabled = false
                }
            } else {
                self.newGameButton.setTitle("Awaiting opponent to join...", forState: UIControlState.Normal)
                self.boardContainer.userInteractionEnabled = false
            }
            self.logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            self.networkPlayButton.setTitle("Refresh", forState: UIControlState.Normal)
        }
        
        // update the game board
        for view in self.boardContainer.subviews {
            if let button = view as? UIButton {
                let str = self.currentGame.board[button.tag].rawValue
                button.setTitle(str, forState: UIControlState.Normal)
            }
        }
        
    }
    
    // helper function to reset all the buttons in the boardView to empty
    private func resetBoard() {
        for item in boardContainer.subviews {
            if let button = item as? UIButton {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    
}
