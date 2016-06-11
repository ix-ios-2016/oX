//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate
{
    var correctArray:[String] = [ "long", "right", "doubleDown", "counterclockwise", "clockwise" ]
    var currentArray:[String] = []
    
    //MARK: Class Singleton
    class var sharedInstance: EasterEggController
    {
        struct Static
        {
            static var instance:EasterEggController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)
        {
            Static.instance = EasterEggController()
        }
        
        return Static.instance!
    }
    
    func initiate(view:UIView)
    {
        // Create longPress recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.longPressHandler(_:)))
        view.addGestureRecognizer(longPress)
        // Create rightSwipe recognizer
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.rightSwipeHandler(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        // Create twoFingerDownSwipe recognizer
        let twoFingerDownSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.twoFingerDownSwipeHandler(_:)))
        twoFingerDownSwipe.numberOfTouchesRequired = 2
        twoFingerDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(twoFingerDownSwipe)
        // Create rotation recognizer
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.doubleRotationHandler(_:)))
        view.addGestureRecognizer(rotation)
        //rotation.delegate = self // set the delegate for the rotation to itself to distinguish
        
        gestureRecognizer(rightSwipe, shouldRecognizeSimultaneouslyWithGestureRecognizer: twoFingerDownSwipe)
    }
    
    func longPressHandler(sender: UILongPressGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            print("LONG PRESSED")
            currentArray.append("long")
        }
    }
    
    func rightSwipeHandler(sender: UISwipeGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            print("RIGHT SWIPED")
            currentArray.append("right")
        }
    }
    
    func twoFingerDownSwipeHandler(sender: UISwipeGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            print("TWO FINGER DOWN SWIPED")
            currentArray.append("doubleDown")
        }
    }
    
    func doubleRotationHandler(sender: UIRotationGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            if sender?.rotation < CGFloat(0)
            {
                print("ROTATED COUNTERCLOCKWISE")
                currentArray.append("counterclockwise")
            }
            else if sender?.rotation > CGFloat(0)
            {
                print("ROTATED CLOCKWISE")
                currentArray.append("clockwise")
                
                // Check if the user put in the correct sequence
                self.validate()
            }
        }
    }
    
    func validate() -> Bool
    {
        if currentArray.count < 5
        {
            print("Says it's less than 5 long")
            currentArray.removeAll()
            return false
        }
        else
        {
            if (correctArray[(correctArray.startIndex)..<(correctArray.endIndex)] == currentArray[(currentArray.endIndex - 5)..<(currentArray.endIndex)])
            {
                print("HOLY BENIDAS!")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToEasterEggViewController()
                return true
            }
            else
            {
                print("Says they're not equal")
                currentArray.removeAll()
                return false
            }
        }
    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

