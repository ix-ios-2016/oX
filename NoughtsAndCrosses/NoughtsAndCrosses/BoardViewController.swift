//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController , UIGestureRecognizerDelegate {
    
    @IBOutlet weak var boardView: UIView!
    
    var gameObject = OXGame()
    
  
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    
    var lastRotation : Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //allow for user interaction
        view.userInteractionEnabled = true
        
        //create an instance of UIRotationGestureRecognizer
        let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        
        self.boardView.addGestureRecognizer(rotation)
        
        let pinch = UIPinchGestureRecognizer(target: self, action:#selector(BoardViewController.handlePinch(_:)))
        self.view.addGestureRecognizer(pinch)

        
        //Initialize lastRotation
        self.lastRotation = 0.0
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil){
        print("Pinch recognized")
    }
    
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
        
        let tag = sender.tag
        
        print ("Button: \(tag) was tapped")
        let result = String(gameObject.playMove(tag))
        sender.setTitle(result, forState: UIControlState.Normal)
        
        let gameState = gameObject.state()
        
        if (gameState == OXGameState.complete_someone_won){
            
            if (gameObject.whosTurn() == CellType.X){
                
                print("Congrats X, you won")
            } else {
                print("Congrats O, you won")
            }
        }
        
        if (gameState == OXGameState.complete_no_one_won) {
            print ("This game was a tie")
        }
    
    }
//    Create a function called restartGame that calls the reset function on the game object and sets the titles of the cell buttons to “”.
    func resetGame() {
        let settingToBlank = [Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8]
        
        gameObject.reset()
        
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
        
    @IBAction func newGame(sender: UIButton) {
        
        resetGame()
        
    }
}


