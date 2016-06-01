//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var game = OXGame()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        rotation.delegate = self
        self.boardView.addGestureRecognizer(rotation)
        
        
    }
    
    
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

    @IBOutlet var boardView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func boardTapped(sender: UIButton) {
        
        let tag = sender.tag
        print("board tapped \(tag)")
        
        let turn = game.whosTurn()
        
        if game.playMove(tag) != CellType.EMPTY {
            sender.setTitle(String(turn), forState: UIControlState.Normal)
        }
        
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
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
