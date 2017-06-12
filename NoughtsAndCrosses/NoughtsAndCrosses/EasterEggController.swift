//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    
    var eggSmasher = ["swipeR", "swipeR"]
    var place = 0
    
    
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
    
    
    func initiate(view:UIView)
    {
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(EasterEggController.handlePinch(_:)))
        view.addGestureRecognizer(pinch)
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        let twoFingerDownSwipe = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoFingerDownSwipe(_:)))
        twoFingerDownSwipe.numberOfTouchesRequired = 2
        twoFingerDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(twoFingerDownSwipe)
        
        let leftRightRotation = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleLeftRightRotation(_:)))
        view.addGestureRecognizer(leftRightRotation)
        
        

        
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer? = nil)
    {
        print("pinch detector")
        if (eggSmasher[place] == "pinch")
        {
            place += 1
            checkEggSmashed()
        }
        else
        {
            place = 0
        }
    }

    
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil)
    {
        print("long press detector")
        if (eggSmasher[place] == "long")
        {
            place += 1
            checkEggSmashed()
        }
        else
        {
            place = 0
        }
    }

    func handleRightSwipe(sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .Right)
        {
            print("Swipe Right")
            if (eggSmasher[place] == "swipeR")
            {
                place += 1
                checkEggSmashed()
            }
            else
            {
                place = 0
            }
            
        }
    }
    
    func handleTwoFingerDownSwipe(sender: UILongPressGestureRecognizer? = nil)
    {
        print("two finger down swipe detector")
        if (eggSmasher[place] == "twoD")
        {
            place += 1
            checkEggSmashed()
        }
        else
        {
            place = 0
        }
    }
    
    func handleLeftRightRotation(sender: UIRotationGestureRecognizer? = nil)
    {
        if (sender?.rotation<0)
        {
            print("left rotation")
            if (eggSmasher[place] == "rightr")
            {
                place += 1
                checkEggSmashed()
            }
            else
            {
                place = 0
            }
        }
        else
        {
            print("right rotation")
            if (eggSmasher[place] == "leftr")
            {
                place += 1
                checkEggSmashed()
            }
            else
            {
                place = 0
            }
        }
    }
    

    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }

    
    func checkEggSmashed()
    {
        
        if (place == eggSmasher.endIndex)
        {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToEasterEggScreen()
            place = 0
        }
    }
    
    
}



















