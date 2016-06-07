//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var networkPlay: UIButton!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var winningMessage: UILabel!
    var networkMode = false
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = ClosureExperiment()
        view.userInteractionEnabled = true
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
        self.boardView.addGestureRecognizer(rotation)
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
        self.view.addGestureRecognizer(pinch)
        if (networkMode == true) {
            logOutButton.setTitle("Cancel Game", forState: UIControlState.Normal)
        }
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            
            if (sender!.rotation < CGFloat(M_PI/4)) {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                    self.boardView.transform = CGAffineTransformMakeRotation(0)
                })
            }
            print("rotation detected at \(sender!.rotation)")
            self.boardView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func boardTapped(sender: AnyObject) {
        let gameController = OXGameController()
        let game = gameController.getCurrentGame()
        gameController.playMove(sender.tag)
        var cellType = ""
        if (game!.whosTurn() == CellType.X) {
            cellType = "X"
        } else if (game!.whosTurn() == CellType.O) {
            cellType = "O"
        }
        let gameState = game!.state()
        if (gameState == OXGameState.complete_no_one_won) {
            winningMessage.text = "Tie! No player wins."
        } else if (gameState == OXGameState.complete_someone_won) {
            if (game!.whosTurn() == CellType.X) {
                winningMessage.text = "Player X wins"
            } else if (game!.whosTurn() == CellType.O){
                winningMessage.text = "Player O wins"
            }
        } else if (gameState == OXGameState.inProgress) {
            let (cellType, int) = gameController.playRandomMove()!
            game!.board[int] = cellType
        }
        sender.setTitle(cellType, forState: UIControlState.Normal)
    }
    
    func restartGame() {
        OXGameController.sharedInstance.getCurrentGame()!.reset()
        winningMessage.text = ""
        let buttons = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        for button in buttons {
            button.setTitle("", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        if (networkMode == false) {
            restartGame()
        }
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        if (networkMode == true) {
            self.navigationController?.popViewControllerAnimated(true)
            self.navigationController?.navigationBarHidden = true
        } else {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLogOutNavigationController()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true

    }

    @IBAction func networkPlayTapped(sender: AnyObject) {
        if (networkMode == false) {
            let npc = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
            self.navigationController?.pushViewController(npc, animated: true)
        }
    }
    
}
