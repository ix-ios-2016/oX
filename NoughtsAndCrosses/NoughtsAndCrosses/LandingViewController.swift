//
//  LandingViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Noughts and Crosses"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    @IBAction func loginButtonTapped(sender: UIButton)
    {
        
        let lvc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        self.navigationController?.pushViewController(lvc, animated: true)
    }
    
    
    @IBAction func registerButtonTapped(sender: UIButton)
    {
        
        let rvc = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}















