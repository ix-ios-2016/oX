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
        
        
        gestureRecognizer(rightSwipe, shouldRecognizeSimultaneouslyWithGestureRecognizer: twoFingerDownSwipe)
//        gestureRecognizer(rotation, shouldRecognizeSimultaneouslyWithGestureRecognizer:  )
    }
    
    func longPressHandler(sender: UILongPressGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            print("LONG PRESSED")
        }
    }
    
    
    
    func twoFingerDownSwipeHandler(sender: UISwipeGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            print("TWO FINGER DOWN SWIPED")
        }
    }
    
    func rightSwipeHandler(sender: UISwipeGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            print("RIGHT SWIPED")
        }
    }
    
    func doubleRotationHandler(sender: UIRotationGestureRecognizer? = nil)
    {
        if sender!.state == UIGestureRecognizerState.Ended
        {
            if sender?.rotation > CGFloat(0)
            {
                print("ROTATED CLOCKWIZE")
            }
            else if sender?.rotation < CGFloat(0)
            {
                print("ROTATED COUNTERCLOCKWIZE")
            }
        }
    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

