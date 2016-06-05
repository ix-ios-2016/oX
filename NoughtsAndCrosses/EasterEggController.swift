//
//  EasterEggController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit

class EasterEggController: NSObject, UIGestureRecognizerDelegate {


    enum gestures {
    
        case CCWRotation
        case CWRotation
        case rightSwipe
        case twoFingerDownSwipe
        case longPress
    
    }
    
    let correctGestures = [gestures.longPress , gestures.rightSwipe, gestures.twoFingerDownSwipe]
    
    var gestureHistory : [gestures] = []
    
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
        
        //TODO: Recognize clockwise and counterclockwise rotations!!
         let rotation : UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action:#selector(EasterEggController.handleRotation(_:)))
         view.addGestureRecognizer(rotation)
         rotation.delegate = self //listens to the rotation gesture recognizer

         //A rightward swipe is the default direction
         let rightSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(EasterEggController.handleRightSwipe(_:)))
         view.addGestureRecognizer(rightSwipe)

        
         let twoFingerDownSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(EasterEggController.handleTwoFingerDownSwipe(_:)))
        twoFingerDownSwipe.direction = UISwipeGestureRecognizerDirection.Down
         twoFingerDownSwipe.numberOfTouchesRequired = 2
         view.addGestureRecognizer(twoFingerDownSwipe)

         twoFingerDownSwipe.delegate = self
        
         let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(EasterEggController.handleLongPress(_:)))
        longPress.delaysTouchesBegan = true
         view.addGestureRecognizer(longPress)
    }
    
    //Correct order of gesture: long press, rightSwipe, twoFingerDownSwipe, counterClockWiseRotation, clockwiseRotation
    
    func handleLongPress (sender : UILongPressGestureRecognizer? = nil) {
        //lastGesture = gestures.longPress
        
        if (sender!.state == UIGestureRecognizerState.Ended) {
            print("Long Press Recognized")
            gestureHistory.append(gestures.longPress)
            //checker ()
        }
        
    }
    func handleRightSwipe (sender : UISwipeGestureRecognizer? = nil) {
        //self.lastGesture = gesture.rightSwipe
        print("Right Swipe Recognized!")
        gestureHistory.append(gestures.rightSwipe)
        //checker ()
       
    }
    
    func handleTwoFingerDownSwipe (sender : UISwipeGestureRecognizer? = nil) {
        //self.lastGesture = gesture.twoFingerDownSwipe
        
        gestureHistory.append(gestures.twoFingerDownSwipe)
        checker()
        

        print("Swipe gesture recognized (is it two finger and down?)!!")
    }
    
    func handleRotation(sender : UIRotationGestureRecognizer? = nil) {
       
        //self.lastGesture = gesture.rotation
        if (sender!.state == UIGestureRecognizerState.Ended) {
            
            if (sender!.rotation < 0){
             //   self.lastGesture = gesture.CCWRotation
                print("CCWR!!!")
            } else {
            //    self.lastGesture = gesture.CWRotation
                print("CWR!!!!")
            }
            
          
            
        }

    }
    
    func checker () {
        if (correctGestures == gestureHistory) {
            print("HEEEEY")
            
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //as! casts this returned value to type AppDelegate
            
            appDelegate.navigateToEasterEggScreen()
        } else {
//            gestureHistory.removeAll()
        }
    }
    
    //Allow to recognize multiple gestures of the same type
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

