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
    
    var currentGame = OXGame()
    
    @IBOutlet weak var logoutButton: UIButton!
    
    //We want access to this button to be able to set it to hidden once a game starts
    @IBOutlet weak var networkPlayButton: UIButton!
    
    @IBOutlet weak var refreshButton: UIButton!
    
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
    
        updateUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.gameNavigationController.navigationBarHidden = true
        updateUI()
    }
    
    @IBAction func refreshButtonTapped(sender: UIButton) {
        OXGameController.sharedInstance.getGame(self.currentGame.gameId!, viewControllerCompletionFunction: {(user,message) in self.refreshCompleted(user, message: message)})
        
        //updateUI()
    }
    
    func refreshCompleted(game : OXGame?, message : String?){
        self.currentGame = game!
        self.updateUI()
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        
        if (!networkGame) {
            let lvc = LandingViewController(nibName: "LandingViewController", bundle: nil)
            self.navigationController?.pushViewController(lvc, animated: true)
            let userIsLoggedIn = UserController.sharedInstance.setLoggedInUser(nil)
            
        } else {
            //let nvc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        //I think this should happen if you click reset OR cancel
        //OXGameController.sharedInstance.finishCurrentGame()
    }
    
    func updateUI() {
        //constantly checking the state which we have currentGame.state() to work with
        
        for view in boardView.subviews {
            if let button = view as? UIButton {
                button.setTitle(self.currentGame.board[button.tag].rawValue, forState: UIControlState.Normal)
            }
        }
        
        if(networkGame) {
            
            logoutButton.setTitle("Cancel", forState: UIControlState.Normal)
            networkPlayButton.hidden = true
            refreshButton.hidden = false
            
            if (self.currentGame.guestUser?.email != "") {
                //there is 2 players so we can start playing
                if (self.currentGame.localUsersTurn()) {
                    self.newGameButton.setTitle("Your turn to play" , forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = true
                } else {
                    self.newGameButton.setTitle("Awaiting opponents move", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = false
                }
            } else {
                self.newGameButton.setTitle("Awaiting opponent to join", forState: UIControlState.Normal)
            }

            
        }
        if (!networkGame) {
            refreshButton.hidden = true
        }
        self.navigationController?.navigationBarHidden = true

    }
    
    @IBAction func networkPlayButtonTapped(sender: UIButton) {
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
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
        
        var buttons = [Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8]
        
        let tag = sender.tag
        
        print ("Button: \(tag) was tapped")
        //let result = String(OXGameController.sharedInstance.playMove(tag))
        //sender.setTitle(result, forState: UIControlState.Normal)
        
        let gameState = self.currentGame//OXGameController.sharedInstance.getCurrentGame()?.state()
        
        /*if (gameState == OXGameState.complete_someone_won){
            
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
     */
        
        if (currentGame.typeAtIndex(sender.tag) != CellType.EMPTY) {
            return
        }
        var lastMove : CellType?
        
        if (networkGame) {
            lastMove = currentGame.playMove(sender.tag)
            OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId! , presentingViewController: self , viewControllerCompletionFunction: {(game , message) in self.playMoveComplete(game , message : message)})
            
            if (!gameEnded(lastMove!)) {
                
            } else {
                //Game ended
                return
            }
        } else {
            lastMove = currentGame.playMove(sender.tag)
            if let moveToPrint = lastMove {
                print("Setting button to: \(moveToPrint)")
            }
        }
        
        
    }
    
    func gameEnded(cell : CellType) -> Bool {
        if (currentGame.state() == OXGameState.inProgress) {
            return false
        }
        return true
    }
    
    func playMoveComplete(game : OXGame? , message : String?) {
        if let gameBack = game {
            //success
            self.currentGame = gameBack
            
            //update the board
            updateUI()
        }
    }
//    Create a function called restartGame that calls the reset function on the game object and sets the titles of the cell buttons to “”.
    func resetGame() {
        let settingToBlank = [Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8]
        
        //OXGameController.sharedInstance.getCurrentGame()?.reset()
        
        for button in settingToBlank{
            button.setTitle("" , forState: UIControlState.Normal)
        }
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


