//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var networkButton: UIButton!
    @IBOutlet weak var boardView: UIView!
    
    var currentGame = OXGameController.sharedInstance.getCurrentGame()!
    
    var networkPlay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        let pinch: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(BoardViewController.handlePinch(_:)))
        self.boardView.addGestureRecognizer(pinch)
        
        
        if networkPlay {
            logOut.setTitle("Cancel", forState: UIControlState.Normal)
            networkButton.hidden = true
        }
        
    }
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        print("pinch detected")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        print("Rotation detected")
        
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        if sender!.state == UIGestureRecognizerState.Ended {
            print("rotation \(sender!.rotation)")
            
            
             if sender!.rotation > CGFloat(M_PI)/6 {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))})
             } else /*if sender!.rotation < CGFloat(M_PI)/6*/ {
                UIView.animateWithDuration(NSTimeInterval(1), animations: {self.boardView.transform = CGAffineTransformMakeRotation(0)})

            }
 
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    func restartGame(){
        let restart = String(currentGame.reset())
        for button in boardView.subviews {
            if let vari = button as? UIButton {
                vari.setTitle(restart, forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
//        if networkPlay {
//        if currentGame.state() == OXGameState.inProgress  {
//            let tag = sender.tag
//            let player = String(OXGameController.sharedInstance.playMove(tag))
//            sender.setTitle(player, forState: UIControlState.Normal)
//            let (cellType,int) = OXGameController.sharedInstance.playRandomMove()!
//            sender.setTitle(cellType, forState: UIControlState.Normal)
//           
//        } else {
//            navigationController?.popViewControllerAnimated(true)
//            }
//         
//        } else {
//            let tag = sender.tag
//            print("Button Pressed \(tag)")
//            let player = String(OXGameController.sharedInstance.playMove(tag))
//            sender.setTitle(player, forState: UIControlState.Normal)
//            currentGame.state()
//            currentGame.winDetection()
//            
//        }
        
        let tag = sender.tag
        print("Button Pressed \(tag)")
        let player = String(OXGameController.sharedInstance.playMove(tag))
        sender.setTitle(player, forState: UIControlState.Normal)
        currentGame.state()
        currentGame.winDetection()
        
    }

    @IBAction func newGame(sender: AnyObject) {
        if networkPlay {
            print("Dont Start A New Game. You are in Network Mode")
        } else {
            print("New Game Pressed")
            restartGame()
        }
        
    }
    
    @IBAction func logOut(sender: UIButton) {
        
        if networkPlay {
           logOut.setTitle("Cancel", forState: UIControlState.Normal)
            navigationController?.popViewControllerAnimated(true)
            self.navigationController?.navigationBarHidden = false
        } else {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userLoggedIn")
            appDelegate.navigateToLandingNavigationController()
        }
        
        
    }

    @IBAction func networkButtonPressed(sender: UIButton) {
        let nvc = networkPlayViewController(nibName:"networkPlayViewController",bundle:nil)
        self.navigationController?.pushViewController(nvc, animated: true)
        networkPlay = true
    }
}
