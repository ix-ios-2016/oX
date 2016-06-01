//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EasterEggViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myGif = UIImage.gifWithName("beautifulFlower")
        let imageView = UIImageView(image: myGif)
        
        print(self.view.frame.size.width)
        print(self.view.frame.size.height)

        imageView.frame = CGRect(x: 0, y: 0, width: (Int)(self.view.frame.size.width), height: (Int)(self.view.frame.size.height))
        
        self.view.addSubview(imageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToGameButtonPressed(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToLoggedInViewController()
    }
}
