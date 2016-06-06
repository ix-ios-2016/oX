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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func boardTapped(sender: AnyObject) {
        print("board tapped \(sender.tag)")
        
        
        
        
        
        
        
        //determine state
        
        let status = String (gameObject.state())
        
        
        
        if status == "inProgress"{
            
            //set to X or O
            
            sender.setTitle("\(String (gameObject.playMove(sender.tag)))", forState: UIControlState.Normal)
            
            
            
            //check if finished
            
            let new_status = String (gameObject.state())
            
            if new_status == "complete_someone_won" {
                
                let xo = String (gameObject.whosTurn())
                
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
