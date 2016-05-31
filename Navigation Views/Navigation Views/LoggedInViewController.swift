//
//  LoggedInViewController.swift
//  Navigation Views
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBAction func logOutButtonTapped(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateBackToauthorisationNavigationController()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = UserController.sharedInstance.logged_in_user
        greetingLabel.text = "Welcome \(user!.email)!"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
