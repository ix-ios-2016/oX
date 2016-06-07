//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var networkPlay: UIButton!
    @IBOutlet weak var BoardView: UIView!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var refreshButton: UIButton!
    //var game = OXGameController.sharedInstance.getCurrentGame()!
    var networkMode = false
    
    var currentGame = OXGame()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        view.userInteractionEnabled = true
        
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        
        self.BoardView.addGestureRecognizer(rotation)
        
        let pinch = UIPinchGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        
       updateUI()
    }
    
    func gameUpdateReceived(game:OXGame?, message: String?){
        if let gameReceived = game {
            self.currentGame = gameReceived
        }
        self.updateUI()
        
        OXGameController.sharedInstance.getGame(self.currentGame.gameID!, presentingViewController: nil, viewControllerCompletionFunction: {(game, message) in self.gameUpdateReceived(game,message:message)})
    }
    
    func updateUI(){
        
        
        if ( networkMode ) {
            networkPlay.hidden = true
            refreshButton.hidden = false
            logoutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
            
            if ( !currentGame.localUsersTurn() || (currentGame.guestUser!.email == "")){
                
                for view in BoardView.subviews   {
                    if let button = view as? UIButton   {
                        
                        button.enabled = false
                        
                        
                    }
                }
                
            }
            
            
            if currentGame.guestUser!.email != "" {
                
                for view in BoardView.subviews   {
                    if let button = view as? UIButton   {
                        
                        button.enabled = true
                        
                        
                    }
                }
                
                
                newGameButton.setTitle("It's \(currentGame.whosTurn().rawValue)'s turn", forState: UIControlState.Normal)
            
                
                
                if ( currentGame.winDetection() ) {
                    if (  currentGame.state() == OXGameState.complete_someone_won ){
                        newGameButton.setTitle(" \(currentGame.whoJustPlayed()) Won the Game!", forState: UIControlState.Normal)
                        
                        let alert = UIAlertController(title: "\(currentGame.whoJustPlayed()) Won the Game!", message: "Click OK to return to the list of Network Games", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                            self.navigationController?.popViewControllerAnimated(true)
                            
                        })
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    else if (currentGame.state() == OXGameState.complete_no_one_won) {
                        newGameButton.setTitle("There was a Tie!", forState: UIControlState.Normal)
                        let alert = UIAlertController(title: "There was a Tie!", message: "Click OK to return to the list of Network Games", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                            self.navigationController?.popViewControllerAnimated(true)
                            
                        })
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                }
                
                
            }
            else {
                newGameButton.setTitle("Awaiting Opponent To Join...", forState: UIControlState.Normal)
            }
            
        }
        else {
            refreshButton.hidden = true
        }
        
        for view in BoardView.subviews   {
            if let button = view as? UIButton   {
                
                let toPrint = self.currentGame.typeAtIndex(button.tag).rawValue
                button.setTitle(toPrint, forState: UIControlState.Normal)
                
                
            }
        }
        
        
    }
    
    @IBAction func refreshButtonTapped(sender: UIButton) {
      OXGameController.sharedInstance.getGame(self.currentGame.gameID!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.gameUpdateReceived(game,message:message)})
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
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func boardTapped(sender: UIButton) {
     
        
        //if i'm in network mode:
        if ( networkMode ) {
            
            currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove( self.currentGame.serialiseBoard() , gameId: self.currentGame.gameID!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playGameReceived(game,message:message)})
            
//            else if ( currentGame.backendState == OXGameState.inProgress ) {
//                
//                //OXGameController.sharedInstance.playMove( self.currentGame.serialiseBoard() , gameId: self.currentGame.gameID!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playGameReceived(game,message:message)})
//                
//                
//                let celltype = currentGame.whoJustPlayed()
//                let delay =  Double(NSEC_PER_SEC)/2
//                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//                dispatch_after(time, dispatch_get_main_queue()) {
//                }
//                
//            }
            
        }
        else {
            
            let tag = sender.tag
            
            let cell = String(currentGame.playMove(tag))
            
            print(String(cell))
            sender.setTitle( String(cell), forState: UIControlState.Normal)
            
            let gameState = currentGame.state()

            if ( gameState == OXGameState.complete_someone_won){
                
                print("\(String(currentGame.whoJustPlayed())) is the Winner!")
                restartGame()
                
            }
            else if ( gameState == OXGameState.complete_no_one_won ) {
                print("There is a Tie!")
                restartGame()
                
            }
            
        }
    }
    
    
    func playGameReceived(game: OXGame!, message: String!){
        if ( message == nil ) {
            currentGame = game
            updateUI()
        } else {
         print("invalid move")
        }
        
        
    }
    
    func restartGame() {
        //OXGameController.sharedInstance.getCurrentGame()!.reset()
        //OXGameController.sharedInstance.getCurrentGame()!.currTurn = CellType.X
        currentGame = OXGame()
        for cell in allButtons {
            cell.setTitle("", forState: UIControlState.Normal)
            
        }
    }
    
    @IBAction func resetGame(sender: UIButton) {
        restartGame()
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        
        if ( networkMode ){
            //OXGameController.sharedInstance.finishCurrentGame()
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
