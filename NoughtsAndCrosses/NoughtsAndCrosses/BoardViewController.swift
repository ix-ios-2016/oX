//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet var boardView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var networkGame: Bool = false
    var gameEnded: Bool = false
    
    var currentGame = OXGame()
    
    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    
    @IBOutlet weak var networkPlayButton: UIButton!
    //var gameObject = OXGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playMoveCompletionFunction(game: OXGame?, message: String?) {
        if let gameBack = game {
            self.currentGame = gameBack
            self.updateUI()
        }
        else {
            //failure
        }
        
    }

    @IBAction func boardTapped(sender: AnyObject) {
        
        print("board tapped \(sender.tag)")
        
        //NETWORK GAME
        if networkGame {
                sender.setTitle("\(String (currentGame.playMove(sender.tag)))", forState: UIControlState.Normal)
                OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMoveCompletionFunction(game, message:message)})
        }
            
        //LOCAL GAME
        else {
            
            //determine state
            let status = String (currentGame.state())
            
            if status == "inProgress"{
                //set to X or O
                sender.setTitle("\(String (currentGame.playMove(sender.tag)))", forState: UIControlState.Normal)
                
                //check if finished
                let new_status = String (currentGame.state())
                if new_status == "complete_someone_won" {
                    let xo = String (currentGame.whosTurn())
                    if xo == "X" {
                        print("O wins!")
                    }
                    else {
                        print("X wins!")
                    }
                    
                }
                else if new_status == "complete_no_one_won"{
                    print("tied game")
                }
            }
            
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        print("new game button tapped")
        restartGame()
        currentGame.reset()
    }
    
    func restartGame() {
        button0.setTitle("", forState: UIControlState.Normal)
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        button4.setTitle("", forState: UIControlState.Normal)
        button5.setTitle("", forState: UIControlState.Normal)
        button6.setTitle("", forState: UIControlState.Normal)
        button7.setTitle("", forState: UIControlState.Normal)
        button8.setTitle("", forState: UIControlState.Normal)
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
        //not in network play
        if !networkGame {
            //UserController.sharedInstance.logged_in_user!.email = "";
            //UserController.sharedInstance.logged_in_user!.password = "";
            appDelegate.navigateToLandingViewController()
        }
        //in network play (cancel pressed)
        else {
            OXGameController.sharedInstance.cancelGame(self.currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(bool,message) in self.cancelCurrentGame(bool, message:message)})
            self.navigationController?.popViewControllerAnimated(true)
            //cancel api call goes here
            
        }
        
    }
    
    @IBAction func networkPlayTapped(sender: AnyObject) {
        let nvc = NetworkPlayViewController(nibName:"NetworkPlayViewController",bundle:nil)
        self.navigationController?.pushViewController(nvc, animated: true)
        
    }
    
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        OXGameController.sharedInstance.getGame(self.currentGame.gameId!, viewControllerCompletionFunction: {(game,message) in self.gameUpdateRecieved(game, message:message)})
        
        
    }
    
    
    func updateUI() {
        
        for view in boardView.subviews{
            if let button = view as? UIButton {
                button.setTitle(self.currentGame.board[button.tag].rawValue, forState: UIControlState.Normal)
            }
        }
        
        //if network game
        if networkGame {
            networkPlayButton.hidden = true
            logoutButton.setTitle("Cancel", forState: UIControlState.Normal)
            //someone has joined game
            if currentGame.guestUser?.email != "" {
                if currentGame.localUsersTurn() {
                    self.newGameButton.setTitle("Your turn", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = true
                }
                else {
                    self.newGameButton.setTitle("Their turn", forState: UIControlState.Normal)
                    self.boardView.userInteractionEnabled = false
                }
                
            }
                //open or abandoned
            else {
                self.newGameButton.setTitle("Waiting for opponent to join", forState: UIControlState.Normal)
                self.boardView.userInteractionEnabled = false
            }
        }
        else {
            logoutButton.setTitle("Logout", forState: UIControlState.Normal)
            refresh.hidden = true
        }
        
        
        
    }
    
    func gameUpdateRecieved(game: OXGame?, message: String?) {
        if let gameRecieved = game {
            self.currentGame = gameRecieved
        }
        self.updateUI()
        
        
    }
    
    func cancelCurrentGame(cancel: Bool?, message: String?) {

            print("game canceled")

    }
    
}
