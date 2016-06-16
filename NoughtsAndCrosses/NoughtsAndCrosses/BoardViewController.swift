//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

// to do - eliminate redundancy between playMoveComplete and gameUpdateReceived

import UIKit

class BoardViewController: UIViewController {
    
    // outlets
    @IBOutlet var boardContainer: UIView! // container for the board
    @IBOutlet var networkPlayButton: UIButton! // network play button
    @IBOutlet weak var logOutButton: UIButton! // log out/cancel network game button
    @IBOutlet weak var newGameButton: UIButton! // new game/status button
    
    // internal variables
    var currentGame = OXGame()
    var networkGame = false // boolean indicating whether the current game is networked
    var timer: NSTimer? // timer for network refresh
    
    // handle rotations and update the UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a rotation gesture recognizer and add it to the board
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(
            target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardContainer.addGestureRecognizer(rotation)
        
        
        // update the UI
        self.updateUI()
    }
    
    // hide the navigation bar when view is about to appear
    override func viewWillAppear(animated: Bool) {
        // hide the navigation bar whenever game board appears
        self.navigationController?.navigationBarHidden = true
    }
    
    // start timer when the view has appeared
    override func viewDidAppear(animated: Bool) {
        if self.networkGame {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.refreshGame), userInfo: nil, repeats: true)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        // play the move in the game model
        self.currentGame.playMove(sender.tag)
        
        // check if in network mode
        if self.networkGame {
            // send the move to the network
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMoveComplete(game, message:message)})
        } else {
            // update the UI
            self.updateUI()
        }
        
    }
    
    // check if the game has ended
    func gameEnded() -> Bool {
        return self.currentGame.state() == OXGameState.complete_no_one_won || self.currentGame.state() == OXGameState.complete_someone_won
    }
    
    // update the current game based on server response
    func playMoveComplete(game: OXGame?, message: String?) {
        if let newGame = game {
            self.currentGame = newGame
            self.updateUI()
            
            if self.gameEnded() {
                self.leaveGame(true)
            }
        } else {
            // display an error message
        }
    }
    
    
    // finish the current game in the backend and reset the boardView
    @IBAction func newGameTapped(sender: AnyObject) {
        // reset back end and view
        self.resetBoard()
        self.currentGame.reset()
    }
    
    // finish the current game in the backend and navigate to authentication screen
    @IBAction func logOutButtonTapped(sender: UIButton) {
        // reset the board
        self.resetBoard()
        // check if network game
        if (self.networkGame) {
            // stop timer
            self.timer?.invalidate()
            // if in network mode, we are cancelling the network game
            OXGameController.sharedInstance.cancelGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(cancelled, message) in self.navigationController?.popViewControllerAnimated(true)})
        } else {
            // if in local mode, we are signing out the user
            NSUserDefaults.standardUserDefaults().setValue(nil, forKeyPath: "loggedInUser") // persist the log out
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedOutNavigationController()
        }
    }
    
    
    // enter network mode
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        // note that this function only executes when the view is in local mode
        let networkPlayViewController = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(networkPlayViewController, animated: true)
    }
    
    
    func updateUI() {
        // check if network game
        if (self.networkGame) {
            // disable new game button, hide network play button, retitle log out button to cancel
            self.newGameButton.userInteractionEnabled = false
            self.networkPlayButton.hidden = true
            self.logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            // update title of new game button to display state
            if (self.currentGame.guestUser?.email != "") {
                // there is an opponent
                if (self.gameEnded()) {
                    // game is over
                    self.newGameButton.setTitle("Game over", forState: UIControlState.Normal)
                    self.boardContainer.userInteractionEnabled = false
                }
                else if (self.currentGame.localUsersTurn()) {
                    // local user's turn
                    self.newGameButton.setTitle("Your turn to play...", forState: UIControlState.Normal)
                    self.boardContainer.userInteractionEnabled = true
                } else {
                    // remote user's turn
                    self.newGameButton.setTitle("Awaiting opponent move...", forState: UIControlState.Normal)
                    self.boardContainer.userInteractionEnabled = false
                }
            } else {
                // there is no opponent
                self.newGameButton.setTitle("Awaiting opponent to join...", forState: UIControlState.Normal)
                self.boardContainer.userInteractionEnabled = false
            }
        }
        // if not a network game, leave the UI as default
        
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
    
    // function for refreshing the game if it is in network mode
    func refreshGame() {
        if self.networkGame {
            // in this case, we will not send the presenting view controller, so that no loading overlay is repeatedly shown
            OXGameController.sharedInstance.getGame(self.currentGame.gameId!, presentingViewController: nil, viewControllerCompletionFunction: {(game, message) in self.gameUpdateReceived(game, message:message)})
        }
    }
    
    // respond to a game update from the server
    func gameUpdateReceived(game: OXGame?, message: String?) {
        if let gameReceived = game {
            self.currentGame = gameReceived
            // check if the game has been cancelled
            if self.currentGame.backendState == OXGameState.abandoned {
                // if cancelled, stop the timer
                self.timer?.invalidate()
                
                // figure out the message to display
                var opponentUsername: String
                if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
                    opponentUsername = self.currentGame.guestUser!.email
                } else {
                    opponentUsername = self.currentGame.hostUser!.email
                }
                let messageToUser = "Sorry! \(opponentUsername) cancelled the game."
                
                // set up alert
                let alertController = UIAlertController(title: "Game Cancelled",
                                                        message: messageToUser, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "Leave Game", style: .Default) {action in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                // if not cancelled, simply update the UI and check if the game ended
                self.updateUI()
                
                if self.gameEnded() {
                    self.leaveGame(false)
                }
            }
        } else {
            // to do: display error message from server to user
            print("something went wrong")
        }
    }
    
    // helper function for leaving the game
    private func leaveGame(didWin: Bool) {
        // end timer and display ending state
        self.timer?.invalidate()
        // alert the user that the game is over
        var messageToUser: String
        var opponentUsername: String
        
        // win or loss
        var winOrLoss, defeated: String
        if didWin {
            winOrLoss = "won"
            defeated = "defeated"
        } else {
            winOrLoss = "lost"
            defeated = "were defeated by"
        }
        
        // check who is the host user to display the appropriate message
        if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
            opponentUsername = self.currentGame.guestUser!.email
        } else {
            opponentUsername = self.currentGame.hostUser!.email
        }
        
        if self.currentGame.state() == OXGameState.complete_someone_won {
            messageToUser = "You \(winOrLoss)! You \(defeated) \(opponentUsername)."
        } else {
            messageToUser = "You tied the game with \(opponentUsername)."
        }
        
        // display alert
        let alertController = UIAlertController(title: "Game Over",
                                                message: messageToUser, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Leave Game", style: .Default) {action in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}
