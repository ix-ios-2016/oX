//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var networkPlay: UIButton!
    @IBOutlet weak var boardView: UIView!
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
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var networkMode = false
    var gameOver = false
    var currentGame = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let _ = ClosureExperiment()
//        view.userInteractionEnabled = true
//        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
//        self.boardView.addGestureRecognizer(rotation)
//        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
//        self.view.addGestureRecognizer(pinch)
        if networkMode {
            logOutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
        }
        self.updateUI()
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            
            if (sender!.rotation < CGFloat(M_PI/4)) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(0)
                })
            }
            self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func boardTapped(sender: AnyObject) {
        let status = currentGame.state()

        if networkMode {
            if status == OXGameState.inProgress {
                sender.setTitle(String(currentGame.playMove(sender.tag)), forState: UIControlState.Normal)
                OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMoveComplete(game, message:message)})
            }
            
        } else {
            if status == OXGameState.inProgress {
                sender.setTitle(String(currentGame.playMove(sender.tag)), forState: UIControlState.Normal)
                let gameState = currentGame.state()
                if (gameState == OXGameState.complete_no_one_won) {
                    winningMessage.text = "Tie! No player wins."
                } else if (gameState == OXGameState.complete_someone_won) {
                    if (currentGame.whosTurn() == CellType.X) {
                        winningMessage.text = "Player O wins"
                    } else if (currentGame.whosTurn() == CellType.O){
                    winningMessage.text = "Player X wins"
                    }
                }
            }
        }
    }
    
    func restartGame() {
        currentGame.reset()
        winningMessage.text = ""
        let buttons = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        for button in buttons {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        currentGame.reset()
        restartGame()
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
        if (networkMode == true) {
            OXGameController.sharedInstance.cancelGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(bool,message) in self.endGame(bool, message:message)})
            self.navigationController?.popViewControllerAnimated(true)
            self.navigationController?.navigationBarHidden = true
        } else {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLogOutNavigationController()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true

    }

    @IBAction func networkPlayTapped(sender: AnyObject) {
        if (networkMode == false) {
            let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
            self.navigationController?.pushViewController(npc, animated: true)
        }
    }
    
    func updateUI() {
        
        if networkMode {
            logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            networkPlay.hidden = true
            if currentGame.guestUser?.email != nil {
                if currentGame.state() == OXGameState.complete_someone_won {
                    boardView.userInteractionEnabled = false
                    if currentGame.localUsersTurn() {
                        newGameButton.setTitle("You lose!", forState: UIControlState.Normal)
                    } else {
                        newGameButton.setTitle("You win!", forState: UIControlState.Normal)
                    }
                } else if currentGame.state() == OXGameState.complete_no_one_won {
                    newGameButton.setTitle("O wins!", forState: UIControlState.Normal)
                } else {
                    if currentGame.localUsersTurn() {
                        boardView.userInteractionEnabled = true
                        newGameButton.setTitle("Your turn", forState: UIControlState.Normal)
                    } else {
                        boardView.userInteractionEnabled = false
                        newGameButton.setTitle("Opponent's turn", forState: UIControlState.Normal)
                    }
                }
            } else {
                newGameButton.setTitle("Waiting for opponent to join...", forState: UIControlState.Normal)
                boardView.userInteractionEnabled = false
            }
        } else {
            logOutButton.setTitle("Log Out", forState: UIControlState.Normal)
            refreshButton.hidden = true
        }
        
    }
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        OXGameController.sharedInstance.getGame(self.currentGame.gameId!, viewControllerCompletionFunction: {(game,message) in self.updateGame(game, message:message)})
    }
    
    func playMoveComplete(game:OXGame?, message:String?) {
        if game != nil {
            self.currentGame = game!
            self.updateUI()
        }
    }
    
    func updateGame(game: OXGame?, message: String?) {
        if game != nil {
            self.currentGame = game!
        }
        self.updateUI()
    }
    
    func endGame(cancel: Bool?, message: String?) {
                
    }
    
}
