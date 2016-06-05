//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    var networkMode : Bool = false
    var gameObject = OXGame()
    var lastRotation: Float!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var networkPlayButton: UIButton!
    @IBOutlet weak var target2: UIButton!
    
    @IBOutlet weak var target7: UIButton!
    
    @IBOutlet weak var target9: UIButton!
    @IBOutlet weak var target3: UIButton!
    @IBOutlet weak var target8: UIButton!
    
    @IBOutlet weak var target6: UIButton!
    @IBOutlet weak var target5: UIButton!
    
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var target4: UIButton!
    
    @IBOutlet weak var target: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.userInteractionEnabled = true
        
        let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        //
        //        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
        //        self.view.addGestureRecognizer(pinch)
        //
        self.lastRotation = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func handlePinch(sender: UIPinchGestureRecognizer? = nil){
        print("Pinch Detected")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil){
        
        
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        //Rotation ends
        if (sender!.state == UIGestureRecognizerState.Ended){
            print("Rotation \(sender!.rotation)")
            
            if(sender!.rotation < CGFloat(M_PI)/4 || sender!.rotation > CGFloat((7/4) * M_PI)){
                //snap action
                UIView.animateWithDuration(NSTimeInterval(2), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(0)
                })
                
            }
            else if(sender!.rotation < CGFloat((3/4) * M_PI)){
                UIView.animateWithDuration(NSTimeInterval(2), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2.0))
                })
            }
            else if(sender!.rotation < CGFloat((5/4) * M_PI)){
                UIView.animateWithDuration(NSTimeInterval(2), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
            }
            else if(sender!.rotation < CGFloat((7/4) * M_PI)){
                UIView.animateWithDuration(NSTimeInterval(2), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(CGFloat((3.0/2.0) * M_PI))
                })
            }
        }
        print("stuff")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        if(networkMode){
            networkPlayButton.hidden = true
            logOutButton.setTitle("cancel", forState: UIControlState.Normal)
        }
    }

    @IBAction func buttonPressed(sender: UIButton) {
        
        let type = gameObject.playMove(sender.tag)
        print("Button \(sender.tag) pressed")
        sender.setTitle(String(type), forState: UIControlState.Normal)
        
        let state = gameObject.state()
        if state == OXGameState.complete_someone_one && type == CellType.O {
            print("Player 1 has won!")
            restartgame()
        }
        else if state == OXGameState.complete_someone_one && type == CellType.X {
            print("player 2 has won!")
            restartgame()
        }
        else if state == OXGameState.complete_no_one_won {
            print("The game is a tie.")
            restartgame()
        }
        else {
            print("Game in progress")
        }
        
    }
    
    @IBAction func newGame(sender: UIButton) {
        restartgame()
    }
    
    @IBAction func logOutPressed(sender: UIButton) {
        
        if(networkMode){
           self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLandingNavigationController()
            
            UserController.sharedInstance.deleteUser()
        }
    }
    
    @IBAction func networkPlayTapped(sender: AnyObject) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle : nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
    

    func restartgame() {
        gameObject.reset()
        target.setTitle("", forState: UIControlState.Normal)
        target2.setTitle("", forState: UIControlState.Normal)
        target9.setTitle("", forState: UIControlState.Normal)
        target4.setTitle("", forState: UIControlState.Normal)
        target5.setTitle("", forState: UIControlState.Normal)
        target6.setTitle("", forState: UIControlState.Normal)
        target7.setTitle("", forState: UIControlState.Normal)
        target8.setTitle("", forState: UIControlState.Normal)
        target3.setTitle("", forState: UIControlState.Normal)
    }
    
}
