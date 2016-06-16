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
    @IBOutlet weak var newGameButton: UIButton!

    
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
        
        self.updateUI()
    
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
    
    func gameEnded() -> Bool {
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
            logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            networkPlayButton.hidden = true
            
        }
        else    {
            refresh.hidden = true
        }
    }
    
    func gameCancelComplete(success: Bool, message: String?){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func gameUpdateReceived(game: OXGame?, message: String?){
        if let gameReceived = game {
            self.currentGame = gameReceived
            if self.currentGame.backendState == OXGameState.abandoned {
                var opponent: String
                
                if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
                    opponent = self.currentGame.guestUser!.email
                }
                else {
                    opponent = self.currentGame.hostUser!.email
                }
                
                
                let message = "Sorry! \(opponent) cancelled the game."
                let alertController = UIAlertController(title: "Game Cancelled",
                                                        message: message, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "Dismiss", style: .Default) {action in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        else {
            print("There was a problem and the game has ended")
        }
        self.updateUI()

        if self.gameEnded()
        {
            var message: String
            var opponent: String
            
            if UserController.sharedInstance.getLoggedInUser()!.email == self.currentGame.hostUser?.email {
                opponent = self.currentGame.guestUser!.email
            }
            else {
                opponent = self.currentGame.hostUser!.email
            }
            
            
            if self.currentGame.state() == OXGameState.complete_someone_won {
                message = "You were defeated by \(opponent)!"
            }
            else {
                message = "You tied the game with \(opponent)"
            }
            
            let alertController = UIAlertController(title: "Game Over",
                                                    message: message, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Leave Game", style: .Default) {action in
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    func updateUI() {
        if (self.networkMode) {
            self.newGameButton.userInteractionEnabled = true
            if (self.currentGame.guestUser?.email != "") {
                print("\(currentGame.guestUser?.email)")
                print(self.currentGame.hostUser?.email)
                print("\(currentGame.localUsersTurn())")
                print("\(self.gameEnded())")
                print("\(currentGame.whosTurn())")
                if (self.gameEnded()) {
                    self.newGameButton.setTitle("Game over", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = false
                }
                else if (self.currentGame.localUsersTurn()) {
                    self.newGameButton.setTitle("Your turn to play...", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = true
                }
                else {
                    print(self.newGameButton.titleLabel)
                    self.newGameButton.setTitle("Awaiting opponent move...", forState: UIControlState.Normal)
                    print(self.newGameButton.titleLabel)
                    self.boardView.userInteractionEnabled = false
                }
            }
            else {
                self.newGameButton.setTitle("Awaiting opponent to join...", forState: UIControlState.Normal)
                self.boardView.userInteractionEnabled = false
            }
        }
        
        // Update board
        for view in self.boardView.subviews
        {
            if let button = view as? UIButton
            {
                let str = self.currentGame.board[button.tag].rawValue
                button.setTitle(str, forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func buttonPressed(sender: UIButton) {
        
        
        var buttons = [target, target2, target3, target4, target5, target6, target7, target8, target9]
        let tag = sender.tag
        var lastMove : CellType?
        let gameState = self.currentGame.state()
        
        print ("Button \(tag) was tapped")
        print(gameState)
        
        //Ensure players can't change the previously made move
        if (currentGame.typeAtIndex(sender.tag) != CellType.EMPTY) {
            return
        }
        
        if (networkMode) {
            lastMove = currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId! , presentingViewController: self , viewControllerCompletionFunction: {(game , message) in self.playMoveComplete(game , message : message)})
            if (gameEnded()) {
                return
            }
            self.updateUI()
        }
        else {
            lastMove = currentGame.playMove(sender.tag)
            if let moveToPrint = lastMove {
                print("Setting button to: \(moveToPrint)")
                buttons[tag].setTitle(String(lastMove!), forState: UIControlState.Normal)
            }
        }
        
        if self.gameEnded()
        {
            var message: String
            
            if self.currentGame.state() == OXGameState.complete_someone_won {
                message = (String(currentGame.whoJustPlayed()) + " just beat " + String(currentGame.whosTurn()) + "'s!")
            }
            else {
                message = "The game finished in a tie!"
            }
            
            let alertController = UIAlertController(title: "Game Over", message: message, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Leave", style: .Default) {action in
                self.navigationController?.popViewControllerAnimated(true)
                // reset back end and view
                self.restartgame()
                self.currentGame.reset()
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
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
