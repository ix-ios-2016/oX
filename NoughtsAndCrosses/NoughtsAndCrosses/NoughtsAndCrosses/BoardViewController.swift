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
    var lastRotation: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Rotation
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        self.lastRotation = 0.0
    }
    
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
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        print("Pinch")
    }
    
    // Action for all buttons clicked
    @IBAction func buttonClicked(sender: AnyObject) {
        sender.setTitle(String(gameObject.whosTurn()), forState: .Normal)

        gameObject.playMove(sender.tag)
        
        let state = gameObject.state()
        if state == OXGame.OXGameState.complete_someone_won {
            let winMessage = UIAlertController(title: "Game over!", message: "Congratulations, player " + String(gameObject.typeAtIndex(sender.tag)) + ". You won!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in self.restartGame()})
            winMessage.addAction(okButton)
            
            self.presentViewController(winMessage, animated: true, completion: nil)
        }
        else if state == OXGame.OXGameState.complete_no_one_won {
            let tieMessage = UIAlertController(title: "Tie game.", message: "Play again!", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in self.restartGame()})
            tieMessage.addAction(okButton)
            
            self.presentViewController(tieMessage, animated: true, completion: nil)
        }
        else if state == OXGame.OXGameState.inProgress {
        }
        
        
    }
    
    // Action for new game click
    @IBAction func newGameClicked(sender: AnyObject) {
        restartGame()
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.onboardingNavigationController?.navigationBarHidden = true
        appDelegate.navigateToLandingViewController()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func restartGame () {
        gameObject.reset()
        gameObject = OXGame()
        
        for button in self.boardView.subviews as [UIView] {
            if let button = button as? UIButton {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
}
