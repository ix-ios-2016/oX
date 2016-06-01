//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Ingrid Polk on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var series = [Gestures]()
    
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
        case longPress
        case rightSwipe
        case twoFingerDownSwipe
        case clockwiseRotation
        case counterClockwiseRotation
    }
    
    var correctSeries = [Gestures](arrayLiteral: Gestures.rightSwipe, Gestures.clockwiseRotation, Gestures.longPress)
    
    func initiate(view:UIView) {
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(EasterEggController.handleLongPress(_:)))
        view.addGestureRecognizer(longPress)
        
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        
        let twoFingerDownSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EasterEggController.handleTwoFingerDownSwipe(_:)))
        twoFingerDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
        twoFingerDownSwipe.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingerDownSwipe)

        let rotationVar: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EasterEggController.handleRotation(_:)))
        view.addGestureRecognizer(rotationVar)
        
        print(correctSeries)
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer? = nil) {
        print("longPress")
        if sender!.state == UIGestureRecognizerState.Ended {
            series.append(EasterEggController.Gestures.longPress)
            print(series)
        }
        if series == correctSeries {
            appDelegate.navigateToEasterEggScreen()
            series = []
        }
    }
    
    func handleRightSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("right swipe")
        if sender!.state == UIGestureRecognizerState.Ended {
            series.append(EasterEggController.Gestures.rightSwipe)
            print(series)
        }
        if series == correctSeries {
            appDelegate.navigateToEasterEggScreen()
            series = []
        }
    }
    
    func handleTwoFingerDownSwipe(sender: UISwipeGestureRecognizer? = nil) {
        print("2 finger down")
        if sender!.state == UIGestureRecognizerState.Ended {
            series.append(EasterEggController.Gestures.twoFingerDownSwipe)
            print(series)
        }
        if series == correctSeries {
            appDelegate.navigateToEasterEggScreen()
            series = []
        }
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer? = nil) {
        if sender?.rotation > 0 {
            print ("clockwise")
            if sender!.state == UIGestureRecognizerState.Ended {
                series.append(EasterEggController.Gestures.clockwiseRotation)
                print(series)
            }
            if series == correctSeries {
                appDelegate.navigateToEasterEggScreen()
                series = []
            }
        } else if sender?.rotation < 0 {
            print ("counterclockwise")
            if sender!.state == UIGestureRecognizerState.Ended {
                series.append(EasterEggController.Gestures.counterClockwiseRotation)
                print(series)
            }
            if series == correctSeries {
                appDelegate.navigateToEasterEggScreen()
                series = []
            }
        }
    }
    func refresh() {
        series = []
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}