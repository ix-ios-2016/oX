//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit


class BoardViewController: UIViewController {
    
    // All outlets
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var networkPlayButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    //var gameObject = OXGame()
    var lastRotation: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Rotation
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        self.lastRotation = 0.0
    }
    
    // Make sure navigation bar is hidden
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        if (OXGameController.sharedInstance.getNetworkMode()) {
            networkPlayButton.hidden = true
            logOutButton.setTitle("Leave Game", forState: .Normal)
        }
    }
    
    // Handle rotation on the board
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        //Rotation ends
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        print("Rotate")
        if (sender!.state == UIGestureRecognizerState.Ended) {
            
            if ((sender!.rotation % CGFloat(M_PI)) < CGFloat(M_PI/4)) {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {self.boardView.transform = CGAffineTransformMakeRotation(0)
                })
            }
            
            else if ((sender!.rotation % CGFloat(M_PI)) < CGFloat(M_PI/2)) {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
                })
            }
            
            else if ((sender!.rotation % CGFloat(M_PI)) < CGFloat(M_PI)) {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
            }
            
            else if ((sender!.rotation % CGFloat(M_PI)) < CGFloat(5*M_PI/2)) {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
                })
            }
            print("Rotation \(sender!.rotation)")
        }
    }
    
    // Action for all game board buttons clicked
    @IBAction func buttonClicked(sender: UIButton) {
        var gameObject = OXGameController.sharedInstance.getCurrentGame()
        var index = sender.tag
        
        if (gameObject!.board[sender.tag] == CellType.EMPTY)
        {
            sender.setTitle(String(gameObject!.whosTurn()), forState: .Normal)
            OXGameController.sharedInstance.playMove(sender.tag)
            var state = gameObject!.state()
            
            if (state == OXGameState.inProgress) && (OXGameController.sharedInstance.getNetworkMode()){
                let (randomCellType, randomIndex):(CellType, Int) = OXGameController.sharedInstance.playRandomMove()!
                
                for button in self.boardView.subviews as [UIView] {
                    if let button = button as? UIButton {
                        if button.tag == randomIndex{
                            button.setTitle(String(randomCellType), forState: .Normal)
                        }
                    }
                }
                index = randomIndex
            }
            
            gameObject = OXGameController.sharedInstance.getCurrentGame()
            state = gameObject!.state()
            
            if state == OXGameState.complete_someone_won {
                let winMessage = UIAlertController(title: "Game over!", message: "Congratulations, player " + String(gameObject!.typeAtIndex(index)) + ". You won!", preferredStyle: UIAlertControllerStyle.Alert)
                let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in self.restartGame()})
                winMessage.addAction(okButton)
                
                OXGameController.sharedInstance.finishCurrentGame()
                
                self.presentViewController(winMessage, animated: true, completion: nil)
            }
            else if state == OXGameState.complete_no_one_won {
                let tieMessage = UIAlertController(title: "Tie game.", message: "Play again!", preferredStyle: UIAlertControllerStyle.Alert)
                let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in self.restartGame()})
                tieMessage.addAction(okButton)
                
                OXGameController.sharedInstance.finishCurrentGame()

                self.presentViewController(tieMessage, animated: true, completion: nil)
            }
            else if state == OXGameState.inProgress {
            }
        }
    }
    
    // Action for user tapping Network Play button
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        let nvc = NetworkPlayViewController()
        self.navigationController?.pushViewController(nvc, animated: true)
        
    }
    
    // Action for new game click
    @IBAction func newGameClicked(sender: AnyObject) {
        if (OXGameController.sharedInstance.getNetworkMode()) {
            newGameButton.enabled = false
        }
        else {
            restartGame()
        }
    }
    
    // Action for Log out button tapped
    @IBAction func logoutTapped(sender: UIButton) {
        OXGameController.sharedInstance.finishCurrentGame()
        
        if (OXGameController.sharedInstance.getNetworkMode()) {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.landingNavigationController?.navigationBarHidden = true
            appDelegate.navigateToLandingViewController()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func restartGame () {
        var gameObject = OXGameController.sharedInstance.getCurrentGame()

        gameObject!.reset()
        gameObject! = OXGame()
        
        for button in self.boardView.subviews as [UIView] {
            if let button = button as? UIButton {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
}
