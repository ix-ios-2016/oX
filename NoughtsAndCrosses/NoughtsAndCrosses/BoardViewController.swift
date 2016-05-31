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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    @IBAction func buttonTapped(sender: UIButton) {
        
        let tag = sender.tag
        
        print ("Button: \(tag) was tapped")
        
        let gameState = gameObject.state()
        
        if (gameState == OXGameState.complete_someone_won){
            
            if (gameObject.whosTurn() == CellType.X){
                
                print("Congrats X, you won")
                
            } else {
                
            print("Congrats O, you won")
        }
            if (gameState == OXGameState.complete_no_one_won) {
               
                print ("This game was a tie")
            }

            
        var something = String (gameObject.playMove(tag))
            
        sender.setTitle( something, forState: UIControlState.Normal)
//            var piece : String = ""
//        
//            if (gameObject.whosTurn() == CellType.X) {
//                piece = "X"
//            } else {
//                piece = "O"
//            }
        
        //sender.setTitle(piece , forState: UIControlState.Normal)
            
        
        
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


