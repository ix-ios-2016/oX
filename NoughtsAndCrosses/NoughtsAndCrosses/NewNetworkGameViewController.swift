//
//  NewNetworkGameViewController.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/5/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class NewNetworkGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create New Game"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createNewGameButtonTapped(sender: AnyObject)
    {
        // Create a new game with the current logged in user as the captain now
        if let decodedUser = UserController.sharedInstance.getLoggedInUser() {
            OXGameController.sharedInstance.createNewGame(decodedUser)
        }
    
        self.navigationController?.popViewControllerAnimated(true)
    }
}
