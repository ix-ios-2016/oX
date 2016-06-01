//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Serene Mirza on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    struct GestureSeries {
        var long: Int
        var right: Int
        var down: Int
        var rotate: Int
    }
    
    var pattern = GestureSeries(long: 0, right: 0, down: 0, rotate: 0)
    
    //MARK: Class Singleton
    class var sharedInstance: EasterEggController {
        struct Static {
            static var instance:EasterEggController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = EasterEggController()
        }
        return Static.instance!
    }
    
    
    
    
    func initiate(view:UIView) {
        
        
        //set up rotation recognizer
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        //self.lastRotation = 0.0
        
        //set up right swipe recognizer
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        //set up two finger down swipe recognizer
        let twoFingerDownSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoFingerDownSwipe(_:)))
        twoFingerDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        twoFingerDownSwipe.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingerDownSwipe)
        
        //set up rotation recognizer
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotation)
        //self.lastRotation = 0.0
        
        //set up rotation recognizer
        let cwRotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(cwRotation)
        //self.lastRotation = 0.0
        
    }
    
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        //print("long press")
        if(sender!.state == UIGestureRecognizerState.Ended) {
            if pattern.long == 0 && pattern.right == 0 && pattern.down == 0 && pattern.rotate == 1 {
                pattern.long = 1;
            }
            else {
                pattern.long = 0
                pattern.right = 0
                pattern.down = 0
                pattern.rotate = 0
            }
        }
        
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        //print("right swipe")
        if pattern.long == 1 && pattern.right == 0 && pattern.down == 0 && pattern.rotate == 1 {
            pattern.right = 1;
        }
        else {
            pattern.long = 0
            pattern.right = 0
            pattern.down = 0
            pattern.rotate = 0
        }
    }
    
    func handleTwoFingerDownSwipe(sender: UILongPressGestureRecognizer? = nil) {
        //print("two finger down swipe")
        pattern.long = 0
        pattern.right = 0
        pattern.down = 0
        pattern.rotate = 0
        
        appDelegate.navigateToEasterEggScreen()
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        //print("rotation")
        if(sender!.state == UIGestureRecognizerState.Ended) {
            if(sender!.rotation > 0) {
            if pattern.long == 0 && pattern.right == 0 && pattern.down == 0 && pattern.rotate == 0 {
                pattern.rotate = 1;
            }
            else {
                pattern.long = 0
                pattern.right = 0
                pattern.down = 0
                pattern.rotate = 0
            }
            }
        }
     }
    
    

    
    
}
