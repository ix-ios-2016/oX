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
    
    var gameObject = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a rotation gesture recognizer
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(
            target: self, action: #selector(BoardViewController.handleRotation(_:)))
//        rotation.delegate = self
        rotation.delegate = EasterEggController.sharedInstance
        self.boardContainer.addGestureRecognizer(rotation)
        
        // create pinch gesture recognizer
//        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
//        self.boardContainer.addGestureRecognizer(pinch)
        
        
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        self.boardContainer.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
//        print("board rotation")
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("rotation ended at: \(sender!.rotation)")
            UIView.animateWithDuration(NSTimeInterval(1), animations: {
                // can use CGFloat(M_PI)
                self.boardContainer.transform = CGAffineTransformMakeRotation(0)
            })
            
        }
    }
    
//    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
//        print("pinch")
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        // play the move
        gameObject.playMove(sender.tag)
        sender.setTitle(String(gameObject.typeAtIndex(sender.tag)),
                        forState: UIControlState.Normal)
        print("button \(sender.tag) tapped")
        
        // check the game state
        let currentState = gameObject.state()
        switch currentState {
        case OXGameState.complete_someone_won:
            print("Winner is \(gameObject.typeAtIndex(sender.tag))")
            // create alert controller and OK action
            let alertController = UIAlertController(title: "Game over!",
                                                    message: "Winner is \(gameObject.typeAtIndex(sender.tag))",
                                                    preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in}
            // add OK action to alert controller
            alertController.addAction(OKAction)
            // display alert
            self.presentViewController(alertController, animated: true, completion: nil)
        case OXGameState.complete_no_one_won:
            print("Game tied.")
            // create alert controller and OK action
            let alertController = UIAlertController(title: "Game over!",
                                                    message: "Game is tied.",
                                                    preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in}
            // add OK action to alert controller
            alertController.addAction(OKAction)
            // display alert
            self.presentViewController(alertController, animated: true, completion: nil)
        default:
            break
        }
        
        
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        gameObject.reset()
        for item in boardContainer.subviews {
            if let button = item as? UIButton {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func logOutButtonTapped(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        UserController.sharedInstance.logoutUser()
        appDelegate.navigateToLoggedOutNavigationController()
    }
    
}
