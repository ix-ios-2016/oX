//
//  BoardViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alejandro Castillejo on 5/27/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var boardView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var networkGame: Bool = false
    
    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    
    @IBOutlet weak var networkPlayButton: UIButton!
    var gameObject = OXGame()
    
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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        //if network game
        if networkGame {
            networkPlayButton.hidden = true
            logoutButton.setTitle("Cancel", forState: UIControlState.Normal)
        }
        else {
            logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func newGameTapped(sender: AnyObject) {
        print("new game button tapped")
        restartGame()
        gameObject.reset()
    }
    
    func restartGame() {
        button0.setTitle("", forState: UIControlState.Normal)
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        button4.setTitle("", forState: UIControlState.Normal)
        button5.setTitle("", forState: UIControlState.Normal)
        button6.setTitle("", forState: UIControlState.Normal)
        button7.setTitle("", forState: UIControlState.Normal)
        button8.setTitle("", forState: UIControlState.Normal)
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userIsLoggedIn")
        //not in network play
        if !networkGame {
            //UserController.sharedInstance.logged_in_user!.email = "";
            //UserController.sharedInstance.logged_in_user!.password = "";
            appDelegate.navigateToLandingViewController()
        }
        //in network play (cancel pressed)
        else {
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        
    }
    
    @IBAction func networkPlayTapped(sender: AnyObject) {
        let nvc = NetworkPlayViewController(nibName:"NetworkPlayViewController",bundle:nil)
        self.navigationController?.pushViewController(nvc, animated: true)
        
    }
    
}
