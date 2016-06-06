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
       
        /*
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(BoardViewController.handleRotation(_:)))
        self.board.addGestureRecognizer(rotation)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(BoardViewController.handlePinch(_:)))
        self.view.addGestureRecognizer(pinch)
        
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:
            #selector(BoardViewController.handleLongPress(_:)))
        self.view.addGestureRecognizer(longPress)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:
            #selector(BoardViewController.handleRightSwipe(_:)))
        self.view.addGestureRecognizer(swipeRight)
        
        let twoFingerSwipeDown = UISwipeGestureRecognizer(target: self, action:
            #selector(BoardViewController.twoFingerDownSwipe(_:)))
        twoFingerSwipeDown.numberOfTouchesRequired = 2
        twoFingerSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(twoFingerSwipeDown)
        */
        
        if (networkGame == false) {
            print("hi")
        }
    }
    /*
    func twoFingerDownSwipe(sender: UISwipeGestureRecognizer? = nil) {
            print("Two finger down swipe")
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        print("Long press")
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
            print("Right swipe")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        self.board.transform = CGAffineTransformMakeRotation(sender!.rotation)
        
        print("hi")
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("rotation \(sender!.rotation)")
            
            if (sender!.rotation < CGFloat(M_PI)/4) {
                
                UIView.animateWithDuration(NSTimeInterval(3), animations: {
                    self.board.transform = CGAffineTransformMakeRotation(0)

                })
            }
            
        }
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        print("pinch")
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToEasterEggController()
    }
    
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var networkGameButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var board: UIView!
    
    var gameObject = OXGame()
    
    @IBAction func boardTapped(sender: UIButton) {
        
        gameObject.playMove(sender.tag)
        sender.setTitle(String(gameObject.typeAtIndex(sender.tag)), forState: UIControlState.Normal)
        print("boardTapped")
        
        let gameState = gameObject.state()
        if (gameState == OXGameState.complete_someone_won) {
            print("The winner is \(String(gameObject.typeAtIndex(sender.tag)))!")
            restartGame()
        } else if (gameState == OXGameState.complete_no_one_won) {
            print("There is a tie!")
            restartGame()
        } else if (gameState == OXGameState.inProgress) {
            print("Game in progress")
        }
    }
    
    func restartGame() {
        gameObject.reset()
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
        print(networkGame)

    }
    
    @IBAction func newGame(sender: AnyObject) {
        restartGame()
    }
    @IBAction func logOut(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToLandingViewConrtoller()
    }
    @IBAction func networkGame(sender: AnyObject) {
        let networkPlayViewController = NetworkPlayViewController(nibName: "NetworkPlayViewController", bundle: nil)
        self.navigationController?.pushViewController(networkPlayViewController, animated: true)
        networkGame = true
        print(networkGame)
    }
}
