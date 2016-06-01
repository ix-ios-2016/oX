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
    var gameObject = OXGame()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(BoardViewController.handleRotation(_:)))
            self.boardView.addGestureRecognizer(rotation)
        
        let pinch: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(BoardViewController.handlePinch(_:)))
        self.boardView.addGestureRecognizer(pinch)
        
    }
    func handlePinch(sender: UIPinchGestureRecognizer? = nil) {
        print("pinch detected")
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        print("Rotation detected")
        
        
        if sender!.state == UIGestureRecognizerState.Ended {
            print("rotation \(sender!.rotation)")
            
            if sender!.rotation < CGFloat(M_PI)/2 {
                UIView.animateWithDuration(NSTimeInterval(3), animations: {self.boardView.transform = CGAffineTransformMakeRotation(0)})
            } else {
                self.boardView.transform = CGAffineTransformMakeRotation(sender!.rotation)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    func restartGame(){
        let restart = String(gameObject.reset())
        for button in boardView.subviews {
            if let vari = button as? UIButton {
                vari.setTitle(restart, forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let tag = sender.tag
        print("Button Pressed \(tag)")
        
        let player = String(gameObject.playMove(tag))
        sender.setTitle(player, forState: UIControlState.Normal)
        gameObject.state()
        gameObject.winDetection()
        
        
    }

    @IBAction func newGame(sender: AnyObject) {
        print("New Game Pressed")
        restartGame()
    }

}
