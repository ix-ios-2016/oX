//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit


class BoardViewController: UIViewController {

    var networkGame:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!networkGame) {
            refreshButton.hidden = true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var networkGameButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var board: UIView!
    
    
    var currentGame = OXGame()
//    var gameObject = OXGame()
    
    @IBAction func boardTapped(sender: UIButton) {
        
        if (networkGame) {
            if currentGame.guestUser!.email != "" {
                
                currentGame.playMove(sender.tag)
                OXGameController.sharedInstance.playMove(currentGame.serialiseBoard(), gameId: currentGame.gameId!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.playMove(game, message: message)})
                
                let gameState = currentGame.state()
                if (gameState == OXGameState.complete_someone_won) {
                    print("The winner is \(String(currentGame.typeAtIndex(sender.tag)))!")
                    restartGame()
                } else if (gameState == OXGameState.complete_no_one_won) {
                    print("There is a tie!")
                    restartGame()
                } else if (gameState == OXGameState.inProgress) {
                    print("Game in progress")
                }
                
            }
            
        } else {
        
            currentGame.playMove(sender.tag)
            sender.setTitle(String(currentGame.typeAtIndex(sender.tag)), forState: UIControlState.Normal)
            print("boardTapped")
            
            let gameState = currentGame.state()
            if (gameState == OXGameState.complete_someone_won) {
                print("The winner is \(String(currentGame.typeAtIndex(sender.tag)))!")
                restartGame()
            } else if (gameState == OXGameState.complete_no_one_won) {
                print("There is a tie!")
                restartGame()
            } else if (gameState == OXGameState.inProgress) {
                print("Game in progress")
            }
        }
    }
    
    func playMove(game:OXGame?, message:String?) {
        if (message == nil) {
            currentGame = game!
            updateUI()
        } else {
            print("Invalid move")
        }
    }
    
    func restartGame() {
        currentGame.reset()
        for view in board.subviews {
//          print(view.classForCoder)
            if let button = view as? UIButton{
                button.setTitle("", forState: UIControlState.Normal)
            } else {
                print("This is not a UIButton")
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    updateUI()
    }
    
    @IBAction func newGame(sender: AnyObject) {
        restartGame()
    }
    @IBAction func logOut(sender: AnyObject) {
        if !networkGame {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLandingViewConrtoller()
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    @IBAction func networkGame(sender: AnyObject) {
        let networkPlayViewController = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(networkPlayViewController, animated: true)
        print(networkGame)
    }
    
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        OXGameController.sharedInstance.getGame(currentGame.gameId!, viewControllerCompletionFunction: {(game, message) in self.gameUpdateReceived(game, message: message)})
    }

    func gameUpdateReceived(game:OXGame?, message:String?) {
        if let gameReceived = game {
            self.currentGame = gameReceived
        }
        self.updateUI()
    }
    
    func updateUI() {
        
        if  networkGame {
            networkGameButton.hidden = true
            logOutButton.setTitle("Cancel", forState: UIControlState.Normal)
            

            
        } else {
            logOutButton.setTitle("Log Out", forState: UIControlState.Normal)
        }
        for cell in board.subviews  {
            if let button = cell as? UIButton   {
                let tag = button.tag
                
                let cellTypeForButton = currentGame.typeAtIndex(tag)
                
//                var toPrint = cellTypeForButton.rawValue // this is a thing
                
                if (cellTypeForButton == CellType.X)
                {
                    button.setTitle("X", forState: UIControlState.Normal)
                }   else if (cellTypeForButton == CellType.O)   {
                    button.setTitle("O", forState: UIControlState.Normal)
                }
            }
        }
    }
}
