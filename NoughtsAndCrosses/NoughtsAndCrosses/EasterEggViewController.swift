//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Ingrid Polk on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EasterEggViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Easter Egg!"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func returnButtonTapped(sender: UIButton) {
        appDelegate.navigateToLoggedInNavigationController()
    }
    

}
