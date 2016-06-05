//
//  LandingViewController.swift
//  OnboardingDemo
//
//  Created by Luke Petruzzi on 5/31/16.
//  Copyright © 2016 Luke Petruzzi. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Auth Menu"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTouched(sender: UIButton) {
        let lvc = LoginViewController()
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
    
    @IBAction func registerButtonTouched(sender: UIButton) {
        let rvc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
}
