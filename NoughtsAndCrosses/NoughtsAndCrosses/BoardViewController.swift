//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var networkPlayButton: UIButton!
    @IBOutlet var boardView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    var networkGame: Bool = false
    
    // upon load initialize rotation and logout/cancel button
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.networkGame {
            logoutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
            newGameButton.setTitle("Update Board", forState: UIControlState.Normal)
            networkPlayButton.hidden = true
        }
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        
    }
    
    
    // rotate board with rotation gesture
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        if sender!.state == UIGestureRecognizerState.Ended {
            
            print("rotation \(sender!.rotation)")
            
            if sender!.rotation > CGFloat(M_PI_2 / 3) {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
            }
            else if sender!.rotation < CGFloat(-M_PI_2 / 3) {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
                })
            }
            
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // hide navigation bar every time view appears
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    
    // try to play move if board is tapped
    @IBAction func boardTapped(sender: UIButton) {
        /*
        let tag = sender.tag
        print("board tapped \(tag)")
        
        var turn = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
        
        if OXGameController.sharedInstance.getCurrentGame()!.playMove(tag) != CellType.EMPTY {
            sender.setTitle(String(turn), forState: UIControlState.Normal)
            
            var s: String = ""
            for i in 0...8 {
                s.append(String(OXGameController.sharedInstance.getCurrentGame()?.board[i])[String(OXGameController.sharedInstance.getCurrentGame()?.board[i]).startIndex])
            }
            
            OXGameController.sharedInstance.playMove(s, gameId: (OXGameController.sharedInstance.getCurrentGame()?.gameId)!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMove(game, message: message)})
            
            
            let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
            
            if gameState == OXGameState.complete_someone_won {
                let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                    action -> Void in
                    if self.networkGame {
                        self.navigationController?.popViewControllerAnimated(true)
                        self.networkGame = false
                    }
                    else {
                        self.restartGame()
                    }
                }
                alert.addAction(closeAction)
                self.presentViewController(alert, animated: true, completion: nil)
                OXGameController.sharedInstance.finishCurrentGame()
                
            }
            else if gameState == OXGameState.complete_no_one_won {
                let alert = UIAlertController(title: "Game Over!", message: "Tie Game, no winner!", preferredStyle: UIAlertControllerStyle.Alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                    action -> Void in
                    if self.networkGame {
                        self.navigationController?.popViewControllerAnimated(true)
                        self.networkGame = false
                    }
                    else {
                        self.restartGame()
                    }
                }
                alert.addAction(closeAction)
                self.presentViewController(alert, animated: true, completion: nil)
                OXGameController.sharedInstance.finishCurrentGame()
            }
                
                // if networkGame, play computer move automatically
            else if self.networkGame {
                turn = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
                if let (cellType, index) = OXGameController.sharedInstance.playRandomMove() {
                    buttons[index].setTitle(String(cellType), forState: UIControlState.Normal)
                    let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
                    if gameState == OXGameState.complete_someone_won {
                        let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                            action -> Void in
                            if self.networkGame {
                                self.navigationController?.popViewControllerAnimated(true)
                                self.networkGame = false
                            }
                            else {
                                self.restartGame()
                            }
                        }
                        alert.addAction(closeAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        OXGameController.sharedInstance.finishCurrentGame()
                    }
                    else if gameState == OXGameState.complete_no_one_won {
                        let alert = UIAlertController(title: "Game Over!", message: "Tie Game, no winner!", preferredStyle: UIAlertControllerStyle.Alert)
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                            action -> Void in
                            if self.networkGame {
                                self.navigationController?.popViewControllerAnimated(true)
                                self.networkGame = false
                            }
                            else {
                                self.restartGame()
                            }
                        }
                        alert.addAction(closeAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        OXGameController.sharedInstance.finishCurrentGame()
                    }
                }
            }
        }*/
        
        if networkGame {
            
            var s: String = ""
            for i in 0...8 {
                if sender.tag == i && OXGameController.sharedInstance.getCurrentGame()!.board[i] == CellType.EMPTY {
                    
                    if OXGameController.sharedInstance.getCurrentGame()?.whosTurn() == CellType.O {
                        s += "o"
                    }
                    else if OXGameController.sharedInstance.getCurrentGame()?.whosTurn() == CellType.X {
                        s += "x"
                    }
                }
                else {
                    if OXGameController.sharedInstance.getCurrentGame()!.board[i] == CellType.EMPTY {
                        s += "_"
                    }
                    else if OXGameController.sharedInstance.getCurrentGame()!.board[i] == CellType.X {
                        s += "x"
                    }
                    else {
                        s += "o"
                    }
                }
            }
            
            OXGameController.sharedInstance.playMove(s, gameId: (OXGameController.sharedInstance.getCurrentGame()?.gameId)!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.refreshBoard(game, message: message)})
            
        }
        else {
            
            let tag = sender.tag
            print("board tapped \(tag)")
            
            let turn = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
            
            if OXGameController.sharedInstance.getCurrentGame()!.playMove(tag) != CellType.EMPTY {
                sender.setTitle(String(turn), forState: UIControlState.Normal)
                
                if OXGameController.sharedInstance.getCurrentGame()!.playMove(tag) != CellType.EMPTY {
                    sender.setTitle(String(turn), forState: UIControlState.Normal)
                    
                    
                    let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
                    
                    if gameState == OXGameState.complete_someone_won {
                        let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                            action -> Void in
                            if self.networkGame {
                                self.navigationController?.popViewControllerAnimated(true)
                                self.networkGame = false
                            }
                            else {
                                self.restartGame()
                            }
                        }
                        alert.addAction(closeAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        OXGameController.sharedInstance.finishCurrentGame()
                        
                    }
                    else if gameState == OXGameState.complete_no_one_won {
                        let alert = UIAlertController(title: "Game Over!", message: "Tie Game, no winner!", preferredStyle: UIAlertControllerStyle.Alert)
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                            action -> Void in
                            if self.networkGame {
                                self.navigationController?.popViewControllerAnimated(true)
                                self.networkGame = false
                            }
                            else {
                                self.restartGame()
                            }
                        }
                        alert.addAction(closeAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        OXGameController.sharedInstance.finishCurrentGame()
                    }
                }
            }
            
        }
    
    }
    
    

    
    
    // reset game in memory and clear board in view
    func restartGame() {
        OXGameController.sharedInstance.getCurrentGame()!.reset()
        for button in buttons {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    
    // start newGame iff not in network mode
    @IBAction func newGame(sender: UIButton) {
        if !self.networkGame {
            restartGame()
        }
        else {
            OXGameController.sharedInstance.getGame((OXGameController.sharedInstance.getCurrentGame()?.gameId!)!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.refreshBoard(game, message: message)})
        }
    }
    
    func refreshBoard(game: OXGame?, message: String?) {
        
        if let game = game {
            OXGameController.sharedInstance.getCurrentGame()?.board = game.board
            var i = 0
            for button in buttons {
                button.setTitle(game.board[i].rawValue, forState: UIControlState.Normal)
                i += 1
            }
        }
        else if let message = message {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
        
        let turn = OXGameController.sharedInstance.getCurrentGame()?.whosTurn()
        
        if gameState == OXGameState.complete_someone_won {
            let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                action -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                    self.networkGame = false
            }
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            OXGameController.sharedInstance.finishCurrentGame()
            
        }
        else if gameState == OXGameState.complete_no_one_won {
            let alert = UIAlertController(title: "Game Over!", message: "Tie Game, no winner!", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                action -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                    self.networkGame = false
            }
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            OXGameController.sharedInstance.finishCurrentGame()
        }
        
    }
    
    
    // control logout/cancel button actions
    @IBAction func logoutButtonTapped(sender: UIButton) {
        
        if self.networkGame {
            OXGameController.sharedInstance.cancelGame((OXGameController.sharedInstance.getCurrentGame()?.gameId)!, presentingViewController: self, viewControllerCompletionFunction: {(bool, message) in self.cancelGame(bool, message: message)})

        }
        else {
            UserController.sharedInstance.logoutUser()
            print("Logged Out")
        
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLandingView()
        }
        
    }
    
    func cancelGame(bool: Bool?, message: String?) {
        OXGameController.sharedInstance.finishCurrentGame()
        self.navigationController?.popViewControllerAnimated(true)
        self.networkGame = false
    }
 
    
    // control network play buttons action
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
}
