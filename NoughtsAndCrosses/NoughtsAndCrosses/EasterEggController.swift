//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Chris Motz on 6/2/16.
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
    
    
//    enum Gesture:String {
//        case swipeRight = "swipeRight"
//        case twoFingerSwipeDown = "twoFingerSwipeDown"
//        case counterClockwiseRotation = "counterClockwiseRotation"
//    }
    
    var secretCombo = ["swipeRight", "twoFingerSwipeDown", "counterClockwiseRotation"]
    
    var detectedGestures = [String]()
    
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func initiate(view:UIView) {
        let longPress = UILongPressGestureRecognizer(target: self, action:
            #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)

        let swipeRight = UISwipeGestureRecognizer(target: self, action:
            #selector(EasterEggController.handleRightSwipe(_:)))
        view.addGestureRecognizer(swipeRight)

        let twoFingerSwipeDown = UISwipeGestureRecognizer(target: self, action:
            #selector(EasterEggController.twoFingerDownSwipe(_:)))
        twoFingerSwipeDown.numberOfTouchesRequired = 2
        twoFingerSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(twoFingerSwipeDown)
        
        let counterClockwiseRotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleCounterClockwiseRotation(_:)))
        view.addGestureRecognizer(counterClockwiseRotation)
        counterClockwiseRotation.delegate = self

        let clockwiseRotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleClockWiseRotation(_:)))
        view.addGestureRecognizer(clockwiseRotation)
        clockwiseRotation.delegate = self
    }
    
    func twoFingerDownSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("Two finger down swipe")
        detectedGestures.append("twoFingerSwipeDown")
        surpiseMotherfucker()
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
//        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.navigateToEasterEggController()
        print("Long press")
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("Right swipe")
        detectedGestures.append("swipeRight")
        surpiseMotherfucker()
        if (secretCombo == detectedGestures) {
            print("hi)")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggController()
        }
    }
    
    func handleClockWiseRotation(sender: UIRotationGestureRecognizer? = nil) {
    
//        sender!.view!.transform = CGAffineTransformMakeRotation(sender!.rotation)

        if (sender!.rotation > 0) {
            print("Clockwise")

        }
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("Rotation \(sender!.rotation)")
            UIView.animateWithDuration(NSTimeInterval(3), animations: {
                sender!.view!.transform = CGAffineTransformMakeRotation(0)
            })
        }
    }
    
    func handleCounterClockwiseRotation(sender: UIRotationGestureRecognizer? = nil) {
        
//        sender!.view!.transform = CGAffineTransformMakeRotation(sender!.rotation)
        if (sender!.rotation < 0) {
            print("Counter-Clockwise")
            detectedGestures.append("counterClockwiseRotation")
            surpiseMotherfucker()
            print(detectedGestures)


        }
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("Rotation \(sender!.rotation)")
            UIView.animateWithDuration(NSTimeInterval(3), animations: {
                sender!.view!.transform = CGAffineTransformMakeRotation(0)
                
            })
        }
    }
    
    func surpiseMotherfucker() {
        if (secretCombo == detectedGestures) {
            print("hi)")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggController()
        }
    }
}
