//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    var currentGame = OXGame()
    //OXGameController.sharedInstance.getCurrentGame()
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    
    
    @IBAction func LogoutButtonTapped(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func boardTapped(sender: AnyObject) {
        print("board tapped \(sender.tag)")
        
        //if(string(gameObject.typeAtIndex(sender:tag)) !="EMPTY" }
            //return
   // {
    
    //var lastMove:CellType?
    
    //lastMove = currentGame.playMove(sender.tag)

        //determine state
        
        let status = String (currentGame.state())
        
        
        if status == "inProgress"{
            
            //set to X or O
            
            sender.setTitle("\(String (currentGame.playMove(sender.tag)))", forState: UIControlState.Normal)
            
            
            
            //check if finished
            
            let new_status = String (currentGame.state())
            
            if new_status == "complete_someone_won" {
                
                let xo = String (currentGame.whosTurn())
                
                if xo == "X" {
                    
                    print("O wins!")
                    
                }
                    
                else {
                    
                    print("X wins!")
                    
                }
                
                
                
            }
                
            else if new_status == "complete_no_one_won"{
                
                print("tied game")
                
            }
            
        }
        
    }
    

    @IBAction func newGameTapped(sender: UIButton) {
    }
}
