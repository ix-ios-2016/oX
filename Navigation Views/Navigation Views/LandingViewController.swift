//
//  LandingViewController.swift
//  Navigation Views
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        print("let's go to login screen")
        let lvc = LoginViewController(nibName:"LoginViewController",bundle:nil)
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
   
    @IBAction func registerButtonTapped(sender: UIButton) {
        print("let's register!")
        let lvc = RegistrationViewController(nibName:"RegistrationViewController",bundle:nil)
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }

   
}
