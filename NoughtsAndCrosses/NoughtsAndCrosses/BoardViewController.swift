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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // send alert to user
        let userController = UserController.sharedInstance
        let welcomeAlert = UIAlertController(title: "Welcome, " + (userController.logged_in_user?.email)! + "!", message:
            (userController.logged_in_user?.email)! + " is Xs and has the first move.", preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        welcomeAlert.addAction(okButton)
        // Present the message
        self.presentViewController(welcomeAlert, animated: true, completion: nil)
    }
    
    // Outlet for all grid buttons
    @IBAction func gridButtonTapped(sender: AnyObject) {
        
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
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            winAlert.addAction(okButton)

            // Present the message
            self.presentViewController(winAlert, animated: true, completion: nil)

            restartGame()
        }
        else if gameState == OXGame.OXGameState.complete_no_one_won
        {
            let tieAlert = UIAlertController(title: "It's a Tie!", message:
                "It's a tie. Play again to break it!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            tieAlert.addAction(okButton)
            
            // Present the message
            self.presentViewController(tieAlert, animated: true, completion: nil)
            
            restartGame()
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
