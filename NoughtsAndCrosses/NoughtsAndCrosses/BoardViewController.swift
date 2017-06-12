//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    var networkMode = false
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet var buttonArray: [UIButton]!
    
    @IBOutlet var viewOutlet: UIView!
    
    @IBOutlet weak var networkPlayButton: UIButton!

    @IBOutlet weak var refreshButton: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
        self.boardView.addGestureRecognizer(pinch)
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
    
        refreshButton.hidden = true
        
        self.navigationController?.navigationBarHidden = true
        
        if (networkMode)
        {
            networkPlayButton.hidden = true
            refreshButton.hidden = false
            newGameButton.setTitle("Network Game in Progress", forState: UIControlState.Normal)
            logoutButton.setTitle("Cancel", forState: UIControlState.Normal)
            
        }
    }
    
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil)
    {
        print("pinch detector")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil)
    {
        print("detected")
        
        
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        if sender!.state == UIGestureRecognizerState.Ended
        {
            
            // snap action
            /*
            // previous quarter
            let quad = (Double(Int((Double(sender!.rotation) * 57.2985)/90.0))) * ((M_PI)/2)
            */
            
            // nearest quarter
            let quad = (Double(round(((sender!.rotation) * 57.2985)/90))) * ((M_PI)/2)
            
            UIView.animateWithDuration(NSTimeInterval(3), animations: {self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(quad))})
        }
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func buttonTapped(sender: UIButton)
    {
        //print(OXGameController.sharedInstance.getCurrentGame()!.whoseTurn())

        print("Button \(sender.tag) tapped")
        
        if (networkMode)
        {
            
            if OXGameController.sharedInstance.getCurrentGame()?.guestUser!.email == ""
            {
                print("No User Accepted")
            }
            else if (OXGameController.sharedInstance.getCurrentGame()?.whosTurn() == CellType.X && UserController.sharedInstance.logged_in_user?.email == OXGameController.sharedInstance.getCurrentGame()?.hostUser?.email) || (OXGameController.sharedInstance.getCurrentGame()?.whosTurn() == CellType.O && UserController.sharedInstance.logged_in_user?.email == OXGameController.sharedInstance.getCurrentGame()?.guestUser?.email)
            {
                OXGameController.sharedInstance.getCurrentGame()?.playMove(sender.tag)
            
            OXGameController.sharedInstance.playNetworkMove((OXGameController.sharedInstance.getCurrentGame()?.serialiseBoard())!, gameId:
                OXGameController.sharedInstance.getCurrentGame()!.gameId!, viewControllerCompletionFunction: {(game, message) in self.playNetworkMoveComplete(game, message: message)})
            }
        }
        else
        {
            
            let currentPlayer = OXGameController.sharedInstance.getCurrentGame()!.whosTurn()
            
            
            if (sender.currentTitle == "" || sender.currentTitle == nil)
            {
                if (currentPlayer == CellType.X)
                {
                    sender.setTitle("X", forState: UIControlState.Normal)
                }
                else
                {
                    sender.setTitle("O", forState: UIControlState.Normal)
                }
            }
            else
            {
                return
            }
            
            OXGameController.sharedInstance.playMove(sender.tag)
            
            
            //print(OXGameController.sharedInstance.getCurrentGame()!.whoseTurn())
            
            let winner = OXGameController.sharedInstance.getCurrentGame()!.state()
            
            if (winner == OXGameState.complete_someone_won)
            {
                print("Congratulations \(currentPlayer) player, you've won!")
                OXGameController.sharedInstance.finishCurrentGame()
                resetBoard()
                if (networkMode == true)
                {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            else if (winner == OXGameState.complete_no_one_won)
            {
                print("Tie Game")
                OXGameController.sharedInstance.finishCurrentGame()
                resetBoard()
                if (networkMode == true)
                {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
        
        /*
        else if (winner == OXGameState.inProgress && networkMode == true)
        {
            let (moveCellType, moveIndex) = OXGameController.sharedInstance.playRandomMove()!
            buttonArray[moveIndex].setTitle("\(moveCellType)", forState: UIControlState.Normal)
            
            let compWinCheck = OXGameController.sharedInstance.getCurrentGame()!.state()
            
            if (compWinCheck == OXGameState.complete_someone_won)
            {
                print("THE COMPUTER WON. THEY ARE TAKING OVER")
                OXGameController.sharedInstance.finishCurrentGame()
                resetBoard()
                self.navigationController?.popViewControllerAnimated(true)
            }
            else if (winner == OXGameState.complete_no_one_won)
            {
                print("Tie Game. THE MACHINES ARE LEARNING")
                OXGameController.sharedInstance.finishCurrentGame()
                resetBoard()
                self.navigationController?.popViewControllerAnimated(true)
            }

        }
        */
        
    }
    
    
    func playNetworkMoveComplete(game: OXGame?, message: String?) {
        
        if let _ = game {
            print("hey")
        }
        else {
            print("Invalid Move")
        }
        updateUI()
        
    }
    

    func resetBoard()
    {
        
        for button in buttonArray
        {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    
    
    func resetGame()
    {
        
        OXGameController.sharedInstance.getCurrentGame()!.reset()
        for button in buttonArray
        {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    
    
    @IBAction func newGameTapped(sender: UIButton)
    {
        if (!networkMode)
        {
            print("New Game button tapped")
            resetGame()
        }
    }
    
    
    @IBAction func logoutButtonTapped(sender: UIButton)
    {
        
        
        if (self.networkMode)
        {
            self.navigationController?.popViewControllerAnimated(true)
            OXGameController.sharedInstance.finishCurrentGame()
            networkMode = false
        }
        else
        {
            UserController.sharedInstance.logoutUser()

            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedOutNavigationController()
            
        }
       
        
    }
    
    
    
    @IBAction func networkPlayTapped(sender: UIButton)
    {
        
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
    
    
    func updateUI()
    {
        let game = OXGameController.sharedInstance.getCurrentGame()
        for button in buttonArray
        {
            let title = game?.board[button.tag]
            if (title == CellType.X)
            {
                button.setTitle("X", forState: UIControlState.Normal)
            }
            else if (title == CellType.O)
            {
                button.setTitle("O", forState: UIControlState.Normal)
            }
            else
            {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    
    @IBAction func refreshButtonTapped(sender: UIButton)
    {
        
        let game = OXGameController.sharedInstance.getCurrentGame()
        
        OXGameController.sharedInstance.getGame((game?.gameId)!, presentingViewController: self, viewControllerCompletionFunction: {(game, message) in self.getGameComplete(game, message: message)})
        
    }
    
    func getGameComplete(game: OXGame?, message: String?) {
        
        if let _ = game {
            updateUI()
        }
        else {
            print("Did not get game")
        }
        
    }
    
    
    
    
    
}














