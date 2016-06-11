//
//  EasterEggViewController.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit
import AVFoundation

class EasterEggViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myGif = UIImage.gifWithName("beautifulFlower")
        let imageView = UIImageView(image: myGif)
        
        print( UIScreen.mainScreen().bounds.width)
        print(UIScreen.mainScreen().bounds.height)

        // make imageView the size of the whole screen
        imageView.frame = CGRect(x: 0, y: 0, width: (Int)(UIScreen.mainScreen().bounds.width), height: (Int)(UIScreen.mainScreen().bounds.height))
        
        // make a music player
        let drakeSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("oneDance", ofType: "mp3")!)
        print(drakeSound)
        
        // play the sound
        do {
            let player = try AVAudioPlayer(contentsOfURL: drakeSound)
           // guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
        
        
        
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
