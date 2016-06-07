//
//  LandingViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Landing View"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let LandingViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(LandingViewController, animated: true)
    }

    @IBAction func registerButtonTapped(sender: AnyObject) {
        let LandingViewController = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        self.navigationController?.pushViewController(LandingViewController, animated: true)
    }
    
}
