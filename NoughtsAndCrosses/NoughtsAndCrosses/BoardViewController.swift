//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    var gameObject = OXGame()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    @IBOutlet var boardView: UIView!
    
    
    @IBOutlet weak var boardView: UIView!
    
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
