//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
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
    
    var lastGesture: Int = 0
    
    func initiate(view:UIView) {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleLeftSwipe(_:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwipe)
        
        let twoDownSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoDownSwipe(_:)))
        twoDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        twoDownSwipe.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoDownSwipe)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotation)
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        print("LongPress")
        
        lastGesture = 1
    }
    
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("RightSwipe")
        
        if lastGesture == 1 {
            lastGesture = 2
        }
        else {
            lastGesture = 0
        }
    }
    
    func handleLeftSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("LeftSwipe")
        
        if lastGesture == 2 {
            lastGesture = 3
        }
        else {
            lastGesture = 0
        }
    }
    
    func handleTwoDownSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("TwoDownSwipe")
        
        if lastGesture == 3 {
            lastGesture = 4
        }
        else {
            lastGesture = 0
        }
    }

    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        if sender!.state == UIGestureRecognizerState.Ended && sender?.rotation < 0 {
            print("CounterRotation")
            
            if lastGesture == 5 {
                
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToEasterEgg()
                
            }
            else {
                lastGesture = 0
            }

        }
        else if sender!.state == UIGestureRecognizerState.Ended && sender?.rotation > 0 {
   
            print("ClockwiseRotation")
            if lastGesture == 4 {
                lastGesture = 5
            }
            else {
                lastGesture = 0
            }
        }
    }

    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
