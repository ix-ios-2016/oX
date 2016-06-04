//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {

    enum Gestures {
        case longPress
        case rightSwipe
        case twoFingerSwipeDown
        case clockWiseRotation
        case counterClockWiseRotation
    }
    
    var gesturePattern = [Gestures.rightSwipe, Gestures.twoFingerSwipeDown, Gestures.counterClockWiseRotation]
    var gestureCount = 0
    var easterEggMode = false
    
    func initiate(view:UIView) {
        
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        let clockWiseRotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleClockWiseRotation(_:)))
        view.addGestureRecognizer(clockWiseRotation)
        
        let counterClockWiseRotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleCounterClockWiseRotation(_:)))
        view.addGestureRecognizer(counterClockWiseRotation)
        
        let twoFingerSwipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoFingerSwipeDown(_:)))
        twoFingerSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        twoFingerSwipeDown.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingerSwipeDown)

        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
       if (easterEggMode == false && gesturePattern[gestureCount] == Gestures.longPress) {
            gestureCount += 1
            print("long press detected")
            checkGesturePattern()
        } else {
            gestureCount = 0
        }
    }
    
    func handleClockWiseRotation(sender: UIRotationGestureRecognizer? = nil) {
        if sender?.rotation > 0 {
            if (easterEggMode == false && gesturePattern[gestureCount] == Gestures.clockWiseRotation) {
                gestureCount += 1
                print("clock wise rotation detected")
                checkGesturePattern()
            } else {
                gestureCount = 0
            }
        }
    }
    
    func handleCounterClockWiseRotation(sender: UIRotationGestureRecognizer? = nil) {
        if sender?.rotation < 0 {
            if (easterEggMode == false && gesturePattern[gestureCount] == Gestures.counterClockWiseRotation) {
                gestureCount += 1
                print("counter clock wise rotation detected")
                checkGesturePattern()
            } else {
                gestureCount = 0
            }
        }
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        if (sender!.direction == UISwipeGestureRecognizerDirection.Right) {
            if (easterEggMode == false && gesturePattern[gestureCount] == Gestures.rightSwipe) {
                gestureCount += 1
                print("right swipe detected")
                checkGesturePattern()
            } else {
                gestureCount = 0
            }
        }
    }
    
    func handleTwoFingerSwipeDown(sender: UISwipeGestureRecognizer? = nil) {
        if (sender!.direction == UISwipeGestureRecognizerDirection.Down) {
            if (easterEggMode == false && gesturePattern[gestureCount] == Gestures.twoFingerSwipeDown) {
                gestureCount += 1
                print("swipe down detected")
                checkGesturePattern()
            } else {
                gestureCount = 0
            }
        }
    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // Class Singleton
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
    
    func checkGesturePattern() {
        if ((gesturePattern.count) == gestureCount) {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggScreen()
            easterEggMode = true
        }
    }
    
}