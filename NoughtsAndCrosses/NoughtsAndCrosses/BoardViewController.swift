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
    
    @IBOutlet var buttonArray: [UIButton]!
    
    @IBOutlet var viewOutlet: UIView!
    
    @IBOutlet weak var networkPlayButton: UIButton!



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
        self.boardView.addGestureRecognizer(pinch)
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        self.navigationController?.navigationBarHidden = true
        
        if (networkMode)
        {
            networkPlayButton.hidden = true
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
        
        let currentPlayer = OXGameController.sharedInstance.getCurrentGame()!.whoseTurn()
        
        
        if (sender.currentTitle == nil)
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
        
        print("Button \(sender.tag) tapped")
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
        print("New Game button tapped")
        resetGame()
    }
    
    
    @IBAction func logoutButtonTapped(sender: UIButton)
    {
        
        
        if (self.networkMode)
        {
            self.navigationController?.popViewControllerAnimated(true)
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
    
    
    
    
    
}























