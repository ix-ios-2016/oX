//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var game = OXGame()
    
    var networkMode = false
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
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
    
    var gameObject = OXGame()
    
    @IBOutlet var viewOutlet: UIView!
    
    
    @IBAction func buttonTapped(sender: UIButton)
    {
        //print(gameObject.whoseTurn())
        
        let currentPlayer = gameObject.whoseTurn()
        
        
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
        gameObject.playMove(sender.tag)
        
        //print(gameObject.whoseTurn())
        
        let winner = gameObject.state()
        
        if (winner == OXGameState.complete_someone_won)
        {
            print("Congratulations \(currentPlayer) player, you've won!")
            resetGame()
        }
        else if (winner == OXGameState.complete_no_one_won)
        {
            print("Tie Game")
            resetGame()
        }
        
    }
    
    

    @IBOutlet var buttonArray: [UIButton]!
    
    func resetGame()
    {
        
        gameObject.reset()
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
    
    
    
    
    @IBOutlet weak var networkPlayButton: UIButton!
    
    @IBAction func networkPlayTapped(sender: UIButton)
    {
        
        let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(npc, animated: true)
    }
    
    
    
    
    
}























