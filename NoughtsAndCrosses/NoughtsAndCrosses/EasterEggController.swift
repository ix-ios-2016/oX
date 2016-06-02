//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-06-01.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

enum gesture: Int {
    case CLOCKWISE = 0
    case DOWN = 1
    case RIGHT = 2
    case COUNTERCLOCKWISE = 3
    case LONG = 4
}

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    var correctOrder: [gesture] = [gesture.CLOCKWISE, gesture.DOWN, gesture.RIGHT]
    var currentOrder: [gesture] = []
    
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
        
        // initialize gesture recognizers
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        
        let twoFingerDownSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoFingerDownSwipe(_:)))
        twoFingerDownSwipe.numberOfTouchesRequired = 2
        twoFingerDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleRotation(_:)))
        rotation.delegate = self
//        let clockWiseRotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleClockWiseRotation(_:)))
//        
//        let counterClockWiseRotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleCounterClockWiseRotation(_:)))
        
        // add gesture recognizers to view
        view.addGestureRecognizer(longPress)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(twoFingerDownSwipe)
        view.addGestureRecognizer(rotation)
//        view.addGestureRecognizer(clockWiseRotation)
//        view.addGestureRecognizer(counterClockWiseRotation)
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Ended) {
            self.currentOrder.append(gesture.LONG)
        }
        print("long press")
        self.validate()
        
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Ended) {
            self.currentOrder.append(gesture.RIGHT)
        }
        print("right swipe")
        self.validate()
        
    }
    
    func handleTwoFingerDownSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Ended) {
            self.currentOrder.append(gesture.DOWN)
        }
        print("two finger down swipe")
        self.validate()
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer) {
        if (sender.rotation > 0) {
//            print("clock wise rotation")
            if (sender.state == UIGestureRecognizerState.Ended) {
                print("clock wise rotation")

                self.currentOrder.append(gesture.CLOCKWISE)
            }
        } else {
//            print("counter clock wise rotation")
            if (sender.state == UIGestureRecognizerState.Ended) {
                self.currentOrder.append(gesture.COUNTERCLOCKWISE)
                print("counter clock wise rotation")
            }
        }
        self.validate()
    }
    
//    func handleClockWiseRotation(sender: UIRotationGestureRecognizer) {
//        if (sender.rotation > 0) {
//            print("clock wise rotation")
//        }
//        self.validate()
//    }
//    
//    func handleCounterClockWiseRotation(sender: UIRotationGestureRecognizer) {
//        if (sender.rotation < 0) {
//            print("counter clock wise rotation")
//        }
//        self.validate()
//    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("HERE")
        return true
    }
    
    func validate() {
        let length = self.correctOrder.count
        let (start, end) = (self.currentOrder.endIndex - length, self.currentOrder.endIndex)
        if (self.currentOrder.count >= length &&
            self.currentOrder[start..<end] == self.correctOrder[0..<length]) {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggScreen()
            self.currentOrder = []
        }
    }
    
    
    
//    func appendToOrder(nextGesture: gesture) {
//        if (currentOrder == []) {
//            self.currentOrder.append(nextGesture)
//        } else if (nextGesture != self.currentOrder[self.currentOrder.endIndex - 1]) {
//            self.currentOrder.append(nextGesture)
//        }
//    }
    
}