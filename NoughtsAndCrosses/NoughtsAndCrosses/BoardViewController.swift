//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var networkGame = false
    
    // variable for starting rotation
    var lastSnap = CGFloat(0)
    
    var buttons: [UIButton] = []
    
    var currentGame = OXGame()
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        if (networkGame) {
            logoutButton.setTitle("Cancel Game", forState: .Normal)
            newGameButton.hidden = true
            networkPlay.hidden = true
            refreshButton.hidden = false
        } else {
            refreshButton.hidden = true
        }
    }
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        if (networkGame) {
            let network = NetworkPlayViewController()
            newGameButton.setTitle("GAME CANCELLED", forState: .Normal)
            
            
            OXGameController.sharedInstance.cancelGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction:{(boolean, message) in
                
                print("hey")
            
            })
            
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            appDelegate.navigateToAuthorisationNavigationController()
        }
        
    }
    
    // All outlets
    @IBOutlet weak var BoardView: UIView!
   
    @IBOutlet weak var logoutButton: UIButton!
    
    // Creates outlets for each individual square
    @IBOutlet weak var Square1Button: UIButton!
    @IBOutlet weak var Square2Button: UIButton!
    @IBOutlet weak var Square3Button: UIButton!
    @IBOutlet weak var Square4Button: UIButton!
    @IBOutlet weak var Square5Button: UIButton!
    @IBOutlet weak var Square6Button: UIButton!
    @IBOutlet weak var Square7Button: UIButton!
    @IBOutlet weak var Square8Button: UIButton!
    @IBOutlet weak var Square9Button: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    // Outlet for network play button
    @IBOutlet weak var networkPlay: UIButton!
    
    //  Refresh button is pushed
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        OXGameController.sharedInstance.getGame(self.currentGame.gameId!, viewControllerCompletionFunction: {(game,message) in self.gameUpdateReceived(game,message:message)})
    }
    
    func gameUpdateReceived(game:OXGame?, message:String?) {
        if let gameReceived = game {
            self.currentGame = gameReceived
        }
        self.updateUI()
    }
    
    // Changes to NetworkPlay View Controller
    @IBAction func networkPlayTapped(sender: UIButton) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.navigationBarHidden = false
        self.refreshButton.hidden = false
        self.navigationController?.pushViewController(npc, animated: true)
    }   
    
    // Outlets for grid buttons
    @IBAction func GridButtonPushed(sender: AnyObject) {
        //print(OXGameController.sharedInstance.getCurrentGame()!.whosTurn())
        if (currentGame.board[sender.tag] == CellType.EMPTY) {
            
            if networkGame {
                currentGame.playMove(sender.tag)
                OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game,message) in self.playMoveComplete(game,message:message)})
            }
            else {
                let celltype = currentGame.playMove(sender.tag)
                sender.setTitle(String(celltype), forState: .Normal)
                // gameState stores the state of the game
                let gameState = currentGame.state()
                // game resets the game once a winner has been declared
                var game = 0
                
                
                // checks if the player who last made the turn won, or if the game ended in a tie/is still ongoing
                
                if (gameState == OXGameState.complete_someone_won) {
                    print("Congratulations " + String(currentGame) + ", you won!")
                    game += 1
                    if game == 1 {
                        self.restartGame()
                    }
                } else if gameState == OXGameState.complete_no_one_won {
                    print("The game was tied")
                    self.restartGame()
                    if (networkGame) {
                        newGameButton.setTitle("GAME TIED", forState: .Normal)
                    }
                } else {
                    print("game still ongoing")
                }
            }
        } else {
            return
        }
    }

    func playMoveComplete(game:OXGame?, message: String?) {
        if let game = game {
            currentGame = game
            updateUI()
        }
        else {
            print("move didnt work")
        }
    }
    
    // New Game button is pressed
    @IBAction func newGameButton(sender: UIButton) {
        self.restartGame()
    }

    
    // function that restarts game and sets the individual squares to blank
    func restartGame(){
        currentGame.reset()
        //currentGame.finishCurrentGame()
        Square1Button.setTitle("", forState: .Normal)
        Square2Button.setTitle("", forState: .Normal)
        Square3Button.setTitle("", forState: .Normal)
        Square4Button.setTitle("", forState: .Normal)
        Square5Button.setTitle("", forState: .Normal)
        Square6Button.setTitle("", forState: .Normal)
        Square7Button.setTitle("", forState: .Normal)
        Square8Button.setTitle("", forState: .Normal)
        Square9Button.setTitle("", forState: .Normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buttons = [Square1Button, Square2Button, Square3Button, Square4Button, Square5Button, Square6Button, Square7Button, Square8Button, Square9Button]
        
         //create an instance of UIRotationGestureRecognizer
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: Selector("handleRotation:"))
        self.BoardView.addGestureRecognizer(rotation)
        self.updateUI()
    }

    func updateUI() {
        for view in BoardView.subviews {
            if let button = view as? UIButton {
                button.setTitle(self.currentGame.board[button.tag].rawValue, forState: UIControlState.Normal)
            }
        }
        if (networkGame) {
            self.logoutButton.setTitle("Cancel Game", forState: .Normal)
        }
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        self.BoardView.transform = CGAffineTransformMakeRotation(sender!.rotation + lastSnap)
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("rotation \(sender!.rotation)")
            if (sender!.rotation > CGFloat(0)) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                    self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(0))})
                print("clockwise rotation detected")
            }
        }
        else {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                    self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(0))})
                print("counterclockwise rotation detected")
        }
    }
}