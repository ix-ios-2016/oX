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
    

    @IBOutlet weak var boardView: UIView!

    @IBAction func buttonPressed(sender: UIButton) {
        
        print("Button \(sender.tag) pressed")
        sender.setTitle("X", forState: UIControlState.Normal)
        
    }
    
    @IBAction func newGame(sender: UIButton) {
    
    }
}
