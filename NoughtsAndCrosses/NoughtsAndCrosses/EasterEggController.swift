//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Ryan Davey on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//
import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    enum gesture {
        case rotateA
        case rotateB
        
        case none
    }
    var lastStroke = gesture.none
    
    // variable for starting rotation
    var lastSnap = CGFloat(0)
    
    func initiate (board:UIView) {
        // Setting up recognition of gestures
        // create an instance of UIRotationGestureRecognizer
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "handleRotation:")
        board.addGestureRecognizer(rotation)
        let longpress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        board.addGestureRecognizer(longpress)
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        board.addGestureRecognizer(swipe)
        swipe.direction = UISwipeGestureRecognizerDirection.Down
        let twofingerswipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer (target: self, action: "handleTwoFingerSwipe")
        board.addGestureRecognizer(twofingerswipe)
        twofingerswipe.numberOfTouchesRequired == 2
        twofingerswipe.direction = UISwipeGestureRecognizerDirection.Down
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("rotation \(sender!.rotation)")
            if (sender!.rotation > CGFloat(0)) {
                self.lastStroke = gesture.rotateA
                print("clockwise rotation detected")
            }
            else if (self.lastStroke == gesture.rotateA) && (sender!.rotation < CGFloat(0)) {
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToEasterEggNavigationController()
                self.lastStroke = gesture.rotateB
                print("counterclockwise rotation detected")
            }
        }
    }
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
            print("long press detected")
    }
    func handleSwipe(sender: UISwipeGestureRecognizer? = nil) {
            print("right swipe detected")
    }
    func handleTwoFingerSwipe(sender: UISwipeGestureRecognizer? = nil) {
            print("two finger swipe detected")
    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    
    
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
    
    
}