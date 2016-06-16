//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var refresh: UIButton!
    var networkMode : Bool = false
    var lastRotation: Float!
    var places = [UIButton]()
    var currentGame = OXGame()
    
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
        
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playMoveComplete(game: OXGame?, message: String?){
        if let gameBack = game{
            self.currentGame = gameBack
            
             updateUI()
        }
    }
    
    func gameEnded(cell: CellType) -> Bool {
        if currentGame.state() == OXGameState.inProgress{
            return false
        }
        return true
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
            
        }   else    {
            refresh.hidden = true
        }
    }
    
    func gameCancelComplete(success: Bool, message: String?){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func gameUpdateReceived(game: OXGame?, message: String?){
        if let gameReceived = game{
            self.currentGame = gameReceived
        }
        
        self.updateUI()
    }
    
    func updateUI() {
    
        if (networkMode) {
            self.logOutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
            networkPlayButton.hidden = true
        }
        
        if (self.currentGame.guestUser?.email != ""){
            if(self.currentGame.localUsersTurn()) {
                self.networkPlayButton.setTitle("Your turn to play...", forState: UIControlState.Normal)
                self.boardView.userInteractionEnabled = true
            }
            else{
                self.networkPlayButton.setTitle("Awaiting Opponent Move...", forState: UIControlState.Normal)
                self.boardView.userInteractionEnabled = false
            }
        }
        else{
            self.networkPlayButton.setTitle("Awaiting Opponent to Join...", forState: UIControlState.Normal)
            self.boardView.userInteractionEnabled = false
        }
        
        for view in boardView.subviews {
            if let button = view as? UIButton {
                button.setTitle(self.currentGame.board[button.tag].rawValue, forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func buttonPressed(sender: UIButton) {
        
        
        var buttons = [target, target2, target3, target4, target5, target6, target7, target8, target9]
        
        let tag = sender.tag
        
        print ("Button: \(tag) was tapped")
        
        let gameState = self.currentGame
        
        //Ensure players can't change the previously made move
        if (currentGame.typeAtIndex(sender.tag) != CellType.EMPTY) {
            return
        }
        var lastMove : CellType?
        
        if (networkMode) {
            lastMove = currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId! , presentingViewController: self , viewControllerCompletionFunction: {(game , message) in self.playMoveComplete(game , message : message)})
            if (gameEnded(lastMove!)) {
                return
            }
        } else {
            lastMove = currentGame.playMove(sender.tag)
            if let moveToPrint = lastMove {
                print("Setting button to: \(moveToPrint)")
                buttons[tag].setTitle(String(lastMove!), forState: UIControlState.Normal)
            }
        }
        
    }
    
    @IBAction func newGame(sender: UIButton) {
        restartgame()
    }
    
    @IBAction func logOutPressed(sender: UIButton) {
//        OXGameController.sharedInstance.finishCurrentGame()
        if(networkMode){
           self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLandingNavigationController()
            
            UserController.sharedInstance.setLoggedInUser(nil)
        }
    }
    
    @IBAction func networkPlayTapped(sender: AnyObject) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle : nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
    
    @IBAction func refreshButton(sender: UIButton) {
        
        print("Refresh button tapped")
        
        OXGameController.sharedInstance.getGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.gameUpdateReceived(game, message: message)})
        
    }

    func restartgame() {
        currentGame.reset()
        target.setTitle("", forState: UIControlState.Normal)
        target2.setTitle("", forState: UIControlState.Normal)
        target9.setTitle("", forState: UIControlState.Normal)
        target4.setTitle("", forState: UIControlState.Normal)
        target5.setTitle("", forState: UIControlState.Normal)
        target6.setTitle("", forState: UIControlState.Normal)
        target7.setTitle("", forState: UIControlState.Normal)
        target8.setTitle("", forState: UIControlState.Normal)
        target3.setTitle("", forState: UIControlState.Normal)
//        OXGameController.sharedInstance.finishCurrentGame()
        if networkMode{
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
