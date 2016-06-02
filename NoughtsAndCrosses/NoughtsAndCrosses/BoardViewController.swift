//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var BoardView: UIView!
    var game = OXGame()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.userInteractionEnabled = true
        
//        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
//        
//        self.BoardView.addGestureRecognizer(rotation)
        
        //let pinch = UIPinchGestureRecognizer(target: self, action: #selector(Board) )
    }
    
    func handlePinch( sender: UIPinchGestureRecognizer? = nil  ){
        print("pinch detected")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil ){
        self.BoardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        print("rotation detected")
        
        
        if (sender!.state == UIGestureRecognizerState.Ended){
            print("rotation \(sender!.rotation)")
            //self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(0))
            
            
            if( sender!.rotation < CGFloat(M_1_PI)/4) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {} )
                self.BoardView.transform = CGAffineTransformMakeRotation(0)
            }
            else if (sender!.rotation < CGFloat(M_1_PI)/2){
                UIView.animateWithDuration(NSTimeInterval(3), animations: {} )
                self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_1_PI)/4)
                
            }
            else if (sender!.rotation < CGFloat(M_1_PI)){
                UIView.animateWithDuration(NSTimeInterval(3), animations: {} )
                self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_1_PI)/2)
            }
            else if (true){
                
            }
            
            self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_2_PI))
            self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_1_PI))
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func boardTapped(sender: UIButton) {
     let tag = sender.tag
        
        
        //Set the title of the button to the player’s CellType.
        let cell = String(game.playMove(tag))
        sender.setTitle(cell, forState: UIControlState.Normal)
        
     let gameState = game.state()
        
    
        let plyer = game.whosTurn()
    
        if ( gameState == OXGameState.complete_someone_won){
            
            print("\(String(plyer)) is the Winner!")
            restartGame()
        }
        else if ( gameState == OXGameState.complete_no_one_won ) {
            print("There is a Tie!")
            restartGame()
        }
        

        
    }
    func restartGame() {
        game.reset()
        game.currTurn = CellType.X
        
        for cell in allButtons {
            cell.setTitle("", forState: UIControlState.Normal)
            
        }
    }
    @IBOutlet var allButtons: [UIButton]!
    
    @IBAction func resetGame(sender: UIButton) {
        restartGame()
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.navigateBackToLandingNavigationController()
    }
    
    

   
}
