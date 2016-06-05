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
    
    enum Gestures {
        case LongPress
        case RightSwipe
        case LeftSwipe
        case TwoDownSwipe
        case ClockwiseRotation
        case CounterRotation
        case Reset
    }
    
    var code: [Gestures] = [Gestures.LeftSwipe, Gestures.RightSwipe, Gestures.CounterRotation, Gestures.ClockwiseRotation, Gestures.LongPress, Gestures.TwoDownSwipe, Gestures.TwoDownSwipe]
    var nextGestureIndex: Int = 0
    
    
    // initialize Easter Egg gesture recognition on a specified view
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
        
        rotation.delegate = self
    }
    
    
    // gesture with id
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        
        if sender!.state == UIGestureRecognizerState.Began {
            if nextGestureIndex < code.count && code[nextGestureIndex] == Gestures.LongPress {
                if nextGestureIndex == code.count - 1 {
                    nextGestureIndex = 0
                    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.navigateToEasterEgg()
                }
                else {
                    nextGestureIndex += 1
                }
            }
            else if code[0] == Gestures.LongPress {
                nextGestureIndex = 1
            }
            else {
                nextGestureIndex = 0
            }
}
    }
    
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        
        if nextGestureIndex < code.count && code[nextGestureIndex] == Gestures.RightSwipe {
            if nextGestureIndex == code.count - 1 {
                nextGestureIndex = 0
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToEasterEgg()
            }
            else {
                nextGestureIndex += 1
            }
        }
        else if code[0] == Gestures.RightSwipe {
            nextGestureIndex = 1
        }
        else {
            nextGestureIndex = 0
        }
    }
    
    func handleLeftSwipe(sender: UISwipeGestureRecognizer? = nil) {
        
        if nextGestureIndex < code.count && code[nextGestureIndex] == Gestures.LeftSwipe {
            if nextGestureIndex == code.count - 1 {
                nextGestureIndex = 0
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToEasterEgg()
            }
            else {
                nextGestureIndex += 1
            }
        }
        else if code[0] == Gestures.LeftSwipe {
            nextGestureIndex = 1
        }
        else {
            nextGestureIndex = 0
        }
    }
    
    func handleTwoDownSwipe(sender: UISwipeGestureRecognizer? = nil) {
        
        if nextGestureIndex < code.count && code[nextGestureIndex] == Gestures.TwoDownSwipe {
            if nextGestureIndex == code.count - 1 {
                nextGestureIndex = 0
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToEasterEgg()
            }
            else {
                nextGestureIndex += 1
            }
        }
        else if code[0] == Gestures.TwoDownSwipe {
            nextGestureIndex = 1
        }
        else {
            nextGestureIndex = 0
        }
    }

    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        if sender!.state == UIGestureRecognizerState.Ended && sender?.rotation < 0 {
            
            if nextGestureIndex < code.count && code[nextGestureIndex] == Gestures.CounterRotation {
                if nextGestureIndex == code.count - 1 {
                    nextGestureIndex = 0
                    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.navigateToEasterEgg()
                }
                else {
                    nextGestureIndex += 1
                }
            }
            else if code[0] == Gestures.CounterRotation {
                nextGestureIndex = 1
            }
            else {
                nextGestureIndex = 0
            }

        }
        else if sender!.state == UIGestureRecognizerState.Ended && sender?.rotation > 0 {
            
            if nextGestureIndex < code.count && code[nextGestureIndex] == Gestures.ClockwiseRotation {
                if nextGestureIndex == code.count - 1 {
                    nextGestureIndex = 0
                    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.navigateToEasterEgg()
                }
                else {
                    nextGestureIndex += 1
                }
            }
            else if code[0] == Gestures.ClockwiseRotation {
                nextGestureIndex = 1
            }
            else {
                nextGestureIndex = 0
            }
        }
    }

    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
