//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit
import MediaPlayer

class EasterEggViewController: UIViewController {
    
    var musicPlayer: MPMusicPlayerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myGif = UIImage.gifWithName("beautifulFlower")
        let imageView = UIImageView(image: myGif)
        
        print( UIScreen.mainScreen().bounds.width)
        print(UIScreen.mainScreen().bounds.height)

        // make imageView the size of the whole screen
        imageView.frame = CGRect(x: 0, y: 0, width: (Int)(UIScreen.mainScreen().bounds.width), height: (Int)(UIScreen.mainScreen().bounds.height))
        
        // make a music player
        musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
        // need to make a queue for the music player
        
        
        
        
        
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
