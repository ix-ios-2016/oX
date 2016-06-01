//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var boardView: UIView!
    //@IBOutlet var boardView: UIView!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    var gameObject = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
//        let pinch = UIPinchGestureRecognizer(target: self, action:#selector(BoardViewController.handlePinch(_:)))
//        self.view.addGestureRecognizer(pinch)
        
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        print("pinch detected")
    }
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        print("rotation detected")
        if sender!.state == UIGestureRecognizerState.Ended {
            print("rotation \(sender!.rotation)")
            if abs(sender!.rotation) < CGFloat(M_PI/4) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                })
            }
        }
       // print("howdy")
        
    }
    
    //enum/ array of gestures? variable arraycombo
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        var gameState = String(gameObject.state())
        if gameState == "inProgress" {
            gameObject.playMove(sender.tag)
            sender.setTitle(String(gameObject.typeAtIndex(sender.tag)), forState: UIControlState.Normal)
            var newState = String(gameObject.state())
            if newState == "complete_someone_won" {
                if String(gameObject.whosTurn()) == "X" {
                    print("Congrats O won!")
                } else if String(gameObject.whosTurn()) == "O" {
                    print ("Congrats X won!")
                }
            } else if newState == "complete_no_one_won" {
                print ("you tied")
            }
        }
    }

    @IBAction func newGame(sender: AnyObject) {
        self.restartGame()
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        UserController.sharedInstance.logged_in_user!.email = ""
        UserController.sharedInstance.logged_in_user!.password = ""
        appDelegate.navigateToLandingViewController()
    }
    
    
    
    func restartGame() {
        gameObject.reset()
        button0.setTitle("", forState: UIControlState.Normal)
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        button4.setTitle("", forState: UIControlState.Normal)
        button5.setTitle("", forState: UIControlState.Normal)
        button6.setTitle("", forState: UIControlState.Normal)
        button7.setTitle("", forState: UIControlState.Normal)
        button8.setTitle("", forState: UIControlState.Normal)
        
//        for view in boardView.subviews {
//            if let button = view as? UIButton {
//                button.setTitle("", forState: UIControlState.Normal)
//            }
//        } or make an array of outlet objects
        
    }
    
}
