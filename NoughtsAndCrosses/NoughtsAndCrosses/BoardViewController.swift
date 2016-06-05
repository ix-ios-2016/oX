//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    
    //var gameObject = OXGameController.sharedInstance.getCurrentGame() removed this in favor of just doing the latter half throughout my code where I had previously used gameObject
    
    var networkGame : Bool = false
  
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    
    @IBOutlet var Buttons: [UIButton]!
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    //We want access to this button to be able to set it to hidden once a game starts
    @IBOutlet weak var networkPlayButton: UIButton!
    
    
    var lastRotation : Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //allow for user interaction
        view.userInteractionEnabled = true
        
        //create an instance of UIRotationGestureRecognizer
        let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        //Initialize lastRotation
        self.lastRotation = 0.0
        
        if(networkGame) {
            
            logoutButton.setTitle("Cancel", forState: UIControlState.Normal)
            networkPlayButton.hidden = true
            
//            if (OXGameController.sharedInstance.getCurrentGame()?.state() == OXGameState.inProgress) {
//                if (OXGameController.sharedInstance.getCurrentGame()?.whosTurn() == CellType.O) {
//                    OXGameController.sharedInstance.playRandomMove()
//                }
//            
//            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.gameNavigationController.navigationBarHidden = true
        
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        
        if (!networkGame) {
            let lvc = LandingViewController(nibName: "LandingViewController", bundle: nil)
            self.navigationController?.pushViewController(lvc, animated: true)
            
        } else {
            //let nvc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        //I think this should happen if you click reset OR cancel
        OXGameController.sharedInstance.finishCurrentGame()
    }
    
    
    
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
//    func handlePinch(sender: UIPinchGestureRecognizer? = nil){
//        print("Pinch recognized")
//    }
    
    
    func handleRotation(sender : UIRotationGestureRecognizer? = nil) {
       
        print("Rotate recognized")
        
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation )
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            
            print("rotation \(sender!.rotation)")

            if (sender!.rotation < CGFloat(M_PI/4)) {
            
                
                //snap action 
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                self.boardView.transform = CGAffineTransformMakeRotation( CGFloat(0)); //what's in the parenthesis represents where we want the board's angle to end (i.e. M_PI would flip the board because PI radians = 180 degrees
                })
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
   
    @IBAction func buttonTapped(sender: UIButton) {
        
        var buttons = [Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8]
        
        let tag = sender.tag
        
        print ("Button: \(tag) was tapped")
        let result = String(OXGameController.sharedInstance.playMove(tag))
        sender.setTitle(result, forState: UIControlState.Normal)
        
        let gameState = OXGameController.sharedInstance.getCurrentGame()?.state()
        
        if (networkGame) {
            if (OXGameController.sharedInstance.getCurrentGame() != nil) {
                if (OXGameController.sharedInstance.getCurrentGame()?.state() == OXGameState.inProgress) {
                    if let tmp = OXGameController.sharedInstance.playRandomMove() {
                        buttons[tmp.1].setTitle(String(tmp.0), forState: UIControlState.Normal)
                    }
                }
            }
        } 
        
        if (gameState == OXGameState.complete_someone_won){
            
            if (OXGameController.sharedInstance.getCurrentGame()?.whosTurn() == CellType.X){
                
                let alert = UIAlertView()
                alert.title = "Victory!"
                alert.message = "Congrats 0, you won!"
                alert.addButtonWithTitle("Exit") 
                alert.show()

                print("Congrats O, you won")
                
                
            } else {
                
                let alert = UIAlertView()
                alert.title = "Victory!"
                alert.message = "Congrats X, you won!"
                alert.addButtonWithTitle("Exit")
                alert.show()
                print("Congrats X, you won")
                
            }
        }
        if (gameState == OXGameState.complete_no_one_won) {
            print ("This game was a tie")
        }
        
    
    }
//    Create a function called restartGame that calls the reset function on the game object and sets the titles of the cell buttons to “”.
    func resetGame() {
        let settingToBlank = [Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8]
        
        OXGameController.sharedInstance.getCurrentGame()?.reset()
        
        for button in settingToBlank{
            button.setTitle("" , forState: UIControlState.Normal)
        }
        
        /*
            another way
         
         gameObject.reset()
         
         few view in boardview.subviews(){
         `
         }
        */
            
    }
        
    @IBOutlet weak var newGameButton: UIButton!
    @IBAction func newGame(sender: UIButton) {
        if (!networkGame) {
        resetGame()
        } else {
            //Why does the button automatically show up with the new text? I suspect I need to put it in the viewWillAppear method but I have other shit to do
            newGameButton.setTitle("Good luck!", forState: UIControlState.Normal)
            return
        }
        
    }
}


