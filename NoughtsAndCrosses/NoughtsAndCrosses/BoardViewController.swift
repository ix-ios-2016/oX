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
    
    // upon load initialize rotation and logout/cancel button
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if OXGameController.sharedInstance.getNetworkGame() {
            logoutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
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
        
        let tag = sender.tag
        print("board tapped \(tag)")
        
        var turn = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
        
        if OXGameController.sharedInstance.playMove(tag) != CellType.EMPTY {
            sender.setTitle(String(turn), forState: UIControlState.Normal)
            
            
            let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
            if gameState == OXGameState.complete_someone_won {
                let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                    action -> Void in
                    if OXGameController.sharedInstance.getNetworkGame() {
                        self.navigationController?.popViewControllerAnimated(true)
                        OXGameController.sharedInstance.setNetworkGame(false)
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
                    if OXGameController.sharedInstance.getNetworkGame() {
                        self.navigationController?.popViewControllerAnimated(true)
                        OXGameController.sharedInstance.setNetworkGame(false)
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
            else if OXGameController.sharedInstance.getNetworkGame() {
                turn = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
                if let (cellType, index) = OXGameController.sharedInstance.playRandomMove() {
                    buttons[index].setTitle(String(cellType), forState: UIControlState.Normal)
                    let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
                    if gameState == OXGameState.complete_someone_won {
                        let alert = UIAlertController(title: "Game Over!", message: "Winner: Player \(String(turn))", preferredStyle: UIAlertControllerStyle.Alert)
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                            action -> Void in
                            if OXGameController.sharedInstance.getNetworkGame() {
                                self.navigationController?.popViewControllerAnimated(true)
                                OXGameController.sharedInstance.setNetworkGame(false)
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
                            if OXGameController.sharedInstance.getNetworkGame() {
                                self.navigationController?.popViewControllerAnimated(true)
                                OXGameController.sharedInstance.setNetworkGame(false)
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
        if !OXGameController.sharedInstance.getNetworkGame() {
            restartGame()
        }
    }
    
    
    // control logout/cancel button actions
    @IBAction func logoutButtonTapped(sender: UIButton) {
        
        if OXGameController.sharedInstance.getNetworkGame() {
            OXGameController.sharedInstance.finishCurrentGame()
            self.navigationController?.popViewControllerAnimated(true)
            OXGameController.sharedInstance.setNetworkGame(false)
        }
        else {
            UserController.sharedInstance.logoutUser()
            print("Logged Out")
        
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLandingView()
        }
        
    }
 
    
    // control network play buttons action
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
}
