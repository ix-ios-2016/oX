//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit
import Darwin

class BoardViewController: UIViewController {
    
    // All outlets
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var networkPlayButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    // saves the last snap of rotation
    var lastSnap:CGFloat = CGFloat(0)

    
    override func viewDidLoad() {
        // do things for the look of the app
        super.viewDidLoad()
        self.title = "oX Game"
        
        // format the logoutButton
        formatButton(logoutButton)
        formatButton(networkPlayButton)
        
        
        // Create gesture recognizer
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        rotation.delegate = EasterEggController.sharedInstance
        self.boardView.addGestureRecognizer(rotation)
        
        
        // testing the loginuser thing
        //UserController.sharedInstance.loginUser()
    }
    
    override func viewWillAppear(animated: Bool) {
        // ensure the nav bar is hidden in game
        self.navigationController?.navigationBarHidden = true
        
        // change things if in network mode
        if OXGameController.sharedInstance.getNetworkMode()
        {
            networkPlayButton.hidden = true
            logoutButton.setTitle("Cancel Game", forState: .Normal)
            newGameButton.enabled = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // put the board back to the start position
        UIView.animateWithDuration(NSTimeInterval(0), animations: {
            self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
        })
        lastSnap = CGFloat(0)
        
        // send alert to user
        //        let userController = UserController.sharedInstance
        //
        //        print(userController.logged_in_user?.email)
        //
        //        let welcomeAlert = UIAlertController(title: "Welcome, " + (userController.logged_in_user?.email)!  + "!", message:
        //            (userController.logged_in_user?.email)! + "User is Xs and has the first move.", preferredStyle: UIAlertControllerStyle.Alert)
        //
        //        let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        //        welcomeAlert.addAction(okButton)
        //        // Present the message
        //        self.presentViewController(welcomeAlert, animated: true, completion: nil)
        
        
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
    
    
    
    // Outlet for all grid buttons
    @IBAction func gridButtonTapped(sender: AnyObject) {
        
        
        let currentGame = OXGameController.sharedInstance.getCurrentGame()
        
        print("sender.title = :" + String(sender.currentTitle))
        print("currentGame!.board[sender.tag] = :" + String(currentGame!.board[sender.tag]))
        
        if (currentGame!.board[sender.tag] == CellType.EMPTY)
        {
            print("Boardview whose turn: " + String(currentGame!.whoseTurn()))
            // Set the title of the button to whose turn it is
            sender.setTitle(String(OXGameController.sharedInstance.playMove(sender.tag)), forState: .Normal)
            
            // Call the playMove function on the specific button
            //OXGameController.sharedInstance.playMove(sender.tag)
            
            if moveLogic(sender.tag) {
                return
            }
        }
        
        // play with AI to simulate fun
        if OXGameController.sharedInstance.getNetworkMode()
        {
            // disable interaction
            self.boardView.userInteractionEnabled = false

            let DELAY_TIME = Int32(1)
            let seconds = DELAY_TIME
            let delay = Double(seconds) * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                if let (randomCellType, randomInt) = OXGameController.sharedInstance.playRandomMove()
                {
                    print("RandomInt: " + String(randomInt))
                    // Set the title of the button to whose turn it is
                    let buttons = self.boardView.subviews
                    
                    for button in buttons
                    {
                        if button is UIButton && button.tag == randomInt
                        {
                            
                            let button = button as? UIButton
                            button?.setTitle(String(randomCellType), forState: .Normal)
                            
                            if self.moveLogic(randomInt) {
                                return
                            }
                        }
                    }
                }
                // reenable interaction
                self.boardView.userInteractionEnabled = true
            })
        }
    }
    
    // Return true if the game ends
    private func moveLogic(index:Int) -> Bool
    {
        let currentGame = OXGameController.sharedInstance.getCurrentGame()
        
        // Get current the state of the game
        let gameState = currentGame!.state()
        
        if gameState == OXGame.OXGameState.complete_someone_won
        {
            let winner:String = String(currentGame!.typeAtIndex(index))
            let winAlert = UIAlertController(title: winner + "s Won!", message:
                winner + " has won the game! Weeeeeeee!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in
                self.restartGame()
            })
            winAlert.addAction(okButton)
            // Present the message
            self.presentViewController(winAlert, animated: true, completion: nil)
            
            // game ends, return true
            return true
        }
        else if gameState == OXGame.OXGameState.complete_no_one_won
        {
            let tieAlert = UIAlertController(title: "It's a Tie!", message:
                "It's a tie. Play again to break it!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in
                self.restartGame()})
            tieAlert.addAction(okButton)
            // Present the message
            self.presentViewController(tieAlert, animated: true, completion: nil)
            
            // game ends, return true
            return true
        }
        
        // game still in progress, return false
        return false
    }
    

    
    // Outlet for newGame Button
    @IBAction func newGameButtonTapped(sender: AnyObject) {
        // Call the restartGame function
        restartGame()
    }
    
    // Handle user logout OR use cancel the current game
    @IBAction func logoutButtonTapped(sender: UIButton) {
        
        // the button works differently depending whether playing online or not
        if OXGameController.sharedInstance.getNetworkMode()
        {
            let cancelAlert = UIAlertController(title: "Are you sure?", message: "You are about to cancel and leave the game. \nPress \"Stay\" to stay in the game.", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Leave", style: .Destructive, handler: {(UIAlertAction) -> Void in
                self.restartGame()
            })
            let cancelButton = UIAlertAction(title: "Stay", style: .Cancel, handler: nil)
            cancelAlert.addAction(cancelButton)
            cancelAlert.addAction(okButton)
            // Present the message
            self.presentViewController(cancelAlert, animated: true, completion: nil)
        }
        else
        {
            // logout the user and restart the game
            restartGame()
            UserController.sharedInstance.logoutUser()
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedOutViewController()
        }
    }
    
    // Handle network play switch
    @IBAction func networkPlayTapped(sender: AnyObject) {
        // create new viewController and push it
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // format buttons
    func formatButton(button: UIButton)
    {
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    // PRIVATE HELPER FUNCTIONS ********************************************
    // restart the game
    private func restartGame()
    {
        OXGameController.sharedInstance.finishCurrentGame()
        
        for view in self.boardView.subviews as [UIView]
        {
            if let button = view as? UIButton
            {
                button.setTitle("", forState: .Normal)
            }
        }
        
        if OXGameController.sharedInstance.networkMode
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    
    
    
}
