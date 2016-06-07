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
    var lastRotation: Float!
    var places = [UIButton]()
    
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
        
        
        places.append(target)
        places.append(target2)
        places.append(target3)
        places.append(target4)
        places.append(target5)
        places.append(target6)
        places.append(target7)
        places.append(target8)
        places.append(target9)
        
        
        view.userInteractionEnabled = true
        
        let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        //
        //        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
        //        self.view.addGestureRecognizer(pinch)
        //
        self.lastRotation = 0.0
        
        let hey = ClosureExperiment()
        
    
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
            logOutButton.setTitle("cancel", forState: UIControlState.Normal)
            networkPlayButton.hidden = true
        }
    }

    @IBAction func buttonPressed(sender: UIButton) {
        
        let current = OXGameController.sharedInstance.getCurrentGame()!
        
        let type = OXGameController.sharedInstance.playMove(sender.tag)
        print("Button \(sender.tag) pressed")
        sender.setTitle(String(type), forState: UIControlState.Normal)
        
        let state = OXGameController.sharedInstance.getCurrentGame()!.state()
        if state == OXGameState.complete_someone_won && type == CellType.X {
            print("Player 1 has won!")
            restartgame()
        }
        else if state == OXGameState.complete_someone_won && type == CellType.O {
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
        
        if networkMode {
            if state != OXGameState.complete_someone_won || state != OXGameState.complete_no_one_won {
                if current.whosTurn() == CellType.O{
                    var (newMove, place) = OXGameController.sharedInstance.playRandomMove()!
                    current.board[place] = newMove
                    places[place].setTitle(String("O"), forState: UIControlState.Normal)
                    let state = OXGameController.sharedInstance.getCurrentGame()!.state()
                    if state == OXGameState.complete_someone_won && type == CellType.X {
                        print("Player 1 has won!")
                        restartgame()
                    }
                    else if state == OXGameState.complete_someone_won && type == CellType.O {
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
            }
        }
        //print(OXGameController.sharedInstance.gameList?.endIndex)
        
    }
    
    @IBAction func newGame(sender: UIButton) {
        restartgame()
    }
    
    @IBAction func logOutPressed(sender: UIButton) {
        OXGameController.sharedInstance.finishCurrentGame()
        if(networkMode){
           self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLandingNavigationController()
            
            UserController.sharedInstance.logoutCurrentUser()
        }
    }
    
    @IBAction func networkPlayTapped(sender: AnyObject) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle : nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
    

    func restartgame() {
        OXGameController.sharedInstance.getCurrentGame()!.reset()
        target.setTitle("", forState: UIControlState.Normal)
        target2.setTitle("", forState: UIControlState.Normal)
        target9.setTitle("", forState: UIControlState.Normal)
        target4.setTitle("", forState: UIControlState.Normal)
        target5.setTitle("", forState: UIControlState.Normal)
        target6.setTitle("", forState: UIControlState.Normal)
        target7.setTitle("", forState: UIControlState.Normal)
        target8.setTitle("", forState: UIControlState.Normal)
        target3.setTitle("", forState: UIControlState.Normal)
        OXGameController.sharedInstance.finishCurrentGame()
        if networkMode{
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
