//
//  LandingViewController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = ClosureExperiment()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = (formatter.dateFromString("2016-06-24T04:48:59.158Z"))
        formatter.dateFormat = "MMM d, yyyy; h:mm a"
        formatter.timeZone = NSTimeZone.localTimeZone()
        print(formatter.stringFromDate(date!))
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // navigate to login page
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        let lvc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(lvc, animated: true)
        self.navigationController?.navigationBarHidden = false
        
    }
    
    
    // navigate to register page
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        let rvc = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        self.navigationController?.pushViewController(rvc, animated: true)
        self.navigationController?.navigationBarHidden = false
        
    }

}
