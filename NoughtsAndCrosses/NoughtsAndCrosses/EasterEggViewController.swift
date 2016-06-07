//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit


class EasterEggViewController: UIViewController, YTPlayerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        youtubePlayer.loadWithVideoId("RqY27aqUJ2s")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // return to game when button is tapped
    @IBAction func returnToGameButtonTapped(sender: UIButton) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if UserController.sharedInstance.logged_in_user != nil {
            appDelegate.navigateToGame()
        }
        else {
            appDelegate.navigateToLandingView()
        }
        
    }

    @IBOutlet weak var youtubePlayer: YTPlayerView!
}
