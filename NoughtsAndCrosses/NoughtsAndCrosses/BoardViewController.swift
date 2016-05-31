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
    
    //This should be a UI Button --> 
    @IBAction func BoardTapped(sender: AnyObject) {
    
    let tag = sender.tag
    
    //set cell value
    let cellValue = String(gameObject.playMove(tag))
    sender.setTitle(cellValue, forState: UIControlState.Normal)

    
    let gameState = gameObject.state()
    let player = gameObject.whosTurn()
    
    if (gameState == OXGameState.complete_someone_won){
    print("\(String(player)) wins!")
    restartGame()
    }
    else if (gameState == OXGameState.complete_no_one_won){
    print("Tie game!")
    restartGame()
    }
   
}


    @IBOutlet var buttons: [UIButton]!


func restartGame() {
    gameObject.reset()
    for button in buttons {
        button.setTitle("", forState: UIControlState.Normal)
    }
}


    @IBAction func newgame(sender: UIButton) {
        restartGame()
}
    
    @IBAction func logOutButton(sender: UIButton) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.navigateToLandingViewNavigationController()
    }


}