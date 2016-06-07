//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var networkPlay: UIButton!
    @IBOutlet weak var BoardView: UIView!
    @IBOutlet var allButtons: [UIButton]!
    //var game = OXGameController.sharedInstance.getCurrentGame()!
    var networkMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.userInteractionEnabled = true
        
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        
        self.BoardView.addGestureRecognizer(rotation)
        
        let pinch = UIPinchGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        
        if ( networkMode ) {
            networkPlay.hidden = true
            logoutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
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
            
            
            if( sender!.rotation < CGFloat(M_1_PI)/2) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {} )
                self.BoardView.transform = CGAffineTransformMakeRotation(0)
            }
            else if ( sender!.rotation < CGFloat(M_1_PI)) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {} )
                self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_1_PI)/2)
            }

            
            //self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_2_PI))
            //self.BoardView.transform = CGAffineTransformMakeRotation(CGFloat(M_1_PI))
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func boardTapped(sender: UIButton) {
     
        let tag = sender.tag
        
        //Set the title of the button to the player’s CellType.
        
        //let cell = String(game.playMove(tag))
        let cell = OXGameController.sharedInstance.playMove(tag)
        sender.setTitle( String(cell), forState: UIControlState.Normal)
        
        
        
        //how do you remove ALL the game references?
        let gameState = OXGameController.sharedInstance.getCurrentGame()!.state()
        
        let player = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
    
        if ( gameState == OXGameState.complete_someone_won){
            
            print("\(String(player)) is the Winner!")
            OXGameController.sharedInstance.finishCurrentGame()
                        if ( networkMode ){
                            self.navigationController?.popViewControllerAnimated( true)
                        }
            restartGame()

        }
        else if ( gameState == OXGameState.complete_no_one_won ) {
            print("There is a Tie!")
            OXGameController.sharedInstance.finishCurrentGame()
            if ( networkMode ){
                self.navigationController?.popViewControllerAnimated( true)
            }
                        restartGame()

        }

        else if ( gameState == OXGameState.inProgress ) {
            if ( networkMode ){
                let ( celltype, index ) = OXGameController.sharedInstance.playRandomMove()!
                print(OXGameController.sharedInstance.getCurrentGame()?.whosTurn())
                
                
                
                let delay =  Double(NSEC_PER_SEC)/2
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    // After 2 seconds this line will be executed
                    self.allButtons[index].setTitle( String(celltype), forState: UIControlState.Normal)
                }
                
                
                
                //allButtons[index].setTitle( String(celltype), forState: UIControlState.Normal)
                //OXGameController.sharedInstance.finishCurrentGame()
                

                
            }

        }
 
        

        
    }
    func restartGame() {
        OXGameController.sharedInstance.getCurrentGame()!.reset()
        //OXGameController.sharedInstance.getCurrentGame()!.currTurn = CellType.X
        
        for cell in allButtons {
            cell.setTitle("", forState: UIControlState.Normal)
            
        }
    }
    
    @IBAction func resetGame(sender: UIButton) {
        restartGame()
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        
        if ( networkMode ){
            OXGameController.sharedInstance.finishCurrentGame()
            self.navigationController?.popViewControllerAnimated( true)
        }
        else {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.navigateBackToLandingNavigationController()
            NSUserDefaults.standardUserDefaults().setValue( nil , forKey: "userIdLoggedIn")
        }

    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func networkPlayTapped(sender: UIButton) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }

   
}
