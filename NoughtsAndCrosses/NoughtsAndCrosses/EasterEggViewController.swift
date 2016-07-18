//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Ryan Davey on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EasterEggViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName1 = "image2.jpg"
        let image1 = UIImage(named: imageName1)
        let imageName2 = "image3.jpeg"
        let image2 = UIImage(named: imageName2)
        let imageName3 = "image1.jpg"
        let image3 = UIImage(named: imageName3)
        
        imageView.animationImages = [image1!, image2!, image3!]
        imageView.animationDuration = 3
        imageView.startAnimating()
        
    }
    @IBAction func oXGameButton(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToLoggedInNavigationController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
