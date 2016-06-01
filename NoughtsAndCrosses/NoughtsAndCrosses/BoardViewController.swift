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
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var gameObject:OXGame = OXGame()
    
    override func viewDidLoad() {
        // do things for the look of the app
        super.viewDidLoad()
        self.title = "Login"
        
        // format the logoutButton
        logoutButton.backgroundColor = UIColor.clearColor()
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = UIColor.blackColor().CGColor
        
        // Create gesture recognizer
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        //self.lastRotation = 0.0
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil)
    {
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        if (sender!.state == UIGestureRecognizerState.Ended)
        {
            let myRotation = sender!.rotation % CGFloat(2*M_PI)
            print("rotation: " + String((sender!.rotation % CGFloat(2*M_PI))))
            
            // positive rotation
            if myRotation > 0
            {
                // up
                if (myRotation < CGFloat(M_PI/4) ||
                    myRotation > CGFloat((7*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    })
                }
                    // right
                else if (myRotation > CGFloat(M_PI/4) &&
                    myRotation < CGFloat((3*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
                    })
                }
                    // down
                else if (myRotation > CGFloat((3*M_PI)/4) &&
                    myRotation < CGFloat((5*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    })
                }
                    // left
                else if (myRotation > CGFloat((5*M_PI)/4) &&
                    myRotation < CGFloat((7*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat((3*M_PI)/2))
                    })
                }
            }
            // negative rotation
            else if myRotation < 0
            {
                // up
                if (myRotation > CGFloat(-M_PI/4) ||
                    myRotation < CGFloat(-(7*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    })
                }
                // right
                else if (myRotation > CGFloat(-(7*M_PI)/4) &&
                         myRotation < CGFloat(-(5*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(-3*M_PI/2))
                    })
                }
                // down
                else if (myRotation < CGFloat(-(3*M_PI)/4) &&
                         myRotation > CGFloat(-(5*M_PI)/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
                    })
                }
                // left
                else if (myRotation > CGFloat(-3*M_PI/4) &&
                         myRotation < CGFloat(-M_PI/4))
                {
                    UIView.animateWithDuration(NSTimeInterval(1), animations: {
                        self.boardView.transform = CGAffineTransformMakeRotation(CGFloat((3*M_PI)/2))
                    })
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
//        // send alert to user
//        let userController = UserController.sharedInstance
//        let welcomeAlert = UIAlertController(title: "Welcome, " + (userController.logged_in_user?.email)! + "!", message:
//            (userController.logged_in_user?.email)! + " is Xs and has the first move.", preferredStyle: UIAlertControllerStyle.Alert)
//        let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
//        welcomeAlert.addAction(okButton)
//
//        // Present the message
//        self.presentViewController(welcomeAlert, animated: true, completion: nil)
    }
    
    // Outlet for all grid buttons
    @IBAction func gridButtonTapped(sender: AnyObject) {
        
        
        if String(sender.title) == ""
        {
            // Set the title of the button to whose turn it is
            sender.setTitle(String(gameObject.whoseTurn()), forState: .Normal)
            // Call the playMove function on the specific button
            gameObject.playMove(sender.tag)
            
            
            // Get current the state of the game
            let gameState = gameObject.state()
            
            if gameState == OXGame.OXGameState.complete_someone_won
            {
                let winner:String = String(gameObject.typeAtIndex(sender.tag))
                
                let winAlert = UIAlertController(title: winner + "s Won!", message:
                    winner + " has won the game! Weeeeeeee!", preferredStyle: UIAlertControllerStyle.Alert)
                let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in
                    self.restartGame()})
                winAlert.addAction(okButton)
                
                // Present the message
                self.presentViewController(winAlert, animated: true, completion: nil)
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
            }
        }
    }
    
    func restartGame() {
        gameObject.reset()
        gameObject = OXGame()
        
        for view in self.boardView.subviews as [UIView]
        {
            if let button = view as? UIButton
            {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
    // Outlet for newGame Button
    @IBAction func newGameButtonTapped(sender: AnyObject) {
        // Call the restartGame function
        restartGame()
    }
    
    // Handle user logout
    @IBAction func logoutButtonTapped(sender: UIButton) {
        restartGame()
        
        UserController.sharedInstance.logoutUser()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToLoggedOutViewController()
        
        // get rid of this viewController instance
        // self.view = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    

}
