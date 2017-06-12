//
//  TypeOfGameViewController.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 6/7/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class TypeOfGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userLoggedIn")
        appDelegate.navigateToLandingNavigationController()
    }
    
    
    @IBAction func soloPlay(sender: UIButton) {
        let bvc = BoardViewController(nibName: "BoardViewController", bundle: nil)
        navigationController?.pushViewController(bvc, animated: true)
    }

    @IBAction func computerPlay(sender: UIButton) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
