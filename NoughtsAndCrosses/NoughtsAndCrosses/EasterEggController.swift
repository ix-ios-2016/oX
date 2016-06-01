//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation

import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {

    enum gesture {
        case a
        case b
        case c
        case d
        case e
    }
    var correctGesture: [gesture] = [.b, .b, .b]
    var currentGesture: [gesture] = []
   
    
    
    func theSame() {
        let length = self.correctGesture.count
        let(start,end) = (self.currentGesture.endIndex - length, self.currentGesture.endIndex)
        if (self.currentGesture.count > length && (currentGesture[start..<end] == correctGesture[0..<length])) {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggScreen()
        } else {
            print("Not the Same")
        }
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
    
    
    func initiate(view:UIView) {
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleSwipeRight))
        view.addGestureRecognizer(swipeRight)
        
        let twoFingerSwipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handletwoFingerSwipeDown))
        twoFingerSwipeDown.numberOfTouchesRequired = 2
        twoFingerSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(twoFingerSwipeDown)
        
        let rotation: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotation)
        
        /*Make Gestures Global
        EasterEggController.sharedInstance.initiate(self.window!)*/
        
    }
    
    //Long Press
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        print("Long Press Detected")
        if sender?.state == UIGestureRecognizerState.Ended {
            self.currentGesture.append(gesture.a)
            theSame()
        }
        self.currentGesture.append(gesture.a)
        theSame()
    }
    //Swipe Right
    func handleSwipeRight(sender: UISwipeGestureRecognizer? = nil) {
        print("Swipe Right Detected")
        if sender?.state == UIGestureRecognizerState.Ended {
        self.currentGesture.append(gesture.b)
        theSame()
        }
    }
    //Two Fingers Down
    func handletwoFingerSwipeDown(sender: UISwipeGestureRecognizer? = nil) {
        print("Swipe Down Detected")
        if sender?.state == UIGestureRecognizerState.Ended {
            self.currentGesture.append(gesture.c)
            theSame()
        }
    
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        
        print("rotation \(sender!.rotation)")
        if sender?.state == UIGestureRecognizerState.Ended {
        //Clockwise or ConuterClockwise
        if sender!.rotation > 0 {
            print("Rotated Clockwise")
            self.currentGesture.append(gesture.d)
            theSame()
        } else if sender!.rotation < 0 {
            print("Rotated CounterClockewise")
            self.currentGesture.append(gesture.e)
            theSame()
        } else {
            print("Didnt move")
        }
        }
        
    }
 
    

    
    
    
}
