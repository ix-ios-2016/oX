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
    
    @IBOutlet var networkPlayButton: UIButton!
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    var currentGame = OXGame()
    
    var networkGame = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a rotation gesture recognizer and add it to the board
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(
            target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardContainer.addGestureRecognizer(rotation)
        
        
        
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
        if (currentGame.typeAtIndex(sender.tag) != CellType.EMPTY) {
            return
        }
        
        var lastMove: CellType?
        
        if (self.networkGame) {
            
            lastMove = self.currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMoveComplete(game, message:message)})
            
            if !self.gameEnded(lastMove!) {
                
                
            } else {
                return
            }
        } else {
            lastMove = self.currentGame.playMove(sender.tag)
            if let moveToPrint = lastMove {
                sender.setTitle("\(moveToPrint)", forState: UIControlState.Normal)
            }
        }
        
    }
    
    func gameEnded(move: CellType) -> Bool {
        return false
    }
    
    func playMoveComplete(game: OXGame?, message: String?) {
        if let newGame = game {
            self.currentGame = newGame
            self.updateUI()
        } else {
            print("something went wrong")
        }
    }
    
    // helper function to check the state of the game, and return an appropriate message given whomever made the most recent move
    // if necessary, pop out to previous view controller
    private func checkState(lastPlayer: CellType) -> OXGameState {
        let currentState = self.currentGame.state()
        switch currentState {
        case OXGameState.complete_someone_won, OXGameState.complete_no_one_won:
            // print end game message
            if (currentState == OXGameState.complete_someone_won) {
                print("Winner is \(lastPlayer)")
            } else {
                print("Game tied")
            }
            // finish game in backend
//            OXGameController.sharedInstance.finishCurrentGame()
            // update view
            if (self.networkGame) {
                self.navigationController?.popViewControllerAnimated(true)
            }
        default:
            break
        }
        return currentState
    }
    
    // action for new game button
    // finish the current game in the backend and reset the boardView
    @IBAction func newGameTapped(sender: AnyObject) {
        self.resetBoard()
    }
    
    // action for log out button
    // finish the current game in the backend and navigate to authentication screen
    @IBAction func logOutButtonTapped(sender: UIButton) {
//        OXGameController.sharedInstance.finishCurrentGame()
        self.resetBoard()
        if (self.networkGame) {
            self.navigationController!.popViewControllerAnimated(true)
        } else {
            // persistence
            NSUserDefaults.standardUserDefaults().setValue(nil, forKeyPath: "loggedInUser")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // there is no logout user method yet in the UserController
//            UserController.sharedInstance.logoutUser()
            appDelegate.navigateToLoggedOutNavigationController()
        }
    }
    
    // action for network play button
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
//        OXGameController.sharedInstance.finishCurrentGame()
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
        }
        self.updateUI()
        
        if (self.currentGame.guestUser?.email != "") {
            if (self.currentGame.localUsersTurn()) {
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
    }
    
    func updateUI() {
        
        // check if network game
        // if so, hide the new game button and network play buttons, and rename Logout to Cancel
        if (self.networkGame) {
            self.newGameButton.setTitle("Awaiting opponent to join...", forState: UIControlState.Normal)
            self.newGameButton.userInteractionEnabled = false
            self.logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            self.networkPlayButton.setTitle("Refresh", forState: UIControlState.Normal)
        }
        
        
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
