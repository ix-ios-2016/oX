//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    // All outlets
    @IBOutlet weak var boardView: UIView!
    
    var gameObject:OXGame = OXGame()
    
    // Outlet for all grid buttons
    @IBAction func gridButtonTapped(sender: AnyObject) {
        //print(String(sender.tag))
        
    }
    
    // Outlet for newGame Button
    @IBAction func newGameButtonTapped(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    

}
